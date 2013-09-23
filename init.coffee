# 加载 fs 库，用于文件读写，这是 nodejs 的内置库
fs = require 'fs'
# 加载第三方库
tbl = require './lib/tbls'
# 注册自定义的 helper，用于在 handlebars 模板中将字符串小写
Handlebars.registerHelper 'lowerCase', (x) -> x.toLowerCase()
# 注册 join helper，用于 EntityMapper.xml.tpl 的生成
Handlebars.registerHelper 'join',(context, options) -> 
    result = []
    sep = options.hash['sep'] or ','
    s = options.hash['start']^0
    data = null
    j = context.length

    for i in [s..j-1]
        if options.data
            data = Handlebars.createFrame options.data or {}
            data.index = i
            if i is j - 1
                data.last = true
            else
                data.last = false        
        result.push options.fn context[i], data: data
    result.join sep

$ ->
    dir = localStorage.path
    if dir
        $('#target').html dir

    tpls = [
        ['EntityController.java', '{{package}}.controller.{{class}}Controller.java'],
        ['IEntityService.java', '{{package}}.service.I{{class}}Service.java'],
        ['EntityService.java', '{{package}}.service.impl.{{class}}ServiceImpl.java'],
        ['IEntityMapper.java', '{{package}}.persistence.I{{class}}Mapper.java'],
        ['EntityMapper.xml', '{{package}}.persistence.mapper.{{class}}Mapper.xml']
        ]
    compilers = []
    $txtClass = $ '#txtClass'
    $txtPkg = $ '#txtPkg'
    $txtFields = $ '#txtFields'
    $txtFFields = $ '#txtFFields'
    $txtQFields = $ '#txtQFields'
    $tpls = $('#entry-template')
    tplsCompiler = Handlebars.compile $tpls.html()
    sources = null

    cp = (tpl) ->
        source_tpl = fs.readFileSync 'tpls/' + tpl[0] + '.tpl','utf8'
        source_compiler = Handlebars.compile source_tpl
        name_compiler = Handlebars.compile tpl[1]

        compilers.push source: source_compiler,name: name_compiler

    _.each tpls,cp

    get_list = ($, sep) ->
        val = $.val().trim()
        if val is ''
            return false
        val.split(sep or ',')

    onBtnCreateHandler = (event) ->
        sources = []
        _.each compilers, (compiler) =>
            source_compiler = compiler.source
            name_compiler = compiler.name
            pkg = $txtPkg.val()
            klass = $txtClass.val()
            fields = get_list $txtFields
            fFields = get_list $txtFFields
            qFields = get_list $txtQFields
            context = 
                'package': pkg,
                'class': klass,
                'fields': fields,
                'fFields': fFields,
                'qFields': qFields
            name = name_compiler context
            source = source_compiler context

            sources.push
                title: name,
                content: source

        html = tplsCompiler sources: sources

        $('#content').empty().html(html)

        $('.java').each (i,e) ->
            hljs.highlightBlock e

        $('#btnDl').removeAttr('disabled').html('生成代码').css 'color','black'

    onTargetChange = ->
        localStorage.path = this.value
        $('#target').html this.value

    onBtnTargetClick = ->
        $('#targetDir').click()

    onBtnDlClick = ->
        _.each sources, (source) =>
            file = source.title
            content = source.content
            tbl.save localStorage.path.split('/').join('.') + '/' + file,
                _.unescape(content)
        $('#btnDl').html('代码已生成！').attr('disabled',true).css 'color','red'

    $('#btnCreate').click onBtnCreateHandler
    $('#targetDir').change onTargetChange
    $('#btnTarget').click onBtnTargetClick
    $('#btnDl').click onBtnDlClick
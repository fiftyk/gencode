//加载nodejs fs module
var fs = require('fs');
var tbl = require('./lib/tbls');

Handlebars.registerHelper('lowerCase', function(str) {
  return str.toLowerCase();
});

Handlebars.registerHelper('join', function(context, options) {
  var result = [], sep = options.hash['sep']||',',
    s = options.hash['start']^0, data;
  for(var i=s, j=context.length; i<j; i++) {
    if (options.data) {
      data = Handlebars.createFrame(options.data || {});
      data.index = i;
      if(i == (j - 1)){
        data.last = true;
      }else{
        data.last = false;
      }
    }

    result.push(options.fn(context[i], { data: data }));
  }
  return result.join(sep);
});

$(function(){
    var dir = localStorage.path;
    if(dir){
        $('#target').html(dir);
    }

    var tpls = [
        ['EntityController.java', '{{package}}.controller.{{class}}Controller.java'],
        ['IEntityService.java', '{{package}}.service.I{{class}}Service.java'],
        ['EntityService.java', '{{package}}.service.impl.{{class}}ServiceImpl.java'],
        ['IEntityMapper.java', '{{package}}.persistence.I{{class}}Mapper.java'],
        ['EntityMapper.xml', '{{package}}.persistence.mapper.{{class}}Mapper.xml']
        ],
        compilers = [],
        $txtClass = $('#txtClass'),
        $txtPkg = $('#txtPkg'),
        $txtFields = $('#txtFields'),
        $txtFFields = $('#txtFFields'),
        $txtQFields = $('#txtQFields'),
        
        $tpls = $('#entry-template'),
        tplsCompiler = Handlebars.compile($tpls.html()),

        sources = null;

    var cp = function(tpl){
        //读取本地模板文件
        var source_tpl = fs.readFileSync('tpls/' + tpl[0] + '.tpl','utf8'),
            source_compiler = Handlebars.compile(source_tpl),
            name_compiler = Handlebars.compile(tpl[1]);

        compilers.push({
            source: source_compiler,
            name: name_compiler
        });
    };

    //加载并编译模板
    _.each(tpls, cp);

    var onBtnCreateHandler = function(){
        sources = [];
        _.each(compilers,function(compiler){
            var source_compiler = compiler.source,
                name_compiler = compiler.name,
                pkg = $txtPkg.val(),
                klass = $txtClass.val(),
                fields = $txtFields.val().split(','),
                fFields = $txtFFields.val().split(','),
                qFields = $txtQFields.val().split(','),
                context = {
                    'package': pkg,
                    'class': klass,
                    'fields': fields,
                    'fFields': fFields,
                    'qFields': qFields
                },
                name = name_compiler(context),
                source = source_compiler(context);

            sources.push({
                title: name,
                content: source
            });
        });
        
        var html = tplsCompiler({
            sources: sources
        });

        $('#content').empty().html(html);

        $('.java').each(function(i, e) {
            hljs.highlightBlock(e)
        });
    };

    var onTargetChange = function() {
        localStorage.path = this.value;
        $('#target').html(this.value);
    };

    var onBtnTargetClick = function(){
        $('#targetDir').click();
    };

    var onBtnDlClick = function(){
        _.each(sources, function(source){
            var file = source.title, content = source.content;
            tbl.save(
                localStorage.path.split('/').join('.') + '/' + file,
                _.unescape(content)
            ); 
        });

        alert('创建完成!');
    };

    $('#btnCreate').click(onBtnCreateHandler);
    $('#targetDir').change(onTargetChange);
    $('#btnTarget').click(onBtnTargetClick);
    $('#btnDl').click(onBtnDlClick);

});

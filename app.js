//加载nodejs fs module
var fs = require('fs');
var tbl = require('./lib/tbls');

Handlebars.registerHelper('lowerCase', function(str) {
  return str.toLowerCase();
});

Handlebars.registerHelper('join', function(context, options) {

  var result = [];
  for(var i=0, j=context.length; i<j; i++) {
    result.push(options.fn(context[i]));
  }

  return result.join(',');
});

$(function(){
    var tpls = [
        // ['EntityController.java', '{{package}}.controller.{{class}}Controller.java'],
        // ['IEntityService.java', '{{package}}.service.I{{class}}Service.java'],
        // ['EntityService.java', '{{package}}.service.impl.{{class}}ServiceImpl.java'],
        // ['IEntityMapper.java', '{{package}}.persistence.I{{class}}Mapper.java'],
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

    for(var i = 0, len = tpls.length; i < len; i++){
        //读取本地模板文件
        var source_tpl = fs.readFileSync('tpls/' + tpls[i][0] + '.tpl','utf8'),
            source_compiler = Handlebars.compile(source_tpl),
            name_compiler = Handlebars.compile(tpls[i][1]);

        compilers.push({
            source: source_compiler,
            name: name_compiler
        });
    }

    var onBtnCreateHandler = function(){
        sources = [];
        for(var i = 0, len = compilers.length; i < len; i++){
            var source_compiler = compilers[i].source,
                name_compiler = compilers[i].name,
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
        };
        
        var html = tplsCompiler({
            sources: sources
        });

        $('#content').empty().html(html);

        $('.java').each(function(i, e) {
            hljs.highlightBlock(e)
        });
    };

    $('#btnCreate').click(onBtnCreateHandler);

    $('#targetDir').bind("change", function() {
      process.chdir(this.value);
      $('#target').html(this.value);
    });

    $('#btnTarget').click(function(){
        $('#targetDir').click();
    });

    $('#btnDl').click(function(){
        var file = $('#txtPkg').val() + '.persistence.I' + $('#txtClass').val() + 'Mapper';

        for(var i = 0, size = sources.length; i < size; i++){
            var source = sources[i],
                file = source.title,
                content = source.content;
            tbl.save(file, _.unescape(content), function(){
                
            });  
        }
        
        alert('创建完成!');
                
    });

});

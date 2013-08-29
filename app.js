//加载nodejs fs module
var fs = require('fs');

Handlebars.registerHelper('toLowerCase', function(str) {
    console.log(str);
  return str.toLowerCase() + 's';
});

$(function(){
    var tpls = [
        ['EntityController.java', '{{package}}.controller.{{class}}Controller.java'],
        ['IEntityService.java', '{{package}}.service.I{{class}}Service.java'],
        ['EntityService.java', '{{package}}.service.impl.{{class}}Service.java'],
        ['IEntityMapper.java', '{{package}}.persistence.I{{class}}Mapper.java'],
        ['EntityMapper.xml', '{{package}}.persistence.mapper.{{class}}Mapper.xml']
        ],
        compilers = [],
        $txtClass = $('#txtClass'),
        $txtPkg = $('#txtPkg'),
        $tpls = $('#entry-template'),
        tplsCompiler = Handlebars.compile($tpls.html());

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
        var sources = [];
        for(var i = 0, len = compilers.length; i < len; i++){
            var source_compiler = compilers[i].source,
                name_compiler = compilers[i].name,
                pkg = $txtPkg.val(),
                klass = $txtClass.val(),
                context = {
                    'package': pkg,
                    'class': klass
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

});

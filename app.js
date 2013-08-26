//加载nodejs fs module
var fs = require('fs');

$(function(){    
    //var tpl = $('#entry-template').html();

    //使用同步的方式直接从文件读取模板
    var tpl = fs.readFileSync('tpls/mapper.tpl','utf8');

    var compiler = Handlebars.compile(tpl);

    var source = '';

    $('#btnCreate').click(function(){
        source = compiler({
            'class': $('#txtClass').val(),
            'package': $('#txtPkg').val()
        });

        //_.escape 是 underscore.js 的方法
        $('#export').html(_.escape(source));

        $('#export').each(function(i, e) {hljs.highlightBlock(e)});
    });

    $('#btnDl').bind('click', function(){
        //异步方式创建打开文件，并写入数据
        fs.open('c:/' + $('#txtClass').val() + '.java', 'w', 0777, function(e, fd){

            //_.unescape 是 underscore.js 的方法
            fs.write(fd, _.unescape(source), 0, 'utf8',function(){
                fs.closeSync(fd);
            });

        });
    });

});
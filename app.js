//加载nodejs fs module
var fs = require('fs');

$(function(){

    //使用同步的方式直接从文件读取模板
    var tpl = fs.readFileSync('tpls/IEntityMapper.java.tpl','utf8'),//读取模板
        compiler = Handlebars.compile(tpl),//编译模板
        source = null,//保存生成代码
        target_dir = null,//保存代码路径
        klass = null,//保存填写的类名
        pkg = null,//保存填写的包名
        $txtClass = $('#txtClass'),
        $txtPkg = $('#txtPkg'),
        $btnDl = $('#btnDl'),
        $targetDir = $('#targetDir');

    //创建按钮单击事件处理函数
    var onBtnCreateClick = function(){
        klass = $txtClass.val();
        pkg = $txtPkg.val();

        source = compiler({
            'class': klass,
            'package': pkg
        });

        //_.escape 是 underscore.js 的方法
        $('#export')
            .html(_.escape(source))
            .each(function(i, e) {hljs.highlightBlock(e)});
    };

    //下载按钮单击事件处理函数
    var onBtnDlClick = function(){
        if(!source){
          alert('请先生成代码!');
          return;  
        } 
        
        //异步方式创建打开文件，并写入数据
        fs.open(target_dir + '/' + klass + '.java', 'w', 0777, function(e, fd){

            //_.unescape 是 underscore.js 的方法
            fs.write(fd, _.unescape(source), 0, 'utf8',function(){
                fs.closeSync(fd);
                alert('代码生成!');
            });

        });
    };

    var onTargetDirChange = function(){
        target_dir = this.value;
        $('#target').html(target_dir);
        $btnDl.removeAttr('disabled');
    };

    var onBtnSaveAsClick = function(){
        $targetDir.click();
    };

    $('#btnCreate').click(onBtnCreateClick);

    $btnDl.bind('click', onBtnDlClick);

    $targetDir.bind('change', onTargetDirChange);

    $('#btnSaveAs').bind('click', onBtnSaveAsClick);

});
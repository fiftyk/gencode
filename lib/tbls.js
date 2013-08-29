var fs = require('fs');
var p = /.(\w+)$/;

var mkdirSync = function(url,mode,cb){
    var path = require("path"), arr = url.split("/");
    mode = mode || 0755;
    cb = cb || function(){};
    if(arr[0]==="."){//处理 ./aaa
        arr.shift();
    }
    if(arr[0] == ".."){//处理 ../ddd/d
        arr.splice(0,2,arr[0]+"/"+arr[1])
    }
    function inner(cur){
        if(!fs.existsSync(cur)){//不存在就创建一个
            fs.mkdirSync(cur, mode)
        }
        if(arr.length){
            inner(cur + "/"+arr.shift());
        }else{
            cb();
        }
    }
    arr.length && inner(arr.shift());
};

exports.save = function(path,source,cb){
    var list = path.split('.'), p = [], p1 = [];
    for(var i = 0, size = list.length; i < size; i++){
        if(i < size - 2){
            p.push(list[i]);
        }else{
            p1.push(list[i]);
        }
        
    }

    var pkg = p.join('/');
    var klass = p1.join('.');
    
    mkdirSync(pkg);

    fs.open(pkg +'/'+ klass, 'w', 0777, function(e, fd){

        //_.unescape 是 underscore.js 的方法
        fs.write(fd, source, 0, 'utf8',function(){
            fs.closeSync(fd);
        });

    });

    cb();
};

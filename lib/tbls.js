var fs = require('fs')
var mkdirp = require('mkdirp');

exports.save = function(path,source,cb){
    var list = path.split('.'), p = [], p1 = [];
    for(var i = 0, size = list.length; i < size; i++){
        if(i < size - 2){
            p.push(list[i]);
        }else{
            p1.push(list[i]);
        }
    }

    var pkg = p.join('/'), klass = p1.join('.');

    mkdirp.sync(pkg, 0777);

    fs.open(pkg +'/'+ klass, 'w', 0777, function(e, fd){

        fs.write(fd, source, 0, 'utf8',function(){
            fs.closeSync(fd);
        });

    });

    if(typeof cb === 'function') cb();
};

package {{ package }}.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.yhte.common.result.JSONRenderer;
import {{ package }}.domain.{{ class }};
import {{ package }}.domain.{{ class }}Query;
import {{ package }}.service.I{{ class }}Service;

@Controller
@RequestMapping("/{{ class }}s")
public class {{ class }}Controller {
    
    @Autowired
    private I{{ class }}Service service;
    
    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public JSONRenderer query({{ class }}Query query){
        return service.query(query);
    }
    
    @RequestMapping(value="/{id}", method = RequestMethod.GET)
    @ResponseBody
    public JSONRenderer get(@PathVariable String id){
        return service.get(id);
    }

    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public JSONRenderer append(@RequestBody {{ class }} {{ class }}){
        return service.append({{ class }});
    }
    
    @RequestMapping(value="/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public JSONRenderer delete(@PathVariable String id){
        return service.delete(id);
    }
    
    @RequestMapping(method = RequestMethod.DELETE)
    @ResponseBody
    public JSONRenderer batchDelete(@RequestParam(value="ids") List<Integer> ids){
        return service.batchDelete(ids);
    }

    @RequestMapping(value="/{id}", method = RequestMethod.PUT)
    @ResponseBody
    public JSONRenderer update(@RequestBody {{ class }} {{ class }}){
        return service.update({{ class }});
    }
    
}

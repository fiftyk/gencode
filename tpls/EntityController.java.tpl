package {{ package }}.controller;

import java.util.List;

import net.yhte.common.query.XQuery;
import net.yhte.common.result.JSONRenderer;
import {{ package }}.domain.{{ class }};
import {{ package }}.service.I{{ class }}Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/{{lowerCase class }}s")
public class {{ class }}Controller {

    @Autowired
    private I{{ class }}Service service;

    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public JSONRenderer query(XQuery query) {
        return service.query(query);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    @ResponseBody
    public JSONRenderer get(@PathVariable int id) {
        return service.get(id);
    }

    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public JSONRenderer append(@RequestBody {{ class }} entity) {
        return service.append(entity);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public JSONRenderer delete(@PathVariable int id) {
        return service.delete(id);
    }

    @RequestMapping(method = RequestMethod.DELETE)
    @ResponseBody
    public JSONRenderer batchDelete(
            @RequestParam(value = "ids") List<Integer> ids) {
        return service.batchDelete(ids);
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.PUT)
    @ResponseBody
    public JSONRenderer update(@RequestBody {{ class }} entity) {
        return service.update(entity);
    }

}

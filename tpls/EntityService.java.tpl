package {{ package }}.service.impl;

import java.util.List;

import net.yhte.common.query.XQuery;
import net.yhte.common.result.JSONRenderer;
import {{ package }}.domain.{{ class }};
import {{ package }}.persistence.I{{ class }}Mapper;
import {{ package }}.service.I{{ class }}Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class {{ class }}ServiceImpl implements I{{ class }}Service {
    
    @Autowired
    private I{{ class }}Mapper mapper;
    
    @Override
    public JSONRenderer query(XQuery query) {
        try {
            List<{{ class }}> enties = mapper.query(query);
            int count = mapper.count(query);
            return JSONRenderer.OK(enties, count);
        } catch (Exception e) {
            e.printStackTrace();
            return JSONRenderer.ERROR(e);
        }
    }

    @Override
    public JSONRenderer get(int id) {
        try {
            {{ class }} entity = mapper.get(id);
            return JSONRenderer.OK(entity);
        } catch (Exception e) {
            e.printStackTrace();
            return JSONRenderer.ERROR(e);
        }
    }

    @Override
    public JSONRenderer append({{ class }} entity) {
        try {
            mapper.append(entity);
            return JSONRenderer.OK(entity);
        } catch (Exception e) {
            e.printStackTrace();
            return JSONRenderer.ERROR(e);
        }
    }

    @Override
    public JSONRenderer delete(int id) {
        try {
            Boolean bool = mapper.delete(id);
            return JSONRenderer.OK(bool);
        } catch (Exception e) {
            e.printStackTrace();
            return JSONRenderer.ERROR(e);
        }
    }

    @Override
    public JSONRenderer batchDelete(List<Integer> ids) {
        try {
            Boolean bool = mapper.batchDelete(ids);
            return JSONRenderer.OK(bool);
        } catch (Exception e) {
            e.printStackTrace();
            return JSONRenderer.ERROR(e);
        }
    }

    @Override
    public JSONRenderer update({{ class }} entity) {
        try {
            Boolean bool = mapper.update(entity);
            return JSONRenderer.OK(bool);
        } catch (Exception e) {
            e.printStackTrace();
            return JSONRenderer.ERROR(e);
        }
    }
}

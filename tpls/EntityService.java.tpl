package {{ package }}.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.yhte.common.result.JSONRenderer;
import {{ package }}.domain.{{ class }};
import {{ package }}.domain.{{ class }}Query;
import {{ package }}.persistence.I{{ class }}Mapper;
import {{ package }}.service.I{{ class }}Service;

@Service
@Transactional
public class {{ class }}ServiceImpl implements I{{ class }}Service {
    
    @Autowired
    private I{{ class }}Mapper mapper;
    
    @Override
    public JSONRenderer query({{ class }}Query query) {
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
    public JSONRenderer get(String id) {
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
    public JSONRenderer delete(String id) {
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

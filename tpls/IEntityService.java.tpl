package {{ package }}.service;

import java.util.List;

import net.yhte.common.result.JSONRenderer;
import {{ package }}.domain.{{ class }};
import {{ package }}.domain.{{ class }}Query;

public interface I{{ class }}Service {
    JSONRenderer query({{ class }}Query query);
    JSONRenderer get(String id);
    JSONRenderer append({{ class }} entity);
    JSONRenderer delete(String id);
    JSONRenderer batchDelete(List<Integer> ids);
    JSONRenderer update({{ class }} entity);
}

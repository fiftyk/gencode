package {{ package }}.persistence;

import java.util.List;

import {{ package }}.domain.{{ class }};
import {{ package }}.domain.{{ class }}Query;

public interface I{{ class }}Mapper {
  
  List<{{ class }}> query({{ class }}Query query);
  Boolean delete(String id);
  Boolean append({{ class }} entity);
  {{ class }} get(String id);
  Boolean update({{ class }} entity);
  Boolean batchDelete(List<Integer> ids);
  
}
package {{ package }}.persistence;

import java.util.List;

import {{ package }}.domain.{{ class }};
import {{ package }}.domain.{{ class }}Query;

public interface I{{ class }}Mapper {
  List<{{ class }}> query({{ class }}Query query);
  int count({{ class }}Query query);
  {{ class }} get(String id);
  int append({{ class }} entity);
  Boolean delete(String id);
  Boolean batchDelete(List<Integer> ids);
  Boolean update({{ class }} entity);
}

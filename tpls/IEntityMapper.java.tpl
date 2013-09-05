package {{ package }}.persistence;

import java.util.List;

import net.yhte.common.IMapper;
import net.yhte.common.query.XQuery;
import {{ package }}.domain.{{ class }};

public interface I{{ class }}Mapper extends IMapper {
    /**
     * 查询记录
     * @param query 查询参数
     * @return 记录列表
     */
    List<{{ class }}> query(XQuery query);
    /**
     * 查询单条记录详细
     * @param id 记录 id
     * @return 记录详细
     */
    {{ class }} get(int id);
    /**
     * 添加记录
     * @param entity 记录
     * @return 添加记录的 id
     */
    int append({{ class }} entity);
    /**
     * 更新单条记录
     * @param entity 记录
     * @return 是否成功
     */
    Boolean update({{ class }} entity);
}

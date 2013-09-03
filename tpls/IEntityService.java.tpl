package {{ package }}.service;

import java.util.List;

import net.yhte.common.result.JSONRenderer;
import {{ package }}.domain.{{ class }};

public interface I{{ class }}Service {
    /**
     * 查询记录
     * @param query 查询参数
     * @return 记录列表
     */
    JSONRenderer query({{ class }} query);
    /**
     * 查询单条记录详细
     * @param id 记录 id
     * @return 记录详细
     */
    JSONRenderer get(int id);
    /**
     * 添加记录
     * @param entity 记录
     * @return 是否成功
     */
    JSONRenderer append({{ class }} entity);
    /**
     * 删除记录
     * @param id 记录 id
     * @return 是否成功
     */
    JSONRenderer delete(int id);
    /**
     * 批量删除记录
     * @param ids 记录 id 集合
     * @return 是否成功
     */
    JSONRenderer batchDelete(List<Integer> ids);
    /**
     * 更新单条记录
     * @param entity 记录
     * @return 是否成功
     */
    JSONRenderer update({{ class }} entity);
}

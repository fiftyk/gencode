package {{ package }}.persistence;

import java.util.List;

import {{ package }}.domain.{{ class }};

public interface I{{ class }}Mapper {
    /**
     * 查询记录
     * @param query 查询参数
     * @return 记录列表
     */
    List<{{ class }}> query({{ class }} query);
    /**
     * 查询记录总数
     * @param query 查询参数
     * @return 记录列表
     */
    int count({{ class }} query);
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
     * 删除记录
     * @param id 记录 id
     * @return 是否成功
     */
    Boolean delete(int id);
    /**
     * 批量删除记录
     * @param ids 记录 id 集合
     * @return 是否成功
     */
    Boolean batchDelete(List<Integer> ids);
    /**
     * 更新单条记录
     * @param entity 记录
     * @return 是否成功
     */
    Boolean update({{ class }} entity);
}

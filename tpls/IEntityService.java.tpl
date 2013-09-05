package {{ package }}.service;

import net.yhte.common.IService;
import net.yhte.common.result.JSONRenderer;
import {{ package }}.domain.{{ class }};

public interface I{{ class }}Service extends IService {
    /**
     * 添加记录
     * @param entity 记录
     * @return 是否成功
     */
    JSONRenderer append({{ class }} entity);
    /**
     * 更新单条记录
     * @param entity 记录
     * @return 是否成功
     */
    JSONRenderer update({{ class }} entity);
}

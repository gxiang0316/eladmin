package ${package}.dao;

import ${package}.entity.${className};
import com.kedacom.kidp.base.data.common.repository.BaseJpaRepository;
import org.springframework.stereotype.Repository;

/**
* @author ${author}
* @date ${date}
*/
@Repository
public interface ${className}Dao extends BaseJpaRepository<${className}>{
<#if columns??>
    <#list columns as column>
        <#if column.columnKey = 'PRI'>

    /**
     * deleteBy${column.capitalColumnName}
     * @param ${column.columnName}
     * @return
     */
    void deleteBy${column.capitalColumnName}(${column.columnType} ${column.columnName});
        </#if>
    </#list>
</#if>
}
package ${package}.dto;

import lombok.Data;
<#if hasTimestamp>
import java.sql.Timestamp;
</#if>
<#if hasBigDecimal>
import java.math.BigDecimal;
</#if>
import java.io.Serializable;
<#if !auto && pkColumnType = 'Long'>
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
</#if>


/**
* @author ${author}
* @date ${date}
*/
@Data
public class ${className}DTO implements Serializable {
<#if columns??>
    <#list columns as column>
        <#if column.columnName = "created_by" || column.columnName = "created_time">
            <#continue>
        </#if>
        <#if column.columnName = "updated_by" || column.columnName = "updated_time">
            <#continue>
        </#if>
    <#if column.columnComment != ''>
    /**
     * ${column.columnComment}
     */
    </#if>
    <#if column.columnKey = 'PRI'>
    <#if !auto && pkColumnType = 'Long'>
    // 处理精度丢失问题
    @JsonSerialize(using= ToStringSerializer.class)
    </#if>
    </#if>
    private ${column.columnType} ${column.changeColumnName};
    </#list>
</#if>
}
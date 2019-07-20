package ${package}.entity;

import lombok.Data;
import com.kedacom.kidp.base.data.common.entity.BaseEntity;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
<#if hasTimestamp>
import java.sql.Timestamp;
</#if>
<#if hasBigDecimal>
import java.math.BigDecimal;
</#if>

/**
* @author ${author}
* @date ${date}
*/
@Entity
@Data
@Table(name="${tableName}")
@EntityListeners(AuditingEntityListener.class)
public class ${className} extends BaseEntity {
<#if columns??>
    <#list columns as column>
    <#if column.columnName = 'id' || column.columnName = "created_by" || column.columnName = "created_time">
        <#continue>
    </#if>
    <#if column.columnName = 'version' || column.columnName = "updated_by" || column.columnName = "updated_time">
        <#continue>
    </#if>
    <#if column.columnComment != ''>
    /**
     * ${column.columnComment}
     */
    </#if>
    @Column(name = "${column.columnName}"<#if column.columnKey = 'UNI'>,unique = true</#if><#if column.isNullable = 'NO' && column.columnKey != 'PRI'>,nullable = false</#if>)
    private ${column.columnType} ${column.changeColumnName};
    </#list>
</#if>
}
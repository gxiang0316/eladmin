package ${package}.service.impl;

import ${package}.entity.${className};
<#if columns??>
    <#list columns as column>
        <#if column.columnKey = 'UNI'>
            <#if column_index = 1>
import com.kedacom.pacc.handler.EntityExistException;
            </#if>
        </#if>
    </#list>
</#if>
import com.kedacom.pacc.utils.ValidationUtil;
import ${package}.dao.${className}Dao;
import ${package}.service.${className}Service;
import ${package}.dto.${className}DTO;
import ${package}.mapper.${className}Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import java.util.Optional;
<#if !auto && pkColumnType = 'Long'>
import cn.hutool.core.lang.Snowflake;
import cn.hutool.core.util.IdUtil;
</#if>

/**
* @author ${author}
* @date ${date}
*/
@Service
@Transactional(propagation = Propagation.SUPPORTS, readOnly = true, rollbackFor = Exception.class)
public class ${className}ServiceImpl implements ${className}Service {

    @Autowired
    private ${className}Dao ${changeClassName}Dao;

    @Autowired
    private ${className}Mapper ${changeClassName}Mapper;

    @Override
    public ${className}DTO findById(${pkColumnType} ${pkChangeColName}) {
        ${className} ${changeClassName} = ${changeClassName}Dao.findById(${pkChangeColName});
        ValidationUtil.isNull("${className}","${pkChangeColName}",${pkChangeColName});
        return ${changeClassName}Mapper.toDto(${changeClassName});
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ${className}DTO create(${className} resources) {
<#if !auto && pkColumnType = 'Long'>
        Snowflake snowflake = IdUtil.createSnowflake(1, 1);
        resources.set${pkCapitalColName}(snowflake.nextId()); 
</#if>
<#if !auto && pkColumnType = 'String'>
        resources.set${pkCapitalColName}(IdUtil.simpleUUID()); 
</#if>
<#if columns??>
    <#list columns as column>
    <#if column.columnKey = 'UNI'>
        if(${changeClassName}Dao.findBy${column.capitalColumnName}(resources.get${column.capitalColumnName}()) != null){
            throw new EntityExistException(${className}.class,"${column.columnName}",resources.get${column.capitalColumnName}());
        }
    </#if>
    </#list>
</#if>
        return ${changeClassName}Mapper.toDto(${changeClassName}Dao.save(resources));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(${className} resources) {
        ${className} ${changeClassName} = ${changeClassName}Dao.findById(resources.get${pkCapitalColName}());
        ValidationUtil.isNull("${className}","id",resources.get${pkCapitalColName}());
<#if columns??>
    <#list columns as column>
        <#if column.columnKey = 'UNI'>
        <#if column_index = 1>
        ${className} ${changeClassName}1 = null;
        </#if>
        ${changeClassName}1 = ${changeClassName}Dao.findBy${column.capitalColumnName}(resources.get${column.capitalColumnName}());
        if(${changeClassName}1 != null && !${changeClassName}1.get${pkCapitalColName}().equals(${changeClassName}.get${pkCapitalColName}())){
            throw new EntityExistException(${className}.class,"${column.columnName}",resources.get${column.capitalColumnName}());
        }
        </#if>
    </#list>
</#if>
        // 此处需自己修改
        resources.set${pkCapitalColName}(${changeClassName}.get${pkCapitalColName}());
        ${changeClassName}Dao.save(resources);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delete(${pkColumnType} ${pkChangeColName}) {
        ${changeClassName}Dao.deleteById(${pkChangeColName});
    }
}
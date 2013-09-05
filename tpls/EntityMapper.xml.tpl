<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="{{ package }}.persistence.I{{ class }}Mapper">
  
  <!--分页查询-->
  <select id="query" parameterType="XQuery" resultType="{{ class }}">
    select *
      from t_{{ lowerCase class }}
    where 1=1
  
    <!--查询字段-->
    {{#if qFields }}
    <if test="text != null and text != ''">
    and (
      {{#join qFields sep="or"}} 
      {{this}} like '%${text}%' {{/join}}
    )
    </if>
    {{/if}}
    <!--过滤字段-->
    {{#if fFields }}{{#each fFields}}
    <if test="X.{{this}} != null and X.{{this}} != ''">
    and {{this}} like '%${ X.{{this}} }'
    </if>
    {{/each}}{{/if}}
    order by #{o}
    <if test="ot == 'DESC'">
    desc
    </if>
    <if test="ot == 'ASC'">
    asc
    </if>

    limit #{offset},#{pageSize}
  </select>
  
  <!--计数-->
  <select id="count" parameterType="XQuery" resultType="int">
    select count(1)
      from t_{{ lowerCase class }}
    where 1=1
  
    <!--查询字段-->
    <if test="text != null and text != ''">
    and (
      {{#join qFields sep="or"}} 
      {{this}} like '%${text}%' {{/join}}
    )
    </if>

    <!--过滤字段-->
    {{#each fFields}}
    <if test="X.{{this}} != null and X.{{this}} != ''">
    and {{this}} like '%${ X.{{this}} }'
    </if>
    {{/each}}
  </select>
  
  <!--获取单条记录-->
  <select id="get" parameterType="int" resultType="{{ class }}">
    select *
      from t_{{ lowerCase class }}
    where id = #{id}
  </select>

  <!--新增-->
  <insert id="append" parameterType="{{ class }}">
    <selectKey keyProperty="id" resultType="int" order="BEFORE">
    SELECT auto_increment FROM information_schema.`TABLES` 
    WHERE TABLE_NAME = 't_{{ lowerCase class }}'
    </selectKey>
    insert
      into t_{{ lowerCase class }} 
    (
      {{#join fields}} {{this}}{{/join}}
    )
    values
    (
      {{#join fields }} #{ {{ this }} }{{/join}}
    )
  </insert>
  
  <!--删除-->
  <delete id="delete">
    delete 
      from t_{{ lowerCase class }}
    where id = #{value}
  </delete>
  
  <!--更新-->
  <update id="update" parameterType="{{ class }}">
    update
      t_{{ lowerCase class }}
    set{{#join fields sep=" " start="1"}}
      <if test="{{this}} != null and {{this}} != ''">
      {{this}} = #{ {{this}} } {{#if @last}} {{else}} , {{/if}}
      </if>{{/join}}
    where
      id = #{id}
  </update>
  
  <!--批量删除-->
  <delete id="batchDelete">
    delete 
      from t_{{ lowerCase class }}
    where id in
    <foreach collection="list" item="item" separator="," close=")" open="(">
        #{item}
    </foreach>
  </delete>

</mapper>

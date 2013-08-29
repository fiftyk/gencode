<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="{{ package }}.persistence.I{{ class }}Mapper">
    
  <select id="query" parameterType="{{ class }}Query" resultType="{{ class }}">
    select *
    from t_{{ lowerCase class }}
    where 1=1
  
    <!--查询字段-->
    <if test="text != null and text != '' ">
    and (
      {{#each qFields}}
      {{this}} like '%${text}%' or 
      {{/each}}
      1 = 2
    )
    </if>
    
    <!--过滤字段-->
    {{#each fFields}}
    <if test="{{this}} != null and {{this}} != '' ">
    and ({{this}} like '%${ {{this}} }')
    </if>
    {{/each}}
    order by #{o}
    <if test=" ot == 'DESC' ">
    desc
    </if>
    <if test=" ot == 'ASC' ">
    asc
    </if>

    limit #{offset},#{pageSize}
  </select>

  <select id="count" parameterType="{{ class }}Query" resultType="int">
    select count(1)
    from t_{{ lowerCase class }}
    where 1=1
  
    <!--查询字段-->
    <if test="text != null and text != '' ">
    and (
      {{#each qFields}}
      {{this}} like '%${text}%' or 
      {{/each}}
      1 = 2
    )
    </if>
    
    <!--过滤字段-->
    {{#each fFields}}
    <if test="{{this}} != null and {{this}} != '' ">
    and ({{this}} like '%${ {{this}} }')
    </if>
    {{/each}}
  </select>
  
  <select id="get" parameterType="int" resultType="{{ class }}">
    select *
    from t_{{ lowerCase class }}
    where id = #{id}
  </select>

  <insert id="append" parameterType="{{ class }}">
    <selectKey keyProperty="id" resultType="int" order="BEFORE">
    SELECT auto_increment FROM information_schema.`TABLES` 
    WHERE TABLE_NAME = 't_{{ lowerCase class }}'
    </selectKey>
    insert into t_{{ lowerCase class }} 
    (
      {{#join fields}} {{this}} {{/join}}
    )
    values
    (
      {{#join fields}} #{ {{ this }} } {{/join}}
    )
  </insert>
  
  <delete id="delete">
    delete 
    from t_{{ lowerCase class }}
    where id = #{value}
  </delete>
  
  <update id="update" parameterType="{{ class }}">
    update t_{{ lowerCase class }}
    set
    {{#join fields}}  
    {{this}} = #{ {{this}} }
    {{/join}}
    where
      id = #{id}
  </update>
  
  <delete id="batchDelete">
    delete 
    from t_{{ lowerCase class }}
    where id in
    <foreach collection="list" item="item" separator="," close=")" open="(">
        #{item}
    </foreach>
  </delete>
</mapper>

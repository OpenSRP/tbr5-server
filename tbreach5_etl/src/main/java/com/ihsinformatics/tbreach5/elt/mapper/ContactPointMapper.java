package com.ihsinformatics.tbreach5.elt.mapper;

import com.ihsinformatics.tbreach5.elt.model.ContactPoint;
import org.apache.ibatis.annotations.Insert;

public interface ContactPointMapper {


    @Insert("INSERT INTO public.\"ContactPoint\"(\n" +
            "            \"contactPointID\", \"clientID\", type, use, \"number\", preference, \n" +
            "            \"startDate\", \"endDate\",\"entityID\")\n" +
            "    VALUES (#{contactPointID},#{clientID}, #{type},#{use}, #{number},#{preference} , \n" +
            "            #{startDate}, #{endDate},#{entityID})\n")
    public int insertContactPoint(ContactPoint contactPoint);

}

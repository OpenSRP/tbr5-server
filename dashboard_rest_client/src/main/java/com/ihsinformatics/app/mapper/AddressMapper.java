package com.ihsinformatics.app.mapper;

import com.ihsinformatics.app.model.Address;
import org.apache.ibatis.annotations.Insert;

public interface AddressMapper {

    @Insert("INSERT INTO public.\"Address\"(\n" +
            "            preffered, \"addressType\", \"startDate\", \"endDate\", \"addressFields\", \n" +
            "            latitude, longitude, geopoint, \"postalCode\", \"subTown\", town, \n" +
            "            \"subDistrict\", \"countryDistrict\", \"cityVillage\", \"stateProvince\", \n" +
            "            country,\"entityID\")\n" +
            "    VALUES (#{preffered}, #{addressType}, #{startDate},#{endDate},#{addressFields}, \n" +
            "            #{latitude},#{longitutde}, #{geopoint}, #{postalCode}, #{subTown}, #{town}, \n" +
            "            #{subDistrict},#{countryDistrict} , #{cityVillage},#{stateProvince}, \n" +
            "            #{country},#{entityID})\n")
   public int insertAddress(Address address);




}

package mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.CategoryDto;

@Mapper
public interface CategoryMapper {

	@Select("SELECT * FROM category WHERE parent_code IS NULL ORDER BY category_code DESC")
    List<Map<String, Object>> selectParentOnly();
	
	@Select("SELECT * FROM category WHERE parent_code = #{code} ORDER BY category_code ASC")
    List<Map<String, Object>> selectSubCategoryList(int code);
	
	@Select("SELECT * FROM category WHERE category_code = #{code}")
    Map<String, Object> selectCategoryInfo(int code);

	@Select("SELECT category_code, category_name, parent_code FROM category WHERE parent_code IS NULL ORDER BY category_code ASC")
    List<CategoryDto> selectMainCategoryList();

    @Select("SELECT category_code, category_name, parent_code FROM category WHERE parent_code = #{parentCode} ORDER BY category_code ASC")
    List<CategoryDto> selectSubCategoryList2(int parentCode);

    @Insert("INSERT INTO category (category_code, category_name, parent_code) VALUES (#{category_code}, #{category_name}, #{parent_code})")
	void insertCategory(CategoryDto dto);

    @Delete("DELETE FROM category WHERE category_code = #{category_code}")
	void deleteCategory(int category_code);

    @Update("UPDATE category SET category_name = #{category_name}, parent_code = #{parent_code} WHERE category_code = #{category_code}")
    void updateCategory(CategoryDto dto);
    

}

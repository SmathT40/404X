package mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import dto.CategoryDto;

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
}

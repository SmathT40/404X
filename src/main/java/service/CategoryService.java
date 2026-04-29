package service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.CategoryDto;
import mapper.CategoryMapper;

@Service
public class CategoryService {
    @Autowired
    private CategoryMapper categoryMapper;

    public Map<String, Object> getCategoryDetail(int code) {
        // 부모 정보와 자식 리스트를 한 번에 묶어서 반환
        Map<String, Object> result = categoryMapper.selectCategoryInfo(code);
        if (result != null) {
            result.put("subList", categoryMapper.selectSubCategoryList(code));
        }
        return result;
    }
    public List<CategoryDto> getMainCategories() {
        return categoryMapper.selectMainCategoryList();
    }

    public List<CategoryDto> getSubCategories(int parentCode) {
        return categoryMapper.selectSubCategoryList2(parentCode);
    }
	public void insertCategory(CategoryDto dto) {
		if (dto.getParent_code() != null && dto.getParent_code() == 0) {
	        dto.setParent_code(null); 
	    }
		categoryMapper.insertCategory(dto);
	}
	public void deleteCategory(int category_code) {
		categoryMapper.deleteCategory(category_code);
	}
	public List<CategoryDto> getAllCategories() {
	    List<CategoryDto> allList = categoryMapper.selectMainCategoryList();
	    
	    List<CategoryDto> result = new ArrayList<>();
	    for (CategoryDto main : allList) {
	        result.add(main); // 대분류 추가
	        List<CategoryDto> subs = categoryMapper.selectSubCategoryList2(main.getCategory_code());
	        if (subs != null) {
	            result.addAll(subs); // 소분류들 바로 아래 추가
	        }
	    }
	    return result;
	}
	public void updateCategory(CategoryDto dto) {
		categoryMapper.updateCategory(dto);
	}
}
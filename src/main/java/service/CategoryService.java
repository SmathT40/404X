package service;

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
}
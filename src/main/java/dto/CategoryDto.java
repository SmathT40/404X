package dto;

import lombok.Data;

@Data
public class CategoryDto {
    private Integer category_code;
    private String category_name;
    private Integer parent_code;
}

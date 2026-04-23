package dto;

import lombok.Data;

@Data
public class CategoryDto {
    private int category_code;
    private String category_name;
    private Integer parent_code;
}

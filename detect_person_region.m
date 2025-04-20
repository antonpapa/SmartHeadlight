function can_data = detect_person_region(mask)
    % 输入：mask 为 1920x1080 的灰度图像矩阵
    width = 1920;
    region_width = width / 3;
    left_region = mask(:, 1:region_width);
    middle_region = mask(:, region_width+1:2*region_width);
    right_region = mask(:, 2*region_width+1:end);
    
    % 统计白色像素数量
    left_pixel_count = sum(left_region(:) == 255);
    middle_pixel_count = sum(middle_region(:) == 255);
    right_pixel_count = sum(right_region(:) == 255);
    
    % 找到最大区域
    pixel_counts = [left_pixel_count, middle_pixel_count, right_pixel_count];
    [max_count, max_region] = max(pixel_counts);
    
    % 生成CAN数据
    can_data = zeros(8, 1, 'uint8');
    if max_count > 0
        switch max_region
            case 1 % 左区域
                can_data(6:8) = [17; 17; 17];
            case 2 % 中间区域
                can_data(4:5) = [17; 17];
            case 3 % 右区域
                can_data(1:3) = [17; 17; 17];
        end
    end
end
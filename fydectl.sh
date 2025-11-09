#!/bin/bash

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

show_menu() {
    clear
    echo -e "${BLUE}🎛️  Tuner - FydeOS${NC}"
    echo "================================"
    
    # 状态显示
    echo -e "${YELLOW}当前状态:${NC}"
    
    # 键盘背光状态
    kblight_output=$(sudo ectool pwmgetkblight 2>/dev/null)
    if echo "$kblight_output" | grep -q "[0-9]"; then
        kblight=$(echo "$kblight_output" | awk '{print $NF}')
        echo -e "键盘背光: ${GREEN}${kblight}%${NC}"
    else
        echo -e "键盘背光: ${YELLOW}未知${NC}"
    fi
    
    # 风扇状态
    fan_output=$(sudo ectool pwmgetfanrpm 2>/dev/null | head -1)
    if echo "$fan_output" | grep -q "[0-9]"; then
        fan_rpm=$(echo "$fan_output" | awk '{print $NF}')
        echo -e "风扇转速: ${GREEN}${fan_rpm} RPM${NC}"
    else
        echo -e "风扇转速: ${YELLOW}未知${NC}"
    fi
    
    echo "================================"
    
    echo -e "${GREEN}1) 安静模式 (风扇40%, 背光30%)${NC}"
    echo -e "${GREEN}2) 平衡模式 (风扇50%, 背光50%)${NC}"
    echo -e "${GREEN}3) 性能模式 (风扇70%, 背光70%)${NC}"
    echo -e "${YELLOW}4) 关闭背光${NC}"
    echo -e "${YELLOW}5) 关闭风扇${NC}"
    echo -e "${BLUE}6) 自定义设置${NC}"
    echo -e "${RED}0) 退出${NC}"
    echo
}

custom_settings() {
    echo -n "设置风扇转速 (0-100): "
    read fan
    echo -n "设置背光亮度 (0-100): "
    read light
    
    sudo ectool fanduty $fan
    sudo ectool pwmsetkblight $light
    echo -e "${GREEN}已设置: 风扇${fan}% 背光${light}%${NC}"
}

# 检查权限
if ! sudo -n true 2>/dev/null; then
    echo -e "${RED}需要root权限，请输入密码:${NC}"
    sudo echo "权限确认" || exit 1
fi

while true; do
    show_menu
    echo -n "请选择: "
    read choice
    
    case $choice in
        1)
            sudo ectool fanduty 40
            sudo ectool pwmsetkblight 30
            echo -e "${GREEN}已设置安静模式${NC}"
            ;;
        2)
            sudo ectool fanduty 50
            sudo ectool pwmsetkblight 50
            echo -e "${GREEN}已设置平衡模式${NC}"
            ;;
        3)
            sudo ectool fanduty 70
            sudo ectool pwmsetkblight 70
            echo -e "${GREEN}已设置性能模式${NC}"
            ;;
        4)
            sudo ectool pwmsetkblight 0
            echo -e "${YELLOW}已关闭背光${NC}"
            ;;
        5)
            sudo ectool fanduty 0
            echo -e "${YELLOW}已关闭风扇${NC}"
            ;;
        6)
            custom_settings
            ;;
        0)
            echo "再见!"
            exit 0
            ;;
        *)
            echo -e "${RED}无效选择${NC}"
            ;;
    esac
    
    echo "按回车继续..."
    read
done

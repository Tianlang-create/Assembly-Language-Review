.MODEL SMALL
.STACK 100H
.DATA
    PROMPT_MSG DB 'Please input a string (end with .): $'
    RESULT_MSG DB 13,10,'Results:',13,10,'Letters: $'
    DIGIT_MSG DB 13,10,'Digits: $'
    OTHER_MSG DB 13,10,'Others: $'
    INPUT_STR DB 81 DUP(?)  ; 80个字符+结束符
    LETTER DB 0             ; 字母计数
    DIGIT DB 0              ; 数字计数
    OTHER DB 0              ; 其他字符计数

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; 显示输入提示
    LEA DX, PROMPT_MSG
    MOV AH, 9
    INT 21H
    
    ; 读取字符串
    XOR SI, SI              ; SI用作输入字符串的索引
INPUT_LOOP:
    MOV AH, 1              ; 从键盘读取一个字符
    INT 21H
    
    MOV INPUT_STR[SI], AL  ; 保存字符
    
    CMP AL, '.'            ; 检查是否是结束符号
    JE COUNT_START         ; 如果是点号，开始统计
    
    INC SI
    CMP SI, 80             ; 检查是否达到最大长度
    JB INPUT_LOOP         ; 如果未达到最大长度，继续读取
    
COUNT_START:
    XOR SI, SI            ; 重置SI为0，准备开始统计
    
COUNT_LOOP:
    MOV AL, INPUT_STR[SI] ; 获取当前字符
    
    CMP AL, '.'           ; 检查是否到达结束符号
    JE DISPLAY_RESULT
    
    ; 检查是否是字母
    CMP AL, 'A'
    JB CHECK_LOWER        ; 如果小于'A'，检查是否是小写字母
    CMP AL, 'Z'
    JBE IS_LETTER         ; 如果小于等于'Z'，是大写字母
    
CHECK_LOWER:
    CMP AL, 'a'
    JB CHECK_DIGIT        ; 如果小于'a'，检查是否是数字
    CMP AL, 'z'
    JBE IS_LETTER         ; 如果小于等于'z'，是小写字母
    JMP CHECK_DIGIT
    
IS_LETTER:
    INC LETTER
    JMP NEXT_CHAR
    
CHECK_DIGIT:
    CMP AL, '0'
    JB IS_OTHER          ; 如果小于'0'，是其他字符
    CMP AL, '9'
    JBE IS_DIGIT         ; 如果小于等于'9'，是数字
    JMP IS_OTHER
    
IS_DIGIT:
    INC DIGIT
    JMP NEXT_CHAR
    
IS_OTHER:
    INC OTHER
    
NEXT_CHAR:
    INC SI
    JMP COUNT_LOOP
    
DISPLAY_RESULT:
    ; 显示字母数量
    LEA DX, RESULT_MSG
    MOV AH, 9
    INT 21H
    
    MOV DL, LETTER
    ADD DL, '0'          ; 转换为ASCII
    MOV AH, 2
    INT 21H
    
    ; 显示数字数量
    LEA DX, DIGIT_MSG
    MOV AH, 9
    INT 21H
    
    MOV DL, DIGIT
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    
    ; 显示其他字符数量
    LEA DX, OTHER_MSG
    MOV AH, 9
    INT 21H
    
    MOV DL, OTHER
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    
    ; 程序结束
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
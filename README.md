# 汇编复习题的MASM实现（Wu Fan）

​				*Date in 26/12/2024 Made by tianlang <u>QQ:2090256385</u>*

## 注意：

### 			  代码格式

​				masm与考试题的代码编写有少许不同，主要是基于伪指令的操作，所有实例的编写格式按照王爽老师的规范使用，例如：

```assembly
ASSUME CS:CODE,DS:DATA
DATA SEGMENT
;
DATA ENDS
CODE SEGMENT
START:
;
CODE ENDS
END START
;Basic Body
```

​			取而代之的格式可以为

```assembly
.model small    
.stack 100h  
.data       
;
.code       
main proc      
;
main endp
end main
```

​			或者，基于本格式做出的美观调动，例如：

```assembly
DATA SEGMENT
;
DATA ENDS
CODE SEGMENT
;other functions 
ASSUME CS:CODE,DS:DATA
START:
;
CODE ENDS
END START
```

​		

 ### 伪指令

汇编语言常用的伪指令有

`.model`：定义程序的内存模型。

`.data`：开始数据段，定义变量。

`.code`：开始代码段，定义程序逻辑。

`.stack`：定义栈的大小。

`ASSUME`：告诉汇编器段寄存器的使用。

### 其他

​		统计字符串题目为实验原题，非本人编写。
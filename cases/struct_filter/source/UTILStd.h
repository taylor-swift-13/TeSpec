
#ifndef __UTIL_STD_H__
#define __UTIL_STD_H__

#define OK						(0)			/* 状态值,代表正常 */
#define ERROR					(-1)		/* 状态值,代表错误 */

#define SYSTRUE					(0xeb90146f)
#define SYSFALSE				(0x0)

#define MEMFRESHING				(0x0)
#define MEMFRESHOVER			(0x1)

//#define SYSOK					(1)			/* 逻辑值,代表正确 */
//#define SYSERROR				(0)			/* 逻辑值,代表错误 */
//	
#define TRUE					(1)			/* 逻辑值,代表正确 */
#define FALSE					(0)			/* 逻辑值,代表错误 */
#ifndef NULL
#define NULL 					(0)			/* 空指针数值 */
#endif
//存储器在刷新标志中占位
#define MEM_SRAM_BIT			(0)
#define MEM_EMIFSRAM_BIT		(1)
#define MEM_SDRAM_BIT			(2)

/*工作模式*/
#define MODE_SINGLE				(0x1)	/*单机模式*/
#define MODE_COLD_AUTO			(0x2A)	/*双机冷备份模式,自动切机*/
#define MODE_COLD_NONE			(0x2B)	/*双机冷备份模式,无自动切机*/
#define MODE_TRIPLE_HOT			(0x3)	/*三机热备份模式*/
#define MODE_QUADRA_			(0x4)

#ifndef __ASMLANG__

/* typedef - 类型定义 */
typedef int						BOOL;				/* 逻辑型变量类型 */
typedef int						STATUS; 			/* 状态型变量类型 */
typedef int						(*FUNCPTR)();		/* 函数指针变量类型 */

typedef signed char				I8;
typedef short					I16;
typedef int						I32;
typedef long long				I64;

typedef unsigned char			U8;
typedef unsigned short			U16;
typedef unsigned int			U32;
typedef unsigned long long		U64;
typedef volatile U8				V_U8;
typedef volatile U16			V_U16;
typedef volatile U32			V_U32;

typedef volatile U64			V_U64;
typedef U32 const				C_U32;
typedef float					F32;
typedef double					F64;

typedef volatile float			V_F32;
typedef volatile double			V_F64;

#ifdef DEBUG
#define NELEMENTS(array)		(sizeof (array)/ sizeof ((array)[0]))
#endif

#define r32(addr)				(*(volatile U32 *)(addr))
#define w32(addr, val)			(*(volatile U32 *)(addr)= (val))
#define r16(addr)				(*(volatile U16 *)(addr))
#define w16(addr, val)			(*(volatile U16 *)(addr)= (val))
#define r8(addr)				(*(volatile U8 *)(addr))
#define w8(addr, val)			(*(volatile U8 *)(addr)= (val))

#endif  //__ASMLANG__

#endif  /* __UTIL_STD_H__ */


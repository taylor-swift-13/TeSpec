/**
 * @file common.h
 * @brief 自动提取的项目全局宏和枚举定义
 * @note 此文件由 create_common_h.py 脚本自动生成于 2026-05-25 12:10:38
 */

#ifndef AUTO_GENERATED_COMMON_H
#define AUTO_GENERATED_COMMON_H

/* --- 自动提取的宏定义 (MACROS) --- */

#define		DEV_ACCA		7u			/* 	加计组件a */


#define		DEV_ACCB		8u			/* 	加计组件b */


#define		DEV_CLOSETEST	17u			/* 	闭环串口 */


#define		DEV_DSS			0u			/* 	DSS       */


#define		DEV_FOG1		1u			/* 	陀螺1     */


#define		DEV_FOG2		2u			/* 	陀螺2     */


#define		DEV_FOG3		3u			/* 	陀螺3     */


#define		DEV_FOG4		4u			/* 	陀螺4     */


#define		DEV_FOG5		5u			/* 	陀螺5     */


#define		DEV_FOG6		6u			/* 	陀螺6     */


#define		DEV_ICUA		13u			/* 	ICU主份 */


#define		DEV_ICUB		14u			/* 	ICU备份 */


#define		DEV_JETA		15u			/* 	推进子系统主份 */


#define		DEV_JETB		16u			/* 	推进子系统备份 */


#define		DEV_STSA		9u			/* 	一体式星敏感器A */


#define		DEV_STSB		10u			/* 	一体式星敏感器B */


#define		DEV_STSC		11u			/* 	一体式星敏感器C */


#define		DEV_STSD		12u			/* 	分体式星敏感器 */


#define		LGVCMD_TOTAL   	41u		/*  自锁阀指令总数 */


#define		UART_0			    0u			/* 串口号0	 */


#define		UART_3			    3u			/* 串口号3	 */


#define		UART_4			    4u			/* 串口号4	 */


#define		UART_5		        5u			/* 串口号5	 */


#define		UART_6		        6u			/* 串口号6	 */


#define		UART_ACC_A			20u			/* 串口号20	加计组件a */


#define		UART_ACC_B			21u			/* 串口号21	加计组件b */


#define		UART_CLOSETEST      18u			/* 串口号18	闭环专用串口 */


#define		UART_DSS			7u			/* 串口号7	数字太阳敏感器 */


#define		UART_FOG1			10u			/* 串口号10	陀螺1         */


#define		UART_FOG2			11u			/* 串口号11	陀螺2         */


#define		UART_FOG3			12u			/* 串口号12	陀螺3         */


#define		UART_FOG4		    14u			/* 串口号14	陀螺4          */


#define		UART_FOG5			9u			/* 串口号9	陀螺5         */


#define		UART_FOG6   		8u			/* 串口号8	陀螺6         */


#define		UART_ICU_A			1u			/* 串口号1	ICU主份    */


#define		UART_ICU_B			2u			/* 串口号2	ICU备份    */


#define		UART_JET_A		    16u			/* 串口号16	推进子系统主份 */


#define		UART_JET_B		    17u			/* 串口号17	推进子系统备份 */


#define		UART_STS_A			19u			/* 串口号19	一体式星敏感器A */


#define		UART_STS_B			13u			/* 串口号13	一体式星敏感器B */


#define		UART_STS_C		    15u			/* 串口号15	一体式星敏感器C */


#define		UART_STS_D			22u			/* 串口号22	分体式星敏感器 */


#define		UART_TOTAL		    23u			/* 串口配置数组长度 = 串口ID的最大值 + 1 */


#define	 MODE_TMR_AUTO						(0xeb900000)	/*ģʽģʽ*/


#define	 MODE_TMR_COLD						(0xeb900002)	/*䱸ģʽ*/


#define	 MODE_TMR_FORCE						(0xeb900001)	/*ǿƵģʽ*/


#define	ABT_MODE 0x17	/*Abortģʽ*/

#define	AFE						BSP_DISABLE


#define	ALLTIMER_FREQ_DIVIDED_PARAM 			(2)					/*Select from:0;1;2*/


#define	APBTIMER_FREQ							(CPU_FREQ/4)		/* APB Timers Freq*/


#define	APBTIMER_FREQ_DIVIDED_PARAM				(ALLTIMER_FREQ_DIVIDED_PARAM)		 /*Select from:0;1;2*/


#define	APPOKMINCOUNT						(40)


#define	APPTRI32_A_BASEADDR					(SYS_TRI32_BASEADDR)										/*Ӧȡһ׵ַ*/

#define	APPTRI32_B_BASEADDR					(SYSTRI32_A_BASEADDR+SYSTRI32_EACHSIZE+SYS_ISOLATION_SIZE)


#define	APPTRI32_C_BASEADDR					(SYSTRI32_B_BASEADDR+SYSTRI32_EACHSIZE+SYS_ISOLATION_SIZE)


#define	APPTRI32_EACHSIZE					(4*1024)/*ӦȡһĴС*/


#define	ASEDIS					0


#define	AW						1


#define	BACKKEY				(0x14)			/* keybackflag */


#define	BIG_ENDIAN							0x1			/**/


#define	BSPCPACR_INIT				(((ASEDIS & 0x01) << 31)|	\
									((D32DIS & 0x01) << 30)|	\
									((CP & 0x03) << 26)|		\
									((CP & 0x03) << 24)|		\
									((CP & 0x03) << 22)|		\
									((CP & 0x03) << 20)|		\
									((CP & 0x03) << 18)|		\
									((CP & 0x03) << 16)|		\
									((CP & 0x03) << 14)|		\
									((CP & 0x03) << 12)|		\
									((CP & 0x03) << 10)|		\
									((CP & 0x03) << 8)|			\
									((CP & 0x03) << 6)|			\
									((CP & 0x03) << 4)|			\
									((CP & 0x03) << 2)|			\
									((CP & 0x03) << 0))


#define	BSPFPEXC_INIT				(((EX & 0x01) << 31)|		\
									((FEN & 0x01) << 30))


#define	BSPNSACR_INIT				(((RFQ & 0x01) << 19)|		\
									((NSASEDIS & 0x01) << 15)|	\
									((NSD32DIS & 0x01) << 14)|	\
									((nCP & 0x01) << 13)|		\
									((nCP & 0x01) << 12)|		\
									((nCP & 0x01) << 11)|		\
									((nCP & 0x01) << 10)|		\
									((nCP & 0x01) << 9)|		\
									((nCP & 0x01) << 8)|		\
									((nCP & 0x01) << 7)|		\
									((nCP & 0x01) << 6)|		\
									((nCP & 0x01) << 5)|		\
									((nCP & 0x01) << 4)|		\
									((nCP & 0x01) << 3)|		\
									((nCP & 0x01) << 2)|		\
									((nCP & 0x01) << 1)|		\
									((nCP & 0x01) << 0))


#define	BSPSCR_INIT					((((~nET) & 0x01) << 6)|	\
									((AW & 0x01) << 5)|			\
									((FW & 0x01) << 4)|			\
									((EA & 0x01) << 3)|			\
									((FIQ & 0x01) << 2)|		\
									((IQR & 0x01) << 1)|		\
									((NS & 0x01) << 0))


#define	BSPSCTLR_INIT				(((TE & 0x01) << 30)|		\
									((AFE & 0x01) << 29)|		\
									((TRE & 0x01) << 28)|		\
									((EE & 0x01) << 25)|		\
									((VE & 0x01) << 24)|		\
									((FI & 0x01) << 21)|		\
									((HA & 0x01) << 17)|		\
									((RR & 0x01) << 14)|		\
									((V & 0x01) << 13)|			\
									((CACHE_DISABLE & 0x01) << 12)|\
									((Z & 0x01) << 11)|			\
									((SW & 0x01) << 10)|		\
									((CACHE_DISABLE & 0x01) << 2)|\
									((MMU & 0x01) << 0))


#define	BSP_APBTIMERS_COMPVERSION				(0xac)				/* Timers Version Register*/


#define	BSP_APBTIMERS_EOI						(0xa4)				/* Timers EOI Register*/


#define	BSP_APBTIMERS_INTS						(0xa0)				/* Timers Int Status Register*/


#define	BSP_APBTIMERS_RAWINTS				 	(0xa8)				/* Timers Raw Int Status Register*/


#define	BSP_APBTIMERS_SCALE						(0x100)				/* Timers Scale Register*/


#define	BSP_APBTIMER_COUNT						(0x004)				/* Timer Count Register*/


#define	BSP_APBTIMER_CTRL						(0x008)				/* Timer Contrl Register*/


#define	BSP_APBTIMER_EOI						(0x00c)				/* Timers EOI Register*/


#define	BSP_APBTIMER_INTS						(0x010)				/* Timer Interrupt Status Register*/


#define	BSP_APBTIMER_LOAD						(0x000)				/* Timer Load Register*/


#define	BSP_DISABLE							0x0			/*ֹ*/


#define	BSP_ENABLE							0x1			/*ʹ*/


#define	BSP_ERROR							-1			/*ERROR*/


#define	BSP_GLOBALTIMER_AUTOINCREMENT			(0x018)				/* Timer AUTOINCREMENT Register*/


#define	BSP_GLOBALTIMER_COMPARATORH				(0x014)				/* Timer high COMPARATOR Register*/


#define	BSP_GLOBALTIMER_COMPARATORL				(0x010)				/* Timer low COMPARATOR Register*/


#define	BSP_GLOBALTIMER_COUNTH					(0x004)				/* Timer high Count Register*/


#define	BSP_GLOBALTIMER_COUNTL					(0x000)				/* Timer low Count Register*/


#define	BSP_GLOBALTIMER_CTRL					(0x008)				/* Timer Contrl Register*/


#define	BSP_GLOBALTIMER_INTS					(0x00c)				/* Timer Interrupt Status Register*/


#define	BSP_GPI_HIGH							(0x1)	/*GPIΪߵƽ */

#define	BSP_GPI_LOW								(0x0)	/*GPIΪ͵ƽ */


#define	BSP_OK								0				/*OK*/


#define	BSP_PRIVATETIMER_COUNT					(0x004)				/* Timer Count Register*/


#define	BSP_PRIVATETIMER_CTRL					(0x008)				/* Timer Contrl Register*/


#define	BSP_PRIVATETIMER_INTS					(0x00c)				/* Timer Interrupt Status Register*/


#define	BSP_PRIVATETIMER_LOAD					(0x000)				/* Timer Load Register*/


#define	BSP_PreciseDelay_No						(0x0)				/*ϵͳʹöʱ0Ϊȷʱʹ*/


#define	BSP_Prog_Storge1_Flag			(0x0)


#define	BSP_Prog_Storge2_Flag			(0x1)


#define	BSP_Prog_Storge3_Flag			(0x2)


#define	BSP_TimeSlice_No						(0x1)				/*ϵͳʹöʱ1ΪϵͳʱƬ*/

#define	BSP_UART_BaudDivdR					(0x00)				/* ڲʷƵĴ*/


#define	BSP_UART_ContrlR					(0x0c)				/* ڿƼĴ*/


#define	BSP_UART_FCR						(0x08)				/* FIFOƼĴ*/


#define	BSP_UART_FifoR						(0x00)				/* շĴ*/


#define	BSP_UART_IIR						(0x08)				/* жԴĴ*/


#define	BSP_UART_StatusR					(0x14)				/* ״̬Ĵ*/


#define	CACHE_DISABLE						0x00		/*CACHEֹ*/


#define	CACHE_ENABLE						0x03		/*CACHEʹ*/


#define	CACHE_FROZEN						0x01		/*CACHE*/


#define	CACHE_FT_DISABLE					0x00		/*ݴУ*/


#define	CACHE_FT_ENABLE						0x01		/*4λУ*/


#define	COM_EVEN							0x0			/*żУ*/


#define	COM_ODD								0x1			/*У*/


#define	CP						3


#define	D32DIS					0


#define	DELAY_TIMER_MAX							(0xffffffff>>ALLTIMER_FREQ_DIVIDED_PARAM) 


#define	DISABLE_ALL_INT		((1<<6)|(1<<7)|(1<<8))	/*ֹж*/

#define	EA						0


#define	EE						LITTLE_ENDIAN


#define	EMIF_PROM_WIDTH_16				(16)


#define	EMIF_PROM_WIDTH_32				(32)


#define	EMIF_PROM_WIDTH_8				(8)


#define	ENABLE_ALL_INT		(~DISABLE_ALL_INT)		/*ʹж*/

#define	EX					0


#define	FEN					BSP_ENABLE


#define	FI						BSP_DISABLE


#define	FIQ						0


#define	FIQ_MODE 0x11	/*FIQģʽ*/

#define	FLOAT_DISABLE						0x0			/*ֹ */


#define	FLOAT_ENABLE						0x1			/*ʹ */

#define	FW						1


#define	GLOBALTIMER_FREQ						(CPU_FREQ)			/* Global Timers Freq*/


#define	GLOBALTIMER_FREQ_DIVIDED_PARAM			(ALLTIMER_FREQ_DIVIDED_PARAM)		 /*Select from:0;1;2*/


#define	GPI0								0x0			/*GPI0 */


#define	GPI1								0x1			/*GPI1 */


#define	GPI10								0xA			/*GPI10 */


#define	GPI11								0xB			/*GPI11 */


#define	GPI12								0xC			/*GPI12 */


#define	GPI13								0xD			/*GPI13 */


#define	GPI14								0xE			/*GPI14 */


#define	GPI15								0xF			/*GPI15 */


#define	GPI16								0x10		/*GPI16 */


#define	GPI17								0x11		/*GPI17 */


#define	GPI18								0x12		/*GPI18 */


#define	GPI19								0x13		/*GPI19 */


#define	GPI2								0x2			/*GPI2 */


#define	GPI20								0x14		/*GPI20 */


#define	GPI21								0x15		/*GPI21 */


#define	GPI22								0x16		/*GPI22 */


#define	GPI23								0x17		/*GPI23 */


#define	GPI24								0x18		/*GPI24 */


#define	GPI25								0x19		/*GPI25 */


#define	GPI26								0x1A		/*GPI26 */


#define	GPI27								0x1B		/*GPI27 */


#define	GPI28								0x1C		/*GPI28 */


#define	GPI29								0x1D		/*GPI29 */


#define	GPI3								0x3			/*GPI3 */


#define	GPI30								0x1E		/*GPI30 */


#define	GPI31								0x1F		/*GPI31 */


#define	GPI4								0x4			/*GPI4 */


#define	GPI5								0x5			/*GPI5 */


#define	GPI6								0x6			/*GPI6 */


#define	GPI7								0x7			/*GPI7 */


#define	GPI8								0x8			/*GPI8 */


#define	GPI9								0x9			/*GPI9 */


#define	GPI_HIGH							0x1			/*GPIΪߵƽ */

#define	GPI_IN								0x0			/*GPI */

#define	GPI_LOW								0x0			/*GPIΪ͵ƽ */


#define	GPI_OUT								0x1			/*GPI */


#define	HA						BSP_ENABLE


#define	INTERVAL							(SYSTRI32_B_BASEADDR - SYSTRI32_A_BASEADDR)					/*ÿ֮ļС*/


#define	IO_SIZE_16							0x01		/*IOΪ16λ*/


#define	IO_SIZE_32							0x02		/*IOΪ32λ*/


#define	IO_SIZE_8							0x00		/*IOΪ8λ*/


#define	IQR						0


#define	IRQ_MODE 0x12	/*IRQģʽ*/

#define	LEVEL_CRITICAL						(0x555)					/*ؼ*/


#define	LEVEL_NORMAL						(0xAAA)					/*ǹؼ*/


#define	LITTLE_ENDIAN						0x0			/*С*/


#define	LOADERR				(0xaa)			/* receive fail flag */


#define	LOADOK				(0x55)			/* receive success flag */


#define	MMU						BSP_DISABLE


#define	MON_MODE 0x16	/*Monitorģʽ*/

#define	NS						0


#define	NSASEDIS				1


#define	NSD32DIS				1


#define	OSEDISABLE			(0)


#define	OSENABLE			(1)


#define	OS_ERR_INTCONNECT_TT_INVALID		(OS_ERR_INT_LIB  | ( 0x1<<8) | 0x1)	/* жЧ */


#define	OS_ERR_INTERNAL_LIB				( 0xf << 16)		/*ڲ*/

#define	OS_ERR_INT_LIB					( 0x6 << 16)


#define	OS_ERR_INVALID					(0xffffffff)		/* Ч */


#define	OS_ERR_KERSTART_NO_TASK				(OS_ERR_KER_LIB  | ( 0x1<<8) | 0x1)	/* ʱϵͳ */


#define	OS_ERR_KER_LIB					( 0x1 << 16)


#define	OS_ERR_MEMALLOC_NO_FREE_BLOCK		(OS_ERR_MEM_LIB  | ( 0x1<<8) | 0x1)	/* ޿õĿп */


#define	OS_ERR_MEMFREE_ID_INVALID			(OS_ERR_MEM_LIB  | ( 0x2<<8) | 0x1)	/* ͷڴıʶЧ */


#define	OS_ERR_MEMFREE_ID_NULL				(OS_ERR_MEM_LIB  | ( 0x2<<8) | 0x2)	/* ͷڴָΪ */


#define	OS_ERR_MEM_LIB					( 0x5 << 16)


#define	OS_ERR_MQDELETE_ID_INVALID			(OS_ERR_MQ_LIB   | ( 0x3<<8) | 0x1)	/* ɾϢеıʶЧ */


#define	OS_ERR_MQQUERY_ID_INVALID			(OS_ERR_MQ_LIB   | ( 0x4<<8) | 0x1)	/* ѯϢеıʶЧ */


#define	OS_ERR_MQQUERY_ID_NULL				(OS_ERR_MQ_LIB   | ( 0x4<<8) | 0x2)	/* ѯϢָΪ */


#define	OS_ERR_MQREC_CALL_IN_INT			(OS_ERR_MQ_LIB   | ( 0x2<<8) | 0x2)	/* жϷнϢ */


#define	OS_ERR_MQREC_CALL_IN_LOCK			(OS_ERR_MQ_LIB   | ( 0x2<<8) | 0x5)	/* ڵʱȡϢǰ */


#define	OS_ERR_MQREC_ID_INVALID				(OS_ERR_MQ_LIB   | ( 0x2<<8) | 0x1)	/* ϢеıʶЧ */


#define	OS_ERR_MQREC_MSGSIZE_OVER			(OS_ERR_MQ_LIB   | ( 0x2<<8) | 0x3)	/* ϢĳȴڿԽϢ󳤶 */


#define	OS_ERR_MQREC_TIMEOUT				(OS_ERR_MQ_LIB   | ( 0x2<<8) | 0x4)	/* յȴϢʱ */


#define	OS_ERR_MQSEND_ID_INVALID			(OS_ERR_MQ_LIB   | ( 0x1<<8) | 0x1)	/* ϢеıʶЧ */


#define	OS_ERR_MQSEND_MSGSIZE_OVER			(OS_ERR_MQ_LIB   | ( 0x1<<8) | 0x2)	/* ϢĳȴڿܷϢ󳤶 */


#define	OS_ERR_MQSEND_PTR_NULL				(OS_ERR_MQ_LIB   | ( 0x1<<8) | 0x4)	/* ϢָΪ */


#define	OS_ERR_MQSEND_QUEUE_FULL			(OS_ERR_MQ_LIB   | ( 0x1<<8) | 0x3)	/* ϢϢ */


#define	OS_ERR_MQ_LIB					( 0x4 << 16)


#define	OS_ERR_OK						(0x0)				/* ޴ */


#define	OS_ERR_OTHER_LIB				( 0x8 << 16)		/*20111025,added by ql*/


#define	OS_ERR_SEMDELETE_ID_INVALID			(OS_ERR_SEM_LIB  | ( 0x3<<8) | 0x1)	/* ɾźıʶЧ */


#define	OS_ERR_SEMDELETE_ID_NULL			(OS_ERR_SEM_LIB  | ( 0x3<<8) | 0x2)	/* ɾźıʶΪadded by ql,20110624  */


#define	OS_ERR_SEMDELETE_SEMOWNER_ID_NULL	(OS_ERR_SEM_LIB  | ( 0x3<<8) | 0x3)	/* ɾźӵΪգadded by xj,20110624  */


#define	OS_ERR_SEMFLUSH_ID_INVALID			(OS_ERR_SEM_LIB  | ( 0x4<<8) | 0x1)	/* յźıʶЧ */


#define	OS_ERR_SEMFLUSH_ID_NULL				(OS_ERR_SEM_LIB  | ( 0x4<<8) | 0x2)	/* յźָΪ*/


#define	OS_ERR_SEMGIVE_ID_INVALID			(OS_ERR_SEM_LIB  | ( 0x2<<8) | 0x1)	/* ͷźıʶЧ */


#define	OS_ERR_SEMGIVE_ID_NULL				(OS_ERR_SEM_LIB  | ( 0x2<<8) | 0x4)	/* ͷźıʶΪadded by ql,20110624 */


#define	OS_ERR_SEMGIVE_MUTEX_GIVE_INT		(OS_ERR_SEM_LIB  | ( 0x2<<8) | 0x2)	/* жͷŻź */


#define	OS_ERR_SEMGIVE_MUTEX_GIVE_LOCK		(OS_ERR_SEM_LIB  | ( 0x2<<8) | 0x3)	/* ռͷŻź */


#define	OS_ERR_SEMTAKE_CALL_IN_INT			(OS_ERR_SEM_LIB  | ( 0x1<<8) | 0x2)	/* жȡź */


#define	OS_ERR_SEMTAKE_CALL_IN_LOCK			(OS_ERR_SEM_LIB  | ( 0x1<<8) | 0x3)	/* ڵʱȡźǰ */


#define	OS_ERR_SEMTAKE_ID_INVALID			(OS_ERR_SEM_LIB  | ( 0x1<<8) | 0x1)	/* ȡźıʶЧ */


#define	OS_ERR_SEMTAKE_ID_NULL				(OS_ERR_SEM_LIB  | ( 0x1<<8) | 0x5)	/* ȡźıʶΪadded by ql,20110624 */


#define	OS_ERR_SEMTAKE_TIMEOUT				(OS_ERR_SEM_LIB  | ( 0x1<<8) | 0x4)	/* ȡźʱ */


#define	OS_ERR_SEM_LIB					( 0x3 << 16)


#define	OS_ERR_SET_ERRNO(errno)			do {OSErrNo = (errno);}while(0) 


#define	OS_ERR_STKREC_ALLOC_OVERFLOW		(OS_ERR_OTHER_LIB| ( 0x1<<8) | 0x1)	/* ջ¼ 20111025,ql*/


#define	OS_ERR_TASKDELAY_CALL_IN_INT		(OS_ERR_TASK_LIB | ( 0x4<<8) | 0x1)	/* жʱ */


#define	OS_ERR_TASKDELAY_CALL_IN_LOCK		(OS_ERR_TASK_LIB | ( 0x4<<8) | 0x2)	/* ʱʱ */


#define	OS_ERR_TASKDELETE_CALL_IN_INT		(OS_ERR_TASK_LIB | ( 0x1<<8) | 0x3)	/* жɾ */


#define	OS_ERR_TASKDELETE_ID_INVALID		(OS_ERR_TASK_LIB | ( 0x1<<8) | 0x1)	/* ɾıʶЧ */


#define	OS_ERR_TASKDELETE_ID_NULL			(OS_ERR_TASK_LIB | ( 0x1<<8) | 0x4)	/* ɾıʶΪadded by ql,20110624 */


#define	OS_ERR_TASKDELETE_SYS_TASK			(OS_ERR_TASK_LIB | ( 0x1<<8) | 0x2)	/* ɾϵͳ */


#define	OS_ERR_TASKPRIOSET_SYS_TASK			(OS_ERR_TASK_LIB | ( 0x6<<8) | 0x1)	/* ıϵͳȼ */


#define	OS_ERR_TASKRESTART_ID_INVALID		(OS_ERR_TASK_LIB | ( 0x5<<8) | 0x1)	/* ıʶЧ */


#define	OS_ERR_TASKRESTART_ID_NULL			(OS_ERR_TASK_LIB | ( 0x5<<8) | 0x2)	/* ָΪ */


#define	OS_ERR_TASKRESUME_ID_INVALID		(OS_ERR_TASK_LIB | ( 0x3<<8) | 0x1)	/* ָıʶЧ */


#define	OS_ERR_TASKRESUME_ID_NULL			(OS_ERR_TASK_LIB | ( 0x3<<8) | 0x2)	/* ָıʶΪadded by ql,20110624 */


#define	OS_ERR_TASKSTACK_REC_ALLOC_FAIL		(OS_ERR_TASK_LIB | ( 0x7<<8) | 0x1)	/*񴴽ʱջ¼*/


#define	OS_ERR_TASKSUSPEND_CALL_IN_INT		(OS_ERR_TASK_LIB | ( 0x2<<8) | 0x2)	/* жй */


#define	OS_ERR_TASKSUSPEND_CALL_IN_LOCK		(OS_ERR_TASK_LIB | ( 0x2<<8) | 0x3)	/* ʱ */


#define	OS_ERR_TASKSUSPEND_ID_INVALID		(OS_ERR_TASK_LIB | ( 0x2<<8) | 0x1)	/* ıʶЧ */


#define	OS_ERR_TASKSUSPEND_ID_NULL			(OS_ERR_TASK_LIB | ( 0x2<<8) | 0x5)	/* ָΪ */


#define	OS_ERR_TASKSUSPEND_SYS_TASK			(OS_ERR_TASK_LIB | ( 0x2<<8) | 0x4)	/* ϵͳ */


#define	OS_ERR_TASK_LIB					( 0x2 << 16)


#define	OS_ERR_TIMEEVENTSET_TIME_INVALID	 (OS_ERR_TIME_LIB| ( 0x1<<8) | 0x1)	/* ʱʱ趨ֵЧ */


#define	OS_ERR_TIME_LIB					( 0x7 << 16)


#define	OS_TASK_DELAY_OUT					(0xFFFFFFFD)	/* ȥ˯̬ */


#define	OS_TASK_PEND_OUT					(0xFFFFFFFB)	/* ȥ̬ */


#define	OS_TASK_READY_OUT					(0xFFFFFFFE)	/* ȥ̬ */


#define	OS_TASK_RUN_OUT						(0xFFFFFFEF)	/* ȥ̬ */


#define	OS_TASK_SUSPEND_OUT					(0xFFFFFFF7)	/* ȥ̬ */


#define	PRIVATETIMER_FREQ						(CPU_FREQ)			/* Private Timers Freq*/


#define	PRIVATETIMER_FREQ_DIVIDED_PARAM 		(ALLTIMER_FREQ_DIVIDED_PARAM)		 /*Select from:0;1;2*/


#define	PROM_128K							0x04		/*PROMΪ128k*/


#define	PROM_128M							0x0e		/*PROMΪ128M*/


#define	PROM_16K							0x01		/*PROMΪ16k*/


#define	PROM_16M							0x0b		/*PROMΪ16M*/


#define	PROM_1M								0x07		/*PROMΪ1M*/


#define	PROM_256K							0x05		/*PROMΪ256k*/


#define	PROM_256M							0x0f		/*PROMΪ256M*/


#define	PROM_2M								0x08		/*PROMΪ2M*/


#define	PROM_32K							0x02		/*PROMΪ32k*/


#define	PROM_32M							0x0c		/*PROMΪ32M*/


#define	PROM_4M								0x09		/*PROMΪ4M*/


#define	PROM_512K							0x06		/*PROMΪ512k*/


#define	PROM_512M							0x10		/*PROMΪ512M*/


#define	PROM_64K							0x03		/*PROMΪ64k*/


#define	PROM_64M							0x0d		/*PROMΪ64M*/


#define	PROM_8K								0x00		/*PROMΪ8k*/


#define	PROM_8M								0x0a		/*PROMΪ8M*/


#define	PROM_SIZE_16						0x01		/*PROMΪ16λ*/


#define	PROM_SIZE_32						0x02		/*PROMΪ32λ*/


#define	PROM_SIZE_8							0x00		/*PROMΪ8λ*/


#define	RFQ						0


#define	RR						0


#define	SDRAM_128M							0x0C		/*SDRAMΪ128M*/


#define	SDRAM_128k							0x02		/*SDRAMΪ128K*/


#define	SDRAM_16M							0x09		/*SDRAMΪ16M*/


#define	SDRAM_1G							0x0F		/*SDRAMΪ1G*/


#define	SDRAM_1M							0x05		/*SDRAMΪ1M*/


#define	SDRAM_256M							0x0D		/*SDRAMΪ256M*/


#define	SDRAM_256k							0x03		/*SDRAMΪ256K*/


#define	SDRAM_2M							0x06		/*SDRAMΪ2M*/


#define	SDRAM_32M							0x0A		/*SDRAMΪ32M*/


#define	SDRAM_4M							0x07		/*SDRAMΪ4M*/


#define	SDRAM_512M							0x0E		/*SDRAMΪ512M*/


#define	SDRAM_512k							0x04		/*SDRAMΪ512K*/


#define	SDRAM_64M							0x0B		/*SDRAMΪ64M*/


#define	SDRAM_64k							0x01		/*SDRAMΪ64K*/


#define	SDRAM_8M							0x08		/*SDRAMΪ8M*/


#define	SDRAM_AUTO_REFRESH					0x02		/*SDRAM*/


#define	SDRAM_LOAD_COMMAND_REGISTER			0x03		/*SDRAM*/


#define	SDRAM_NOCMD							0x00		/*SDRAM*/


#define	SDRAM_PRECHAREGE					0x01		/*SDRAM*/


#define	SPW_FIFO_MAX_LEN					(0x38)


#define	SRAM_1024M							0x11		/*SRAMΪ1024M*/


#define	SRAM_128K							0x04		/*SRAMΪ128k*/


#define	SRAM_128M							0x0e		/*SRAMΪ128M*/


#define	SRAM_16K							0x01		/*SRAMΪ16k*/


#define	SRAM_16M							0x0b		/*SRAMΪ16M*/


#define	SRAM_1M								0x07		/*SRAMΪ1M*/


#define	SRAM_256K							0x05		/*SRAMΪ256k*/


#define	SRAM_256M							0x0f		/*SRAMΪ256M*/


#define	SRAM_2M								0x08		/*SRAMΪ2M*/


#define	SRAM_32K							0x02		/*SRAMΪ32k*/


#define	SRAM_32M							0x0c		/*SRAMΪ32M*/


#define	SRAM_4M								0x09		/*SRAMΪ4M*/


#define	SRAM_512K							0x06		/*SRAMΪ512k*/


#define	SRAM_512M							0x10		/*SRAMΪ512M*/


#define	SRAM_64K							0x03		/*SRAMΪ64k*/


#define	SRAM_64M							0x0d		/*SRAMΪ64M*/


#define	SRAM_8K								0x00		/*SRAMΪ8k*/


#define	SRAM_8M								0x0a		/*SRAMΪ8M*/


#define	SRAM_SIZE_16						0x01		/*SRAMΪ16λ*/


#define	SRAM_SIZE_32						0x02		/*SRAMΪ32λ*/


#define	SRAM_SIZE_8							0x00		/*SRAMΪ8λ*/


#define	SUMERR				(0xbb)			/* receive sum err flag*/


#define	SVC_MODE 0x13	/*Supervisorģʽ*/

#define	SW						BSP_DISABLE


#define	SYSTASKNUM							(6)


#define	SYSTRI32_A_BASEADDR					( XWTRI32_A_BASEADDR+XWTRI32_EACHSIZE+SYS_ISOLATION_SIZE)	/*ϵͳȡһ׵ַ*/

#define	SYSTRI32_B_BASEADDR					( XWTRI32_B_BASEADDR+XWTRI32_EACHSIZE+SYS_ISOLATION_SIZE)


#define	SYSTRI32_C_BASEADDR					( XWTRI32_C_BASEADDR+XWTRI32_EACHSIZE+SYS_ISOLATION_SIZE)


#define	SYSTRI32_EACHSIZE					(4*1024)/*ϵͳȡһĴС*/


#define	SYS_CONTROL_PERIOD_WAITING_COUNT		(3) 


#define	SYS_Get(addr)					(*(V_U32 *)((U32)(addr)))


#define	SYS_ISOLATION_SIZE					(512)							/*ȡڸС0.5k*/


#define	SYS_LESS_COMMON_TRAP_INFO_RECORD_BASE		(SYS_SEU_TRAP_INFO_RECORD_BASE+SYS_SEU_TRAP_INFO_RECORD_SIZE)


#define	SYS_MAX_CAUSERELOAD_REBOOTCNT		(3)


#define	SYS_MAX_CAUSESWITCH_REBOOTCNT		(5)


#define	SYS_MAX_FLASH_Read_Size				(0x80)	/*ÿNorFlash*/


#define	SYS_MAX_FLASH_Write_Size			(0x08)	/*ÿдNorFlash*/


#define	SYS_MODE 0x1f	/*Systemģʽ*/		

/*ж϶*/

#define	SYS_PERIOD1_PERIOD_TIME_MS   (SYS_PERIOD_TIME_MS)


#define	SYS_PERIOD1_TASK_NUM (SYSTASKNUM)


#define	SYS_PERIOD1_TASK_OFFSET (0)


#define	SYS_PERIOD2_PERIOD_TIME_MS   (0)


#define	SYS_PERIOD2_TASK_NUM (0)


#define	SYS_PERIOD2_TASK_OFFSET (SYS_PERIOD1_TASK_NUM)


#define	SYS_PERIOD3_PERIOD_TIME_MS   (0)


#define	SYS_PERIOD3_TASK_NUM (0)


#define	SYS_PERIOD3_TASK_OFFSET (0)


#define	SYS_PERIOD4_PERIOD_TIME_MS   (0)


#define	SYS_PERIOD4_TASK_NUM (0)


#define	SYS_PERIOD4_TASK_OFFSET (0)


#define	SYS_PERIOD_TIME_MS					(128)


#define	SYS_SEU_TRAP_INFO_RECORD_BASE				(MEM_TRAP_INFO_RECORD_BASE)		 


#define	SYS_Set(addr,value)				(*(V_U32 *)((U32)(addr))=(value))


#define	SYS_TASK10_Allocated_TIME_MS		(0)


#define	SYS_TASK10_LEVEL					LEVEL_NORMAL


#define	SYS_TASK10_STACK_SIZE				(16*1024)


#define	SYS_TASK10_START_TIME_MS			(0xFFFFFFFF)


#define	SYS_TASK11_Allocated_TIME_MS		(0)


#define	SYS_TASK11_LEVEL					LEVEL_NORMAL


#define	SYS_TASK11_STACK_SIZE				(16*1024)


#define	SYS_TASK11_START_TIME_MS			(0xFFFFFFFF)


#define	SYS_TASK12_Allocated_TIME_MS		(0)


#define	SYS_TASK12_LEVEL					LEVEL_NORMAL


#define	SYS_TASK12_STACK_SIZE				(16*1024)


#define	SYS_TASK12_START_TIME_MS			(0xFFFFFFFF)


#define	SYS_TASK13_Allocated_TIME_MS		(0)


#define	SYS_TASK13_LEVEL					LEVEL_NORMAL


#define	SYS_TASK13_STACK_SIZE				(16*1024)


#define	SYS_TASK13_START_TIME_MS			(0xFFFFFFFF)


#define	SYS_TASK14_Allocated_TIME_MS		(0)


#define	SYS_TASK14_LEVEL					LEVEL_NORMAL


#define	SYS_TASK14_STACK_SIZE				(16*1024)


#define	SYS_TASK14_START_TIME_MS			(0xFFFFFFFF)


#define	SYS_TASK15_Allocated_TIME_MS		(0)


#define	SYS_TASK15_LEVEL					LEVEL_NORMAL


#define	SYS_TASK15_STACK_SIZE				(16*1024)


#define	SYS_TASK15_START_TIME_MS			(0xFFFFFFFF)


#define	SYS_TASK16_Allocated_TIME_MS		(0)


#define	SYS_TASK16_LEVEL					LEVEL_NORMAL


#define	SYS_TASK16_STACK_SIZE				(16*1024)


#define	SYS_TASK16_START_TIME_MS			(0xFFFFFFFF)


#define	SYS_TASK1_Allocated_TIME_MS			(20)


#define	SYS_TASK1_LEVEL						LEVEL_CRITICAL


#define	SYS_TASK1_STACK_SIZE				(32*1024)


#define	SYS_TASK1_START_TIME_MS				(0)


#define	SYS_TASK2_Allocated_TIME_MS			(36)


#define	SYS_TASK2_LEVEL						LEVEL_CRITICAL


#define	SYS_TASK2_STACK_SIZE				(64*1024)


#define	SYS_TASK2_START_TIME_MS				(20)


#define	SYS_TASK3_Allocated_TIME_MS			(8)


#define	SYS_TASK3_LEVEL						LEVEL_CRITICAL


#define	SYS_TASK3_STACK_SIZE				(16*1024)


#define	SYS_TASK3_START_TIME_MS				(56)


#define	SYS_TASK4_Allocated_TIME_MS			(8)


#define	SYS_TASK4_LEVEL						LEVEL_CRITICAL


#define	SYS_TASK4_STACK_SIZE				(16*1024)


#define	SYS_TASK4_START_TIME_MS				(64)


#define	SYS_TASK5_Allocated_TIME_MS			(16)


#define	SYS_TASK5_LEVEL						LEVEL_NORMAL


#define	SYS_TASK5_STACK_SIZE				(16*1024)


#define	SYS_TASK5_START_TIME_MS				(72)


#define	SYS_TASK6_Allocated_TIME_MS			(40)


#define	SYS_TASK6_LEVEL						LEVEL_CRITICAL


#define	SYS_TASK6_STACK_SIZE				(32*1024)


#define	SYS_TASK6_START_TIME_MS				(88)


#define	SYS_TASK7_Allocated_TIME_MS			(0)


#define	SYS_TASK7_LEVEL						LEVEL_NORMAL


#define	SYS_TASK7_STACK_SIZE				(16*1024)


#define	SYS_TASK7_START_TIME_MS				(0xFFFFFFFF)


#define	SYS_TASK8_Allocated_TIME_MS			(0)


#define	SYS_TASK8_LEVEL						LEVEL_NORMAL


#define	SYS_TASK8_STACK_SIZE				(16*1024)


#define	SYS_TASK8_START_TIME_MS				(0xFFFFFFFF)


#define	SYS_TASK9_Allocated_TIME_MS			(0)


#define	SYS_TASK9_LEVEL						LEVEL_NORMAL


#define	SYS_TASK9_STACK_SIZE				(16*1024)


#define	SYS_TASK9_START_TIME_MS				(0xFFFFFFFF)


#define	SYS_Tr32_Get(addr) 				(UTIL_Tr32_Get((V_U32 *)((U32)(addr)) ,(V_U32 *)(((U32)(addr))+INTERVAL), (V_U32 *)(((U32)(addr))+2*INTERVAL)))


#define	SYS_Tr32_Set(addr,value)		(UTIL_Tr32_Set((V_U32 *)((U32)(addr)) ,(V_U32 *)(((U32)(addr))+INTERVAL), (V_U32 *)(((U32)(addr))+2*INTERVAL),(U32)(value)))


#define	TASK_SCHED_INTERFACE_SWITCH_FLAG	(0xeb900000)


#define	TASK_SCHED_MODE_FOUR				(0x3)					/*ֵģʽ*/


#define	TASK_SCHED_MODE_ONE					(0x0)					/*һֵģʽ*/


#define	TASK_SCHED_MODE_THREE				(0x2)					/*ֵģʽ*/


#define	TASK_SCHED_MODE_TWO					(0x1)					/*ڶֵģʽ*/


#define	TE						BSP_DISABLE


#define	TIMER_DISABLE						0x00		/*ʱֹ*/


#define	TIMER_ENABLE						0x01		/*ʱʹ*/


#define	TIMER_ONESHOT						0x00		/*μ*/


#define	TIMER_RELOAD						0x01		/*ʹ*/

#define	TRE						BSP_DISABLE


#define	UND_MODE 0x1b	/*Undefinedģʽ*/


#define	USR_MAXCNT_SEU						(10)


#define	USR_MODE 0x10	/*ûģʽ*/

#define	UserDefBlock1BeginAddr	(INVALID)	//ʼַ


#define	UserDefBlock1CopyAddr1	(INVALID)	//ݵַ1


#define	UserDefBlock1CopyAddr2	(INVALID)	//ݵַ2


#define	UserDefBlock1Func		(SYS_RamDefault_Handle)	//ҽӺ


#define	UserDefBlock1Size		(INVALID)	//ռܴС磺ǿռȡÿȡΪ3KܴСӦд9K


#define	UserDefBlock1Type		(INVALID)	// (0~2)


#define	UserDefBlock2BeginAddr	(INVALID)	//ʼַ


#define	UserDefBlock2CopyAddr1	(INVALID)	//ݵַ1


#define	UserDefBlock2CopyAddr2	(INVALID)	//ݵַ2


#define	UserDefBlock2Func		(SYS_RamDefault_Handle)	//ҽӺ


#define	UserDefBlock2Size		(INVALID)	//ռܴС磺ǿռȡÿȡΪ3KܴСӦд9K


#define	UserDefBlock2Type		(INVALID)	// (0~2)


#define	UserDefBlock3BeginAddr	(INVALID)	//ʼַ


#define	UserDefBlock3CopyAddr1	(INVALID)	//ݵַ1


#define	UserDefBlock3CopyAddr2	(INVALID)	//ݵַ2


#define	UserDefBlock3Func		(SYS_RamDefault_Handle)	//ҽӺ


#define	UserDefBlock3Size		(INVALID)	//ռܴС磺ǿռȡÿȡΪ3KܴСӦд9K


#define	UserDefBlock3Type		(INVALID)	// (0~2)


#define	UserDefBlock4BeginAddr	(INVALID)	//ʼַ


#define	UserDefBlock4CopyAddr1	(INVALID)	//ݵַ1


#define	UserDefBlock4CopyAddr2	(INVALID)	//ݵַ2


#define	UserDefBlock4Func		(SYS_RamDefault_Handle)	//ҽӺ


#define	UserDefBlock4Size		(INVALID)	//ռܴС磺ǿռȡÿȡΪ3KܴСӦд9K


#define	UserDefBlock4Type		(INVALID)	// (0~2)


#define	V						0


#define	VE						0


#define	WANTEDKEY			(0x6f)			/* keyflag*/


#define	WTDTIMER_FREQ						(CPU_FREQ)		/* Private Timers Freq*/


#define	WTDTIMER_FREQ_DIVIDED_PARAM			(2)				/*Select from:0;1;2*/


#define	XWTRI32_EACHSIZE					(4*1024)/*OBDHȡһĴС*/


#define	Z						BSP_DISABLE


#define	__AppTask10__						AppTask9


#define	__AppTask11__						AppTask10


#define	__AppTask12__						AppTask11


#define	__AppTask13__						AppTask12


#define	__AppTask14__						AppTask13


#define	__AppTask15__						AppTask14


#define	__AppTask16__						AppTask15


#define	__AppTask1__						AppTask1


#define	__AppTask2__						AppTask2  


#define	__AppTask3__						SYSTMRTask


#define	__AppTask4__						AppTask3


#define	__AppTask5__						SYS_ManageTask


#define	__AppTask6__						AppTask4


#define	__AppTask7__						AppTask6


#define	__AppTask8__						AppTask7


#define	__AppTask9__						AppTask8


#define	__INT_1553B_0_FUNC__			SYS_ISR_Default_Hook


#define	__INT_1553B_1_FUNC__			SYS_ISR_Default_Hook


#define	__INT_GPIO_4_FUNC__				SYS_ISR_Default_Hook


#define	__INT_GPIO_5_FUNC__				SYS_ISR_Default_Hook


#define	__INT_GPIO_6_FUNC__				SYS_ControlPeriodInt


#define	__INT_GPIO_7_FUNC__				SYS_ISR_Default_Hook


#define	__INT_IOASIC_0_FUNC__			SYS_ISR_Default_Hook


#define	__INT_IOASIC_1_FUNC__			SYS_ISR_Default_Hook


#define	__INT_IOASIC_2_FUNC__			SYS_ISR_Default_Hook


#define	__INT_SPW_0_FUNC__				SYS_ISR_Default_Hook


#define	__INT_SPW_1_FUNC__				SYS_ISR_Default_Hook


#define	__INT_SPW_2_FUNC__				SYS_ISR_Default_Hook


#define	__INT_SPW_3_FUNC__				SYS_ISR_Default_Hook


#define	__ROM_CS0_FUNC__				SYS_RomTBE_Handle_DefaultHandler


#define	__ROM_CS1_FUNC__				SYS_RomTBE_Handle_DefaultHandler


#define	__ROM_CS2_FUNC__				SYS_NorFlashTrapEdacHandlerHook


#define	__ROM_CS3_FUNC__				SYS_RomTBE_Handle_DefaultHandler


#define	nCP						1


#define	nET						BSP_DISABLE


#define          FL64LMT          0x82            /* 双精度比较区间 */


#define          UN32LMT          0x20            /* 无符号整数比较区间 */


#define        BLACK_BOX_DATA1     0x00093800u        /* 异常数据存储区A   */


#define        BLACK_BOX_DATA2     0x00094C00u        /* 异常数据存储区B   */


#define        FISRT_BASE          0x00118200u        /* I区基地址               */


#define        FLT64_ERR          0x00AAAA11u        /* 64位浮点带容差           */


#define        FLT64_TO_FL32_ERR  0x00AAAA22u        /* 64位浮点带容差(以32位浮点比较) */


#define        JET_TEST_DATA       0x00096000u        /* 发动机试喷数据存储地址    */


#define        LLONG64_ERR        0x00AABB11u        /* 64位整型带容差           */


#define        ORB_CTRL_DATA       0x00096000u        /* 轨控数据存储地址         */


#define        SCHY_FLG           0x00DD0022u        /* 同步标志                */


#define        SECOND_BASE         0x0011B800u        /* II区基地址              */


#define        SRAM_BASE           0x40000000u        /* SRAM区基地址            */


#define        SRAM_END            0x401FFFFCu        /* SOC地址空间 SRAM区尾地址 */


#define        STS_PK_DOWN         0x00093400u        /* 星敏下传包缓存地址       */


#define        STS_PK_UP           0x00093000u        /* 星敏注入包缓存地址       */


#define        THIRD_BASE          0x0011EE00u        /* III区基地址             */


#define        TMRDATA_A          0x001FAC00u        /* 本机三机数据区           */


#define        TMRDATA_B          0x001FBE00u        /* 另机三机数据区           */


#define        TMRDATA_C          0x001FD000u        /* 另另机三机数据区         */


#define        TMRDATA_D          0x001FE200u        /* 三机数据交换与比对数据结果区 */


#define        UN08_CODE          0x00CCBB00u        /* 08位整型无容差           */


#define        UN32_CODE          0x00BBBB00u        /* 32位整型无容差           */


#define      ASSERT(x)      assert((x))


#define     CLOSELOOP_I     (volatile unint32 *)( SRAM_BASE + FISRT_BASE + 0x10 )     /* IջƱ־ */


#define     CLOSELOOP_II    (volatile unint32 *)( SRAM_BASE + SECOND_BASE + 0x10 )    /* IIջƱ־ */


#define     CLOSELOOP_III   (volatile unint32 *)( SRAM_BASE + THIRD_BASE + 0x10 )     /* IIIջƱ־ */


#define     DBL_PI          6.283185307179586        /* 2PIֵ */


#define     DEG2RAD         0.0174532925199433       /* תȳ˻ϵ */


#define     EARTH_ALPHA     1.0/298.257              /* ο */


#define     EARTH_Mu        3.986005e14              /*  */


#define     EARTH_R         6378140.0                /* 뾶 */


#define     EARTH_W         7.292115e-5              /* תٶ */


#define     FIRST_MODE          (volatile unint32 *)( SRAM_BASE + FISRT_BASE + 0x08 )     /* I区模式 */


#define     FIRST_SUBMODE       (volatile unint32 *)( SRAM_BASE + FISRT_BASE + 0x0C )     /* I区子模式 */


#define     FIRST_TIME          (volatile ulong64 *)( SRAM_BASE + FISRT_BASE )     /* I区星时 */


#define     FLT32_ZERO      1.0e-7f                  /* 32λ0Ƚ */


#define     FLT64_ZERO      1.0e-14                  /* 64λ0Ƚ */


#define     FOGWIN_I        (volatile unint32 *)( SRAM_BASE + FISRT_BASE + 0x14 )     /* IͨѶ */


#define     FOGWIN_II       (volatile unint32 *)( SRAM_BASE + SECOND_BASE + 0x14 )    /* IIͨѶ */


#define     FOGWIN_III      (volatile unint32 *)( SRAM_BASE + THIRD_BASE + 0x14 )     /* IIIͨѶ */


#define     HALF_PI         1.570796326794897        /* PIֵ */


#define     ONE_PRD             (128000u)     /* 1周期 = 128ms = 128000us       */


#define     PI              3.141592653589793        /* PIֵ */


#define     POW_2E_N10      9.765625e-4              /* pow(2, -10) */


#define     POW_2E_N11      4.8828125e-4             /* pow(2, -11) */


#define     POW_2E_N14      6.103515625e-5           /* pow(2, -14) */


#define     POW_2E_N15      3.0517578125e-5          /* pow(2, -15) */


#define     POW_2E_N22      2.384185791015625e-7     /* pow(2, -22) */


#define     POW_2E_N24      5.960464477539063e-8     /* pow(2, -24) */


#define     POW_2E_N30      9.313225746154785e-10    /* pow(2, -30) */


#define     POW_2E_N31      4.6566128730773925e-10   /* pow(2, -31) */


#define     POW_2E_N6       1.5625e-2                /* pow(2, -6 ) */


#define     RAD2DEG         57.29577951308232        /* תȳ˻ϵ */


#define     Roundx(x)       (((x)>0) ? Floorx((x)+0.5) : Ceilx((x)-0.5))    /* ȼ (((x)>0) ? (siint32)((x)+0.5) : (siint32)((x)-0.5))  */


#define     SECOND_MODE         (volatile unint32 *)( SRAM_BASE + SECOND_BASE + 0x08 )    /* II区模式 */


#define     SECOND_SUBMODE      (volatile unint32 *)( SRAM_BASE + SECOND_BASE + 0x0C )    /* II区子模式 */


#define     SECOND_TIME         (volatile ulong64 *)( SRAM_BASE + SECOND_BASE )    /* II区星时 */


#define     THIRD_MODE          (volatile unint32 *)( SRAM_BASE + THIRD_BASE + 0x08 )     /* III区模式 */


#define     THIRD_SUBMODE       (volatile unint32 *)( SRAM_BASE + THIRD_BASE + 0x0C )     /* III区子模式 */


#define     THIRD_TIME          (volatile ulong64 *)( SRAM_BASE + THIRD_BASE )     /* III区星时 */


#define     TR32_MODE()          (Tr32Uint(FIRST_MODE, SECOND_MODE, THIRD_MODE))


#define     TR32_SUBMODE()       (Tr32Uint(FIRST_SUBMODE, SECOND_SUBMODE, THIRD_SUBMODE))


#define     TR64_TIME()         ( Tr64Ulong( FIRST_TIME, SECOND_TIME, THIRD_TIME ) )


#define     TR64_TIME_VALUE(x)  { Tr64UlongValue( FIRST_TIME, SECOND_TIME, THIRD_TIME, (x) ); }


#define     UART_ERR_CHECKSUM   (0x6u)      /* 串口接收数据校验和错误 */


#define     UART_ERR_FIFO       (0x8u)      /* 串口接收FIFO字节数为0 */


#define     UART_ERR_FRAMEHEAD  (0x5u)      /* 串口接收数据帧头错误 */


#define     UART_ERR_STATUS     (0x7u)      /* 串口接收数据自检字错误 */


#define     WINLEN          100


#define    ACC_RCV_LEN                (9u)            /* ճ                */


#define    ACC_SND_LEN                (2u)            /* ͳ                */


#define    APSVI_RCV_LEN              (106u)           /* 接收长度                */


#define    CLOSETEST_RCV_LEN          (128u)           /* 接收长度                */


#define    CLOSETEST_SND_LEN          (15u)            /* 发送长度                */


#define    DEV_TOTAL       18			/*  */


#define    DSS_RCV_LEN                (10u)           /* 接收长度                */


#define    DSS_SND_LEN                (2u)            /* 发送长度                */


#define    FOG_RCV_LEN                (13u)            /* ճ                */


#define    FOG_SND_LEN                (2u)            /* ͳ                */


#define    HOLD_OFF    0xC5	   /* ϵ籣ָ	ͣתϵ籣 */


#define    HOLD_ON     0xC0	   /* ӵ籣ָ	ͣתӵ籣 */


#define    ICU_RCV_LEN                (33u)            /* ճ                */


#define    ICU_SND_LEN                (19u)            /* ͳ                */


#define    J3000N_NULL             (0u)             /* 3000N        */


#define    J3000N_OFF              (0x55555555u )   /* 3000Nر          */


#define    J3000N_ON               (0xBBBBBBBBu)    /* 3000Nջ */


#define    J3000N_ON_OPENLOOP      (0xAAAAAAAAu)    /* 3000N */


#define    J3000N_VAL_OFF          (0x555555AAu )   /* LVG3~6ر          */


#define    JET_RCV_LEN                (3u)             /* 接收长度                */


#define    JET_SND_LEN                (30u)            /* 发送长度                */


#define    MODE_TOTAL       14			/*  */


#define    STNUM2                  (12u)            /*   */

#define    STS_RCV_LEN                (105u)           /* 接收长度                */


#define    TARG_270    0xBB	   /* 270ָǿָ	ݵǰתǣ0.6o/s-0.6o/sͽתת270 o״̬ڸλá */


#define    TARG_90     0xB8	   /* 90ָǿָ	ݵǰתǣ0.6o/s-0.6o/sͽתת90 o״̬ڸλá */


#define    TARG_PI     0xB1	   /* 180ָǿָ	ݵǰתǣ0.6/sתת180״̬ϵ籣֡ */


#define    TARG_ZERO   0xB6	   /* ˮƽָ	ݵǰתǣ0.6o/s-0.6o/sͽתλ״̬ڸλá */


#define    TM_ADB_LEN                 (37u)            /* ADB包长度               */


#define    TRACK_N     0xA5	   /* 򲶻ָ	-0.6/sת */


#define    TRACK_P     0xA0	   /* 򲶻ָ	+0.6/sת */


#define  CRC_16_CCITT                 (0x1021u)  /* 多项式 G(x) = X^16 + X^12 + X^5 + 1 */


#define  CRC_INIT_CODE                (0xFFFFu)  /* 初始态多项式全1 */


#define  DRVDISABLE  (0)


#define  DRVENABLE  (1)


#define  DRVFALSE  (0)


#define  DRVHIGH (1)


#define  DRVINVARAANT  (0)//̶


#define  DRVLOW (0)


#define  DRVREV  (1)


#define  DRVTRUE  (1)


#define  DRVUNREV  (0)


#define  DRVUNUSED  (0)


#define  DRVUSED  (1)


#define  DRVVARAANT  (1)//ɱ


#define  DRV_A  (0)//1·can/csb/TM


#define  DRV_B (1)//2·can/csb/TM


#define  DRV_BITIN_IO_GPIO  (1) //λڲɼ־ IOGPIO״̬


#define  DRV_BITIN_IO_PULSE  (0) //λڲɼ־:IOЧԱע


#define  DRV_BITIN_PM_GPIO  (2)//λڲɼ־ PM GPIO״̬


#define  DRV_BITOUT_IO_GPIO  (1) //λ־ 6017 GPIO״̬


#define  DRV_BITOUT_PM_GPIO  (2)//λ־ GPIO״̬


#define  DRV_CAN_NO_ERROR  (0xffffeeee) //ںŴ


#define  DRV_CLK_100M (100)//ƵΪ100M


#define  DRV_CLK_100M_PERIOD (10)//ƵΪ100MʱΪ10ns


#define  DRV_CLK_16M (16)//ƵΪ16M


#define  DRV_CLK_20M (20)//ƵΪ20M


#define  DRV_CLK_20M_PERIOD (50)//ƵΪ20MʱΪ50ns


#define  DRV_COUNT_CTRL_MODE  (1)


#define  DRV_COUNT_HIGH_MODE  (1)


#define  DRV_COUNT_LOW_MODE  (0)


#define  DRV_COUNT_OTHER_MODE  (2)


#define  DRV_COUNT_SOFT_MODE  (0)


#define  DRV_FIRST_SAMP  (0)//SPI ʱӵ1ز


#define  DRV_GPS_OUTPUT_ADDR  (0x10C8)//GPSѡַ


#define  DRV_Get(addr)                              (*(V_U32 *)((U32)(addr)))


#define  DRV_INT_EDGE_TRIG  (0)//ƽ


#define  DRV_INT_HIGH_TRIG  (1)//ߵƽش


#define  DRV_INT_LOW_TRIG (2)//͵ƽ½ش


#define  DRV_INT_PULSE_TRIG (3)//ش


#define  DRV_NO_ERROR  (0xffffffff)//ӿдnoϷʱֵʱ


#define  DRV_PULSE_PERIOD  (1)


#define  DRV_PULSE_SINGLE  (0)


#define  DRV_SECOND_SAMP (1) //SPI ʱӵ2ز


#define  DRV_STRUCT_MEMBER_ERROR  (0xeeeeeeee)//ӿнṹϷʱֵ


#define  DRV_SYN_SOURCE_EQU_ADDR  (0x1040)//õַ


#define  DRV_SYN_SOURCE_OUTPUT_ADDR  (0x10C4)//ַ


#define  DRV_SYN_SOURCE_PERIOD_ADDR  (0x10B0)//õַ


#define  DRV_SYN_SOURCE_PHASE_ADDR  (0x1070)//λõַ


#define  DRV_SYN_SOURCE_PULSE_ADDR  (0x10C0)//õַ


#define  DRV_SYN_SOURCE_SELECT_ADDR  (0x1044)//׼Դõַ


#define  DRV_SYN_SOURCE_SOURCE_ADDR   (0x100C) //ͬźŻ׼Դѡַ


#define  DRV_SYN_SOURCE_VALID_ADDR  (0x1140)//׼źűõַ


#define  DRV_SYN_SOURCE_WIDTH_ADDR  (0x1090)//õַ


#define  DRV_Set(addr,value)                    (*(V_U32 *)((U32)(addr))=(value))


#define  DRV_Set_High(addr,bit)                (*(V_U32 *)((U32)(addr)) |= (0x1<<((U32)(bit)))) //bitλΪ1λ


#define  DRV_Set_Low(addr,bit)                 (*(V_U32 *)((U32)(addr)) &= (~(0x1<<((U32)(bit)))))//bitλΪ0λ  


#define  DRV_TIME_NO_ERROR  (0xffffffffffffffff)//ʱӿдnoϷʱֵ


#define  DRV_Tr32(data1,data2,data3)      ((((U32)(data1)) & ((U32)(data2)))|(((U32)(data1)) & ((U32)(data3)))|(((U32)(data2)) & ((U32)(data3))))


#define  FALSE32          0x00000000  /* زٶ */


#define  FL32_CODE                0x40            /* 单精度原码赋值 */


#define  FL32_TO_FL64CODE         0x42            /* 单精度转双精度原码赋值 */


#define  FL32_TO_FL64LMT          0x44            /* 单精度转双精度比较区间 */


#define  FL64_CODE                0x80            /* 双精度原码赋值 */


#define  MERGE_SORT_SIZE           100


#define  SORT_ATTRIBUTE_TYPE       unint32


#define  SRVID_CRIDATA_RECV         (1u)


#define  SRVID_CRIDATA_SAVE         (3u)


#define  SRVID_MEM_DONW             (2u)


#define  SRVID_NULL                 (0u)


#define  TCMD_TOTAL          (21u)        /* 数据指令总数 */


#define  TMHEAD_CLOSE_TEST    (0x012Du)        /* 闭环测试遥测 */


#define  TMHEAD_FAST          (0x0028u)        /* 快速遥测 */


#define  TMHEAD_IMUTEST       (0x012Cu)        /* 部件测试快速遥测 */


#define  TMHEAD_MID_E         (0x0029u)        /* 四器中速遥测 */


#define  TMHEAD_MID_M         (0x002Au)        /* 单器中速遥测 */


#define  TMHEAD_SLOW1         (0x002Bu)        /* 慢速速遥测1 */


#define  TMHEAD_SLOW2         (0x002Cu)        /* 慢速速遥测2 */


#define  TMLEN_CLOSE_TEST     (85u)            /* 闭环测试遥测 91B */


#define  TMLEN_FAST           (25u)            /* 快速遥测 31B */


#define  TMLEN_IMUTEST        (88u)            /* 部件测试快速遥测 94B */


#define  TMLEN_MID_E          (74u)            /* 四器中速遥测 80B */


#define  TMLEN_MID_M          (104u)           /* 单器中速遥测 110B */


#define  TMLEN_SLOW1          (144u)           /* 慢速速遥测1 150B */


#define  TMLEN_SLOW2          (144u)           /* 慢速速遥测2 150B */


#define  TR32_MODE_VALUE(x)      { Tr32UintValue(FIRST_MODE, SECOND_MODE, THIRD_MODE, (x)); }


#define  TR32_SUBMODE_VALUE(x)   { Tr32UintValue(FIRST_SUBMODE, SECOND_SUBMODE, THIRD_SUBMODE, (x)); }


#define  TRUE32           0xEB90146F  /* ز涨 */


#define  UN08_TO_FL64CODE         0x26            /* 无符号8位转双精度原码赋值 */


#define  UN08_TO_UN16CODE         0x22            /* 无符号8位转无符号16位赋值 */


#define  UN08_TO_UN32CODE         0x23            /* 无符号8位转无符号32位赋值 */


#define  UN16_TO_UN32             0x27            /* 无符号16位转无符号32位赋值 */


#define  UN32_TO_SI32LMT          0x21            /* 无符号整数转有符号整数比较区间 */


#define  UN64_TO_FL64CODE         0x88            /* 长整型转双精度 */


#define  UPDATA_TOTAL        (35u)        /* 注入数据包总数 */


#define  _UPDATE_TIME_    0x20181219u     /*  ڣ2018-12-19    */


#define  _VER_INFO_       0x00000105u     /*  汾V1.05         */


#define A6017_Param1Add						SYS_NorFlash_ADDAParam1_Base


#define A6017_Param2Add						SYS_NorFlash_ADDAParam2_Base


#define ABSUI_TO_ADDR(ui)           ((unint32 *)(ui))


#define ABSUI_TO_ADDR08(ui)         ((volatile unint08 *)(ui))


#define ABSUI_TO_VADDR(ui)          ((volatile unint32 *)(ui))


#define ABSUI_TO_VADDR32(ui)        ((volatile unint32 *)(ui))


#define ABSX(x)             ((x)>0?(x):(-(x)))    /* ȡֵ                 */


#define ABT_MODE_STACK_SIZE				(8*1024)


#define ABT_MODE_STACK_TOP			((UND_MODE_STACK_TOP - UND_MODE_STACK_SIZE) & 0xfffffff0)


#define ACCEPTANCE_WINDOW_reg				(0x0c)


#define ADDA_KB_SIZE						(2048)


#define ADDR_IS_ALIGN(addr)         (((addr) & 0x3) == 0)


#define ADDR_RANGE_VALIDATE(addr, head, tail)   (((head) <= (addr)) && ((addr) <= (tail)))


#define ADDR_READ(addr)             (*((volatile unint32 *)(addr)))


#define ADDR_READ08(addr)           (*((volatile unint08 *)(addr)))


#define ADDR_READ16(addr)           (*((volatile unint16 *)(addr)))


#define ADDR_TO_ABSUI(ptr)          ((unint32)(ptr))


#define ADDR_WRITE(addr, value)     {(*((volatile unint32 *)(addr))) = (value);}


#define ADDR_WRITE16(addr, val16)   {(*((volatile unint16 *)(addr))) = (val16);}


#define ALL_USR_ISR					(0xfffffff0)


#define AM29LV160D			(2)	//AM29LV160,2MС


#define APB_TIMER_NO_END		(APB_TIMER_NO_START + __APB_TIMER_NUM__ - 1)


#define APB_TIMER_NO_START		(0x2)


#define AUTO_ON_DUTY_BIT1  (17)


#define AUTO_ON_DUTY_BIT2  (18)


#define AUTO_ON_DUTY_VALUE  (1)//0Ϊл1Ϊл


#define Atan2x(x, y)    (atan2((float64)(x), (float64)(y)))


#define Atanx(x)        (atan((float64)(x))               )


#define B1553_0_ERR							(0x1)


#define B1553_0_MEM_BASE		(0x28000000)


#define B1553_0_REG_BASE		(0xA0030000)


#define B1553_1_ERR							(0x2)


#define B1553_1_MEM_BASE		(0x29000000)


#define B1553_1_REG_BASE		(0xA0040000)


#define B1553_ADDR(offno, addrbase)         ((volatile unint32 *)(((offno) << 2u) + (addrbase)))


#define B1553_B0_ERR					(0x2)	//b1553b0_twobits_err


#define B1553_B1_ERR					(0x1)	//b1553b1_twobits_err


#define B1553_CHIP_61580            0x2222


#define B1553_CHIP_63825            0x3333


#define B1553_CHIP_65170            0x1111


#define B1553_CHNL_A                    BC_CTW_D07_CHNL_AB  /* ߴѡͨA */


#define B1553_CHNL_B                    0x0000              /* ߴѡͨB */


#define B1553_CMDSTACK_AREA_A       0x0000


#define B1553_CMDSTACK_AREA_B       0x2000  /* REG CFG1.D13 CURRENT AREA B/A */


#define B1553_CMDWORD_ADDR(cmdw)            (((cmdw) >> 11u) & 0x1Fu)


#define B1553_CMDWORD_ADDR_SET(cmdw, addr)  ((cmdw) = ((cmdw) & (~(0x1Fu << 11u))) | (((addr) & 0x1Fu) << 11u))


#define B1553_CMDWORD_CNTD(cmdw)            ((cmdw)          & 0x1Fu)


#define B1553_CMDWORD_CNTD_SET(cmdw, cntd)  ((cmdw) = ((cmdw) & (~(0x1Fu       ))) | (((cntd) & 0x1Fu)       ))


#define B1553_CMDWORD_SAMC(cmdw)            (((cmdw) >>  5u) & 0x1Fu)


#define B1553_CMDWORD_SAMC_SET(cmdw, samc)  ((cmdw) = ((cmdw) & (~(0x1Fu <<  5u))) | (((samc) & 0x1Fu) <<  5u))


#define B1553_CMDWORD_TRCV(cmdw)            (((cmdw) >> 10u) & 0x01u)


#define B1553_CMDWORD_TRCV_SET(cmdw, trcv)  ((cmdw) = ((cmdw) & (~(0x01u << 10u))) | (((trcv) & 0x01u) << 10u))


#define B1553_GAP				(0x1000)  //@up by V1.03(0.0s)_0118


#define B1553_MODE_BC_ENHANCED          0xD2    /* ENHANCED BC                 */


#define B1553_MODE_BC_NORMAL            0xE1    /* Non-ENHANCED BC (See Note)  */


#define B1553_MODE_IDLE                 0x00    /* Idle */


#define B1553_MODE_MSG_MONI             0xA5    /* Message Monitor             */


#define B1553_MODE_RT_ENHANCED          0x87    /* ENHANCED RT                 */


#define B1553_MODE_RT_MT                0x78    /* Enhanced RT/Message Monitor */


#define B1553_MODE_RT_NORMAL            0x96    /* Non-ENHANCED RT             */


#define B1553_MODE_WORD1_MONI           0xC3    /* Word Monitor                */


#define B1553_MODE_WORD2_MONI           0xB4    /* Word Monitor                */


#define B1553_MSGBLK_1_CMD(msgPtr)      ((msgPtr) + 1u)     /* Ϣ */


#define B1553_MSGBLK_1_CTRLWD(msgPtr)   ((msgPtr) + 0u)     /* Ϣп */


#define B1553_MSGBLK_1_DATA(msgPtr)     ((msgPtr) + 2u)     /* Ϣ׵ַ */


#define B1553_MSGBLK_2_CMD(msgPtr)      ((msgPtr) + 1u)     /* Ϣ */


#define B1553_MSGBLK_2_CTRLWD(msgPtr)   ((msgPtr) + 0u)     /* Ϣп */


#define B1553_MSGBLK_2_DATA(msgPtr)     ((msgPtr) + 4u)     /* Ϣ׵ַ */


#define B1553_MSGBLK_2_LOOPBK(msgPtr)   ((msgPtr) + 2u)     /* Ϣлػ */


#define B1553_MSGBLK_2_STATUS(msgPtr)   ((msgPtr) + 3u)     /* Ϣ״̬ */


#define B1553_MSGBLK_3_CMD(msgPtr)      ((msgPtr) + 1u)     /* Ϣ */


#define B1553_MSGBLK_3_CTRLWD(msgPtr)   ((msgPtr) + 0u)     /* Ϣп */


#define B1553_MSGBLK_3_LOOPBK(msgPtr)   ((msgPtr) + 2u)     /* Ϣлػ */


#define B1553_MSGBLK_3_STATUS(msgPtr)   ((msgPtr) + 3u)     /* Ϣ״̬ */


#define B1553_MSGBLK_4_CMD(msgPtr)      ((msgPtr) + 1u)     /* Ϣ */


#define B1553_MSGBLK_4_CTRLWD(msgPtr)   ((msgPtr) + 0u)     /* Ϣп */


#define B1553_MSGBLK_4_DATA(msgPtr)     ((msgPtr) + 4u)     /* Ϣ */


#define B1553_MSGBLK_4_LOOPBK(msgPtr)   ((msgPtr) + 2u)     /* Ϣлػ */


#define B1553_MSGBLK_4_STATUS(msgPtr)   ((msgPtr) + 3u)     /* Ϣ״̬ */


#define B1553_MSGBLK_5_CMD(msgPtr)      ((msgPtr) + 1u)     /* Ϣ */


#define B1553_MSGBLK_5_CTRLWD(msgPtr)   ((msgPtr) + 0u)     /* Ϣп */


#define B1553_MSGBLK_5_DATA(msgPtr)     ((msgPtr) + 2u)     /* Ϣ */


#define B1553_MSGBLK_5_LOOPBK(msgPtr)   ((msgPtr) + 3u)     /* Ϣлػ */


#define B1553_MSGBLK_5_STATUS(msgPtr)   ((msgPtr) + 4u)     /* Ϣ״̬ */


#define B1553_MSGBLK_6_CMD(msgPtr)      ((msgPtr) + 1u)     /* Ϣ */


#define B1553_MSGBLK_6_CTRLWD(msgPtr)   ((msgPtr) + 0u)     /* Ϣп */


#define B1553_MSGBLK_6_DATA(msgPtr)     ((msgPtr) + 2u)     /* Ϣ׵ַ */


#define B1553_MSGBLK_7_CMD(msgPtr)      ((msgPtr) + 1u)     /* Ϣ */


#define B1553_MSGBLK_7_CTRLWD(msgPtr)   ((msgPtr) + 0u)     /* Ϣп */


#define B1553_MSGBLK_7_DATA(msgPtr)     ((msgPtr) + 2u)     /* Ϣ׵ַ */


#define B1553_MSGBLK_8_CMD(msgPtr)      ((msgPtr) + 1u)     /* Ϣ */


#define B1553_MSGBLK_8_CTRLWD(msgPtr)   ((msgPtr) + 0u)     /* Ϣп */


#define B1553_MSGBLK_8_LOOPBK(msgPtr)   ((msgPtr) + 2u)     /* Ϣлػ */


#define B1553_MSG_POLL_COUNT        5000u    /* Ϣѭж */


#define B1553_MSG_TRANS_TIME        800u    /* 1Mbps, Ϣʱ800us */


#define B1553_RAMA				(0x0)


#define B1553_RAMB				(0x1)


#define B1553_READ(offno, addrbase)         (((*(volatile unint32 *)(((offno) << 2u) + (addrbase)))) & 0xFFFFu)


#define B1553_REG_BASE                       0x0000     /* Ĵַ */


#define B1553_REG_BC_CTRW                    0x0004     /* BCּĴ */


#define B1553_REG_BC_FRM_TIME_REM            0x000B     /* BC֡ʱʣĴ(RD) */


#define B1553_REG_BC_FTIME                   0x000D     /* BC֡ʱĴ (RD/WR) */


#define B1553_REG_BC_TIME_REM_NMSG           0x000C     /* BCϢʱʣĴ(RD) */


#define B1553_REG_CMD_STACK_PTR              0x0003     /* ջָĴ(RD) */


#define B1553_REG_CONF1                      0x0001     /* üĴ#1 (RD/WR) */


#define B1553_REG_CONF2                      0x0002     /* üĴ#2 (RD/WR) */


#define B1553_REG_CONF3                      0x0007     /* üĴ#3(RD/WR) */


#define B1553_REG_CONF4                      0x0008     /* üĴ#4(RD/WR) */


#define B1553_REG_CONF5                      0x0009     /* üĴ#5(RD/WR) */


#define B1553_REG_INT_MASK                   0x0000     /* жμĴ(RD/WR) */


#define B1553_REG_INT_ST                     0x0006     /* ж״̬Ĵ(RD) */


#define B1553_REG_MT_DAT_STK_PTR             0x000A     /* MTݶջַĴ(RD/WR) */


#define B1553_REG_MT_TRIGGER_WORD            0x000D     /* MTּĴ (RD/WR) */


#define B1553_REG_RT_BITW                    0x000F     /* RTԲּĴ(RD) */


#define B1553_REG_RT_DAT_STK_PTR             0x000A     /* RTݶջַĴ(RD/WR) */


#define B1553_REG_RT_LAST_CMD                0x000D     /* RTһּĴ (RD/WR) */


#define B1553_REG_RT_SA_CTRW                 0x0004     /* RTӵַּĴ2(RD/WR) */


#define B1553_REG_RT_STW                     0x000E     /* RT״ּ̬Ĵ(RD) */


#define B1553_REG_START_RST                  0x0003     /* ʼ/λĴ(WR) */


#define B1553_REG_TIME_TAG                   0x0005     /* ʱǼĴ(RD/WR) */


#define B1553_RESP_TIMEOUT_1300         3u                  /* 130us */


#define B1553_RESP_TIMEOUT_185          0u                  /* 18.5us */


#define B1553_RESP_TIMEOUT_225          1u                  /* 22.5us */


#define B1553_RESP_TIMEOUT_505          2u                  /* 50.5us */


#define B1553_RT_BROAD              0x02    /* RT˹㲥ʽ */


#define B1553_RT_RECV               0x00    /* RT˽ */


#define B1553_RT_TRAN               0x01    /* RT˷ */


#define B1553_TIMETAG_02us              (0x5u)       /* 02us分辨率 */


#define B1553_TIMETAG_04us              (0x4u)       /* 04us分辨率 */


#define B1553_TIMETAG_08us              (0x3u)       /* 08us分辨率 */


#define B1553_TIMETAG_16us          0x2u    /* 16usֱ */


#define B1553_TIMETAG_32us          0x1u    /* 32usֱ */


#define B1553_TIMETAG_64us          0x0u    /* 64usֱ */


#define B1553_TWO_BITS_ERR_INT			(0x3<<9)	//b15531_twobits_err


#define B1553_WRITE(offno, val32, addrbase) ((*((volatile unint32 *)((((offno) << 2u) + (addrbase))))) = ((val32) & 0xFFFFu))


#define BC_BLKSTW_D00_INV_WORD          0x0001  /* 0(LSB) INVALID WORD           */


#define BC_BLKSTW_D01_INC_SYNC_TYPE     0x0002  /* 1 INCORRECT SYNC TYPE         */


#define BC_BLKSTW_D02_WORD_CNT_ERR      0x0004  /* 2 WORD COUNT ERROR            */


#define BC_BLKSTW_D03_WRONG_ST_ADDR     0x0008  /* 3 WRONG STATUS ADDRESS/NO GAP */


#define BC_BLKSTW_D04_GOOD_DATA_TRANS   0x0010  /* 4 GOOD DATA BLOCK TRANSFER    */


#define BC_BLKSTW_D05_RETRY_CNT0        0x0020  /* 5 RETRY COUNT 0               */


#define BC_BLKSTW_D06_RETRY_CNT1        0x0040  /* 6 RETRY COUNT 1               */


#define BC_BLKSTW_D07_MASKED_ST_SET     0x0080  /* 7 MASKED STATUS SET           */


#define BC_BLKSTW_D08_LOOP_FAIL         0x0100  /* 8 LOOP TEST FAIL              */


#define BC_BLKSTW_D09_NO_RESP           0x0200  /* 9 NO RESPONSE TIMEOUT         */


#define BC_BLKSTW_D10_FORMAT_ERROR      0x0400  /* 10 FORMAT ERROR               */


#define BC_BLKSTW_D11_ST_SET            0x0800  /* 11 STATUS SET                 */


#define BC_BLKSTW_D12_ERR_FLAG          0x1000  /* 12 ERROR FLAG                 */


#define BC_BLKSTW_D13_CHNEL_B1_A0       0x2000  /* 13 CHANNEL B/A*               */


#define BC_BLKSTW_D14_SOM               0x4000  /* 14 SOM                        */


#define BC_BLKSTW_D15_EOM               0x8000  /* 15(MSB) EOM                   */


#define BC_CONTROLL_WORD_REG            (0x0004u)    /* BC控制字寄存器 */


#define BC_CTW_D00_RT2RT_FORMAT         0x0001  /* 0(LSB) RT-TO-RT FORMAT            */


#define BC_CTW_D01_BRD_FORMAT           0x0002  /* 1 BROADCAST FORMAT                */


#define BC_CTW_D02_MODE_FORMAT          0x0004  /* 2 MODE CODE FORMAT                */


#define BC_CTW_D03_1553AB_SELE          0x0008  /* 3 1553A/B SELECT                  */


#define BC_CTW_D04_EOMINT_EN            0x0010  /* 4 EOM INTERRUPT ENABLE            */


#define BC_CTW_D05_BRDCAST_MASK         0x0020  /* 5 MASK BROADCAST BIT              */


#define BC_CTW_D06_OFF_TEST             0x0040  /* 6 OFF LINE SELF TEST              */


#define BC_CTW_D07_CHNL_AB              0x0080  /* 7 BUS CHANNEL A/B*                */


#define BC_CTW_D08_RETRY_EN             0x0100  /* 8 RETRY ENABLED                   */


#define BC_CTW_D09_REVDFLG_MASK         0x0200  /* 9 RESERVED BITS MASK              */


#define BC_CTW_D10_TERFLG_MASK          0x0400  /* 10 TERMINAL FLAG BIT MASK (S00)   */


#define BC_CTW_D11_SUBFLG_MASK          0x0800  /* 11 SUBSYS FLAG BIT MASK (S02)     */


#define BC_CTW_D12_SUBBUSY_MASK         0x1000  /* 12 SUBSYS BUSY BIT MASK (S03)     */


#define BC_CTW_D13_SERACQ_MASK          0x2000  /* 13 SERVICE REQUEST BIT MASK (S08) */


#define BC_CTW_D14_MSGERR_MASK          0x4000  /* 14 MESSAGE ERROR MASK (S10)       */


#define BC_CTW_D15_RESERVED             0x8000  /* 15(MSB) RESERVED                  */


#define BC_FRAME_TIME_REG               (0x000Du)    /* BC帧时间寄存器 (RD/WR) */


#define BC_FRAME_TIME_REMAINING_REG     (0x000Bu)    /* BC帧时间剩余寄存器(RD) */


#define BC_MEM_CMDSTACK_PTR_A           0x0100  /* BCջAָ */


#define BC_MEM_CMDSTACK_PTR_A_INI       0x0102  /* BCջAָ(Զطģʽ) */


#define BC_MEM_CMDSTACK_PTR_B           0x0104  /* BCջBָ */


#define BC_MEM_CMDSTACK_PTR_B_INI       0x0106  /* BCջBָ(Զطģʽ) */


#define BC_MEM_MSGCNT_PTR_A             0x0101  /* BCջAϢָ */


#define BC_MEM_MSGCNT_PTR_A_INI         0x0103  /* BCջAϢ(Զطģʽ) */


#define BC_MEM_MSGCNT_PTR_B             0x0105  /* BCջBϢָ */


#define BC_MEM_MSGCNT_PTR_B_INI         0x0107  /* BCջBϢ(Զطģʽ) */


#define BC_MESSAGE_TIME_REMAINING_REG   (0x000Cu)    /* BC消息时间剩余寄存器(RD) */


#define BC_STACK_MSG_MAX                64u		//ֲУϢ93


#define BE_BROADCAST						(0xffffffffffff)


#define BE_MAC_LABEL_HIGH					(0x2d)


#define BE_MAC_LABEL_LOW					(0x2c)				


#define BE_MAC_LABEL_reg_HIGH				(0x2d)


#define BE_MAC_LABEL_reg_LOW				(0x2c)


#define BE_RECV_RAM_START_ADDR				(0x69010000)


#define BE_SEND_RAM_START_ADDR				(0x68010000)


#define BE_SERVICE							(0x0)


#define BE_partition_allocated_num			(0x4A)


#define BE_partition_valid_num_reg			(0x36)


#define BE_recv_partition_base_addr			(0x3D)


#define BE_recv_rd_frame_done_reg			(0x39)


#define BE_recv_vl_length_reg				(0x4f)


#define BE_recv_vl_num_reg					(0x4e)


#define BE_recv_vl_partition_addr			(0x4f)


#define BE_send_length_reg					(0x35)


#define BE_send_partition_addr_reg			(0x36)


#define BE_send_partition_base_addr			(0x3B)


#define BE_send_wr_done_reg					(0x37)


#define BHDR_OVERHEAD	(0x10 - MIN_BLOCK_SIZE)	/* ͷС */


#define BIT_CLR(uv, bp, mask)           ((uv) = (uv) & ((0x01u << (bp)) ^ (mask)))


#define BIT_GET(uv, bp)                 (((uv) >> (bp)) & 0x01u)


#define BIT_NULL             (0u)         /* 无位操作 */


#define BIT_SET(uv, bp, mask)           ((uv) = (uv) | ((0x01u << (bp)) & (mask)))


#define BLOCK_ALIGN		(0x8)


#define BLOCK_SIZE		(0xFFFFFFFF - PTR_MASK)


#define BLOCK_STATE	(0x1)			/* D0:״̬ʶ */


#define BREAK_REV		0x8


#define BSPGPIDATR_INIT 			((GPI0_DATA << 0)|	\
															(GPI1_DATA << 1)|	\
															(GPI2_DATA << 2)|	\
															(GPI3_DATA << 3)|	\
															(GPI4_DATA << 4)|	\
															(GPI5_DATA << 5)|	\
															(GPI6_DATA << 6)|	\
															(GPI7_DATA << 7)|	\
															(GPI8_DATA << 8)|	\
															(GPI9_DATA << 9)|	\
															(GPI10_DATA << 10)| \
															(GPI11_DATA << 11)| \
															(GPI12_DATA << 12)| \
															(GPI13_DATA << 13)| \
															(GPI14_DATA << 14)| \
															(GPI15_DATA << 15))


#define BSPGPIDIRR_INIT 			((GPI0_CFG << 0)|	\
															(GPI1_CFG << 1)|	\
															(GPI2_CFG << 2)|	\
															(GPI3_CFG << 3)|	\
															(GPI4_CFG << 4)|	\
															(GPI5_CFG << 5)|	\
															(GPI6_CFG << 6)|	\
															(GPI7_CFG << 7)|	\
															(GPI8_CFG << 8)|	\
															(GPI9_CFG << 9)|	\
															(GPI10_CFG << 10)|	\
															(GPI11_CFG << 11)|	\
															(GPI12_CFG << 12)|	\
															(GPI13_CFG << 13)|	\
															(GPI14_CFG << 14)|	\
															(GPI15_CFG << 15))


#define BSPGPIINTCLR_INIT			(0xFFFF)			/*жĴڳʼʱжϹĴҪ޸ĸֵ*/


#define BSPGPIINTMKR_INIT			(~BSPGPIINT_EN_INIT)


#define BSPGPIINT_EN_INIT 			((GPI0_IntEn << 0)|	\
															(GPI1_IntEn << 1)|	\
															(GPI2_IntEn << 2)|	\
															(GPI3_IntEn << 3)|	\
															(GPI4_IntEn << 4)|	\
															(GPI5_IntEn << 5)|	\
															(GPI6_IntEn << 6)|	\
															(GPI7_IntEn << 7)|	\
															(GPI8_IntEn << 8)|	\
															(GPI9_IntEn << 9)|	\
															(GPI10_IntEn << 10)| \
															(GPI11_IntEn << 11)| \
															(GPI12_IntEn << 12)| \
															(GPI13_IntEn << 13)| \
															(GPI14_IntEn << 14)| \
															(GPI15_IntEn << 15))


#define BSPGPIINT_POLA_INIT 		((GPI0Int_TRIG_POLARITY << 0)|	\
												(GPI1Int_TRIG_POLARITY << 1)|	\
												(GPI2Int_TRIG_POLARITY << 2)|	\
												(GPI3Int_TRIG_POLARITY << 3)|	\
												(GPI4Int_TRIG_POLARITY << 4)|	\
												(GPI5Int_TRIG_POLARITY << 5)|	\
												(GPI6Int_TRIG_POLARITY << 6)|	\
												(GPI7Int_TRIG_POLARITY << 7)|	\
												(GPI8Int_TRIG_POLARITY << 8)|	\
												(GPI9Int_TRIG_POLARITY << 9)|	\
												(GPI10Int_TRIG_POLARITY << 10)| \
												(GPI11Int_TRIG_POLARITY << 11)| \
												(GPI12Int_TRIG_POLARITY << 12)| \
												(GPI13Int_TRIG_POLARITY << 13)| \
												(GPI14Int_TRIG_POLARITY << 14)| \
												(GPI15Int_TRIG_POLARITY << 15))


#define BSPGPIINT_TRIG_INIT 		((GPI0Int_TRIG_MODE << 0)|	\
													(GPI1Int_TRIG_MODE << 1)|	\
													(GPI2Int_TRIG_MODE << 2)|	\
													(GPI3Int_TRIG_MODE << 3)|	\
													(GPI4Int_TRIG_MODE << 4)|	\
													(GPI5Int_TRIG_MODE << 5)|	\
													(GPI6Int_TRIG_MODE << 6)|	\
													(GPI7Int_TRIG_MODE << 7)|	\
													(GPI8Int_TRIG_MODE << 8)|	\
													(GPI9Int_TRIG_MODE << 9)|	\
													(GPI10Int_TRIG_MODE << 10)| \
													(GPI11Int_TRIG_MODE << 11)| \
													(GPI12Int_TRIG_MODE << 12)| \
													(GPI13Int_TRIG_MODE << 13)| \
													(GPI14Int_TRIG_MODE << 14)| \
													(GPI15Int_TRIG_MODE << 15))


#define BSPGPIOPWIDTH_INIT			(0x0000)			/*ͬƽĴڳʼʱĬΪģʽ*/


#define BSPINTDEBOUNCE_INIT			(0x0000)			/*ʹܼĴڳʼʱĬϲʹ*/


#define BSPMODCTRL_INIT				(0x0000)			/*Port AԴĴڳʼʱĬΪģʽ*/


#define BSPRAMSIZE				(0x00200000)


#define BSPUART1BAUD			115200


#define BSPUART2BAUD			115200


#define BSP_1553B0_SEU_IRQID		(93)


#define BSP_1553B0_TWO_BITS_ERR_INT	(0x1<<9) //b15530_twobits_err


#define BSP_1553B1_SEU_IRQID		(94)


#define BSP_1553B1_TWO_BITS_ERR_INT	(0x1<<10) //b15531_twobits_err


#define BSP_1553B_ERR_CLEAR_REG	(0x40)	//RAM״̬


#define BSP_1553B_RAMA_ERR_REG	(0x40)	//RAM A˿ڳĵַ


#define BSP_1553B_RAMB_ERR_REG	(0x44)	//RAM B˿ڳĵַ


#define BSP_1553SIZE			(16*1024)  //@up by V1.03(0.0s)_0118


#define BSP_1553_0_IRQID			(32)		/* Irq id of 1553b 0*/


#define BSP_1553_0_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+2)


#define BSP_1553_1_IRQID			(33)		/* Irq id of 1553b 1*/


#define BSP_1553_1_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+3)


#define BSP_1553_A_SEU_ERR		(1)


#define BSP_1553_A_TBE_ERR		(1<<1)


#define BSP_1553_B_SEU_ERR		(1<<2)


#define BSP_1553_B_TBE_ERR		(1<<3)


#define BSP_ABC_VARIABLE_BIT			(0x3)


#define BSP_ABC_VARIABLE_GPIONO			(0x11)


#define BSP_AMBA_AHB_BASEADDR		(0xf00)							/*AHB״̬Ĵַ---BSP_MEC_BASE_ADDR*/


#define BSP_AMBA_MEMORY_BASEADDR	(0x0)							/*ڴƼĴַ-BSP_MEC_BASE_ADDR*/


#define BSP_AMBA_UART0_BASEADDR		(0xA0000000)					/*UART1ƼĴַ-BSP_MEC_BASE_ADDR*/


#define BSP_AMBA_UART1_BASEADDR		(0xA0000100)					/*UART2ƼĴַ-BSP_MEC_BASE_ADDR*/


#define BSP_AMBA_WDT_BASEADDR		(0x3FFF0600)					/*ŹʱĴַ-BSPMECBASE*/


#define BSP_APBTIMER_0_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+2)


#define BSP_APBTIMER_1_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+2)


#define BSP_APBTIMER_2_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+2)


#define BSP_APBTIMER_3_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+2)


#define BSP_APBTIMER_4_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+2)


#define BSP_APBTIMER_5_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+2)


#define BSP_APBTIMER_6_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+2)


#define BSP_APBTIMER_7_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+2)


#define BSP_APBTIMER_BASEADDR		(0xA00B0000)					/*ʱƼĴַ-BSP_MEC_BASE_ADDR*/


#define BSP_A_VALUE						(0x00)


#define BSP_All_POWER_ON				(1)	/*ӵ*/


#define BSP_BLOCK_SINGLE				(0x2)


#define BSP_BLOCK_TR32					(0x0)


#define BSP_BLOCK_TRAB					(0x1)


#define BSP_BLOCK_USERDEF				(0x3)


#define BSP_B_VALUE						(0x01)


#define BSP_CPU_INT_CNT				(160)


#define BSP_C_VALUE						(0x02)


#define BSP_ClearFTWDT_FLAG_BIT			((1<<9) | (1<<8))


#define BSP_ClearFTWDT_NO_VALUE			((0<<9) | (0<<8))


#define BSP_ClearFTWDT_YES_VALUE		((1<<9) | (1<<8))


#define BSP_DMA_SEU_IRQID			(79)		/*DMAжϺ*/


#define BSP_EDAC_CFGR				(BSP_AMBA_MEMORY_BASEADDR + 0x08)


#define BSP_EDGE_TRIGGER			(0x3)		/*ش*/


#define BSP_EMIF_DATA16						(0x1)


#define BSP_EMIF_DATA32						(0x3)


#define BSP_EMIF_DATA8						(0x0)


#define BSP_EMIF_DOUBLE_ERR_EN			(BSP_ENABLE)


#define BSP_EMIF_DOUBLE_ERR_INT		(100)


#define BSP_EMIF_INIT_FILL_SIZE				(BSP_EMIF_RAM_SIZE-BSP_EMIF_INIT_LOADER_FILLED_SIZE)


#define BSP_EMIF_INIT_FILL_StartAdd			(BSP_EMIF_RAM_BASE_ADDR+BSP_EMIF_INIT_LOADER_FILLED_SIZE)


#define BSP_EMIF_INIT_LOADER_FILLED_SIZE	(0x00000)


#define BSP_EMIF_IO_IOMEM_WS_H1			(0x8)


#define BSP_EMIF_IO_IOMEM_WS_H2			(0x8)


#define BSP_EMIF_IO_IOMEM_WS_S1			(0x8)


#define BSP_EMIF_IO_IOMEM_WS_S2			(0x8)


#define BSP_EMIF_IO_RDY_BUS_TIMEOUT_ERR_IRQID		(83)


#define BSP_EMIF_IO_Rdy_Timeout_reg		(0x61a8)


#define BSP_EMIF_IO_WS_CFG_REG 			( (BSP_EMIF_IO_IOMEM_WS_S1 << 24)|		\
											(BSP_EMIF_IO_IOMEM_WS_S2 << 16)|	\
											(BSP_EMIF_IO_IOMEM_WS_H2 << 8)|		\
												BSP_EMIF_IO_IOMEM_WS_H1)


#define BSP_EMIF_IO_config_reg			( (BSP_EMIF_IO_rdy << 10)|		\
											(BSP_EMIF_IO_wt << 8)|		\
												BSP_EMIF_IO_ws)


#define BSP_EMIF_IO_rdy					(0)


#define BSP_EMIF_IO_ws					(0x80)


#define BSP_EMIF_IO_wt					(BSP_EMIF_DATA32)


#define BSP_EMIF_RAMEDAC_EN				(BSP_ENABLE)


#define BSP_EMIF_RAM_16M					(0xb)


#define BSP_EMIF_RAM_1M						(0x7)


#define BSP_EMIF_RAM_2M						(0x8)


#define BSP_EMIF_RAM_32M					(0xc)


#define BSP_EMIF_RAM_4M						(0x9)


#define BSP_EMIF_RAM_512K					(0x0)


#define BSP_EMIF_RAM_64M					(0xf)


#define BSP_EMIF_RAM_8M						(0xa)


#define BSP_EMIF_RAM_BASE_ADDR			(0x10000000)								 /*the base address of off-chip ram */


#define BSP_EMIF_RAM_END_ADDR			(BSP_EMIF_RAM_BASE_ADDR + BSP_EMIF_RAM_SIZE) /*the end address of emif ram */


#define BSP_EMIF_RAM_SIZE				(8*1024*1024)


#define BSP_EMIF_RAM_WRMEM_BS			(BSP_EMIF_RAM_2M)


#define BSP_EMIF_RAM_WRMEM_CONFIG_REG  ( (BSP_EMIF_RAM_WRMEM_WT << 14)|			\
											(BSP_EMIF_RAM_WRMEM_RMW << 12)|		\
											(BSP_EMIF_RAM_WRMEM_BS << 8)|		\
												BSP_EMIF_RAM_WRMEM_WS)


#define BSP_EMIF_RAM_WRMEM_RMW			(BSP_ENABLE)


#define BSP_EMIF_RAM_WRMEM_WS			(0xA)


#define BSP_EMIF_RAM_WRMEM_WS_H1		(0x1)


#define BSP_EMIF_RAM_WRMEM_WS_H2		(0x0)


#define BSP_EMIF_RAM_WRMEM_WS_S1		(0x2)


#define BSP_EMIF_RAM_WRMEM_WS_S2		(0x2)


#define BSP_EMIF_RAM_WRMEM_WT			(BSP_EMIF_DATA32)


#define BSP_EMIF_RAM_WR_WRITE_BACK_EN	(BSP_DISABLE)


#define BSP_EMIF_RAM_WR_WS_CFG_REG		( (BSP_EMIF_RAM_WRMEM_WS_S1 << 24)|		\
										(BSP_EMIF_RAM_WRMEM_WS_S2 << 16)|		\
										(BSP_EMIF_RAM_WRMEM_WS_H2 << 8)|		\
												BSP_EMIF_RAM_WRMEM_WS_H1)


#define BSP_EMIF_REG_BASE_ADDR			(BSP_MEC_BASE_ADDR)					/*the start address of emif*/


#define BSP_EMIF_ROMEDAC_EN				(BSP_ENABLE)


#define BSP_EMIF_ROM_128K					(0x4)


#define BSP_EMIF_ROM_16K					(0x1)


#define BSP_EMIF_ROM_16M					(0xb)


#define BSP_EMIF_ROM_1M						(0x7)	


#define BSP_EMIF_ROM_256K					(0x5)


#define BSP_EMIF_ROM_2M						(0x8)


#define BSP_EMIF_ROM_32K					(0x2)


#define BSP_EMIF_ROM_32M					(0xc)


#define BSP_EMIF_ROM_4M						(0x9)


#define BSP_EMIF_ROM_512K					(0x6)


#define BSP_EMIF_ROM_64K					(0x3)


#define BSP_EMIF_ROM_64M					(0xf)


#define BSP_EMIF_ROM_8K						(0x0)


#define BSP_EMIF_ROM_8M						(0xa)


#define BSP_EMIF_ROM_ORMEM_BS			(BSP_EMIF_ROM_64M)


#define BSP_EMIF_ROM_ORMEM_RMW			(BSP_DISABLE)


#define BSP_EMIF_ROM_ORMEM_WEN			(BSP_ENABLE)


#define BSP_EMIF_ROM_ORMEM_WS			(0x28)


#define BSP_EMIF_ROM_ORMEM_WS_H1		(0x5)


#define BSP_EMIF_ROM_ORMEM_WS_H2		(0xB)  //@up by V1.03(0.0s)_0118


#define BSP_EMIF_ROM_ORMEM_WS_S1		(0x1)


#define BSP_EMIF_ROM_ORMEM_WS_S2		(0x1)


#define BSP_EMIF_ROM_ORMEM_WT			(BSP_EMIF_DATA8)


#define BSP_EMIF_ROM_ORMEM_config_reg  	( (BSP_EMIF_ROM_ORMEM_WEN<<16)|			\
										(BSP_EMIF_ROM_ORMEM_WT << 14)|			\
										(BSP_EMIF_ROM_ORMEM_RMW << 12)|			\
										(BSP_EMIF_ROM_ORMEM_BS << 8)|			\
										BSP_EMIF_ROM_ORMEM_WS)


#define BSP_EMIF_ROM_OR_WRITE_BACK_EN	(BSP_DISABLE)


#define BSP_EMIF_ROM_OR_WS_CFG_REG		( (BSP_EMIF_ROM_ORMEM_WS_S1 << 24)|		\
										(BSP_EMIF_ROM_ORMEM_WS_S2 << 16)|		\
										(BSP_EMIF_ROM_ORMEM_WS_H2 << 8)|		\
										BSP_EMIF_ROM_ORMEM_WS_H1)


#define BSP_EMIF_SEU_IRQID			(81)		/*EMIFжϺ*/


#define BSP_EMIF_WRITE_TO_FORBIDEN_AREA_ERR_IRQID	(82)


#define BSP_FORCE_A_WORK_ON				(0)	/*ǿA*/


#define BSP_FORCE_B_WORK_ON				(1)	/*ǿB*/


#define BSP_FORCE_C_WORK_ON				(2)	/*ǿC*/


#define BSP_FORCE_WORK_OFF				(3)	/*ǿƵ*/


#define BSP_GIC_BASE_ADDR				(0xF8F00000)						/*the start address of gic*/


#define BSP_GIC_ICC_BASEADDR		(BSP_INTR_GIC_BASE + 0x100)		/*GICеICCƼĴַ-BSP_MEC_BASE_ADDR*/


#define BSP_GIC_ICD_BASEADDR		(BSP_INTR_GIC_BASE + 0x1000) 	/*GICеICDƼĴַ-BSP_MEC_BASE_ADDR*/


#define BSP_GLOBAL_TIMER_BASEADDR	(BSP_INTR_GIC_BASE + 0x200)		/*жʱƼĴַ-BSP_PRIVATE_TIMER_BASEADDR*/


#define BSP_GPIO_0_IRQID			(34)		/* Irq id of GPIO 0*/


#define BSP_GPIO_10_IRQID			(44)		/* Irq id of GPIO 10*/


#define BSP_GPIO_11_IRQID			(45)		/* Irq id of GPIO 11*/


#define BSP_GPIO_12_IRQID			(46)		/* Irq id of GPIO 12*/


#define BSP_GPIO_13_IRQID			(47)		/* Irq id of GPIO 13*/


#define BSP_GPIO_14_IRQID			(48)		/* Irq id of GPIO 14*/


#define BSP_GPIO_15_IRQID			(49)		/* Irq id of GPIO 15*/


#define BSP_GPIO_1_IRQID			(35)		/* Irq id of GPIO 1*/


#define BSP_GPIO_2_IRQID			(36)		/* Irq id of GPIO 2*/


#define BSP_GPIO_3_IRQID			(37)		/* Irq id of GPIO 3*/


#define BSP_GPIO_4_IRQID			(38)		/* Irq id of GPIO 4*/


#define BSP_GPIO_4_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+7)


#define BSP_GPIO_5_IRQID			(39)		/* Irq id of GPIO 5*/


#define BSP_GPIO_5_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+6)


#define BSP_GPIO_6_IRQID			(40)		/* Irq id of GPIO 6*/


#define BSP_GPIO_6_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+5)


#define BSP_GPIO_7_IRQID			(41)		/* Irq id of GPIO 7*/


#define BSP_GPIO_7_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+4)


#define BSP_GPIO_8_IRQID			(42)		/* Irq id of GPIO 8*/


#define BSP_GPIO_9_IRQID			(43)		/* Irq id of GPIO 9*/


#define BSP_GPIO_BASE_ADDR				(0xA00D0000)						/*the start address of gpio*/


#define BSP_GPIO_HARD_MODE						(0x1)	/*GPIOΪӲģʽ*/


#define BSP_GPIO_IN								(0x0)	/*GPIOΪ*/


#define BSP_GPIO_OUT							(0x1)	/*GPIOΪ*/


#define BSP_GPIO_SOFT_MODE						(0x0)	/*GPIOΪģʽ*/


#define BSP_GPI_FALL_EDGE_TRIGER				(0x1)	/*GPIΪ½ش */


#define BSP_GPI_HIGH_LEVEL_TRIGER				(0x2)	/*GPIΪߵƽ */

#define BSP_GPI_LOW_LEVEL_TRIGER				(0x3)	/*GPIΪ͵ƽ */

#define BSP_GPI_RISE_EDGE_TRIGER				(0x0)	/*GPIΪش */

#define BSP_Get(addr)			(*(V_U32 *)((U32)(addr)))


#define BSP_HIGHEST_PRIORITY		(0)							/*ȼ-----------wait*/


#define BSP_HOTFT_POWER_OFF				(0)	/*ȱݴϵ*/


#define BSP_HOTFT_POWER_ON				(1)	/*ȱݴӵ*/


#define BSP_IDLE_VALUE					(0x1)


#define BSP_IIC0_IRQID				(69)		/* Irq id of IIC0*/


#define BSP_IIC1_IRQID				(68)		/* Irq id of IIC1*/


#define BSP_INTR_GIC_BASE			(0x3FFF0000)					/*GICַ*/


#define BSP_INTR_ICCABPR			(0x01c)							/* Aliased Non-secure Binary Point Register*/


#define BSP_INTR_ICCBPR				(0x008)							/* Binary Point Register*/


#define BSP_INTR_ICCEOIR			(0x010)							/* End Of Interrupt Register*/


#define BSP_INTR_ICCHPIR			(0x018)							/* Highest Pending Interrupt Register*/


#define BSP_INTR_ICCIAR				(0x00C)							/* Interrupt Acknowledge Register*/


#define BSP_INTR_ICCICR				(0x000)							/* CPU Interface Control Register*/


#define BSP_INTR_ICCIDR				(0x0fc)							/* CPU Interface Implementer Identification Register*/


#define BSP_INTR_ICCPMR				(0x004)							/* Interrupt Priority Mask Register*/


#define BSP_INTR_ICCRPR				(0x014)							/* Running Priority Register*/


#define BSP_INTR_ICDABR				(0x300)		/* Active Bit register*/


#define BSP_INTR_ICDDCR				(0x000)		/* Distributor Control Register*/


#define BSP_INTR_ICDICER			(0x180)		/* Interrupt Clear-Enable Register*/


#define BSP_INTR_ICDICFR			(0xc00)		/* Interrupt Configuration Register*/


#define BSP_INTR_ICDICPR			(0x280)		/* Interrupt Clear-Pending Register*/


#define BSP_INTR_ICDICTR			(0x004)		/* Interrupt Controller Type Register*/


#define BSP_INTR_ICDIIDR			(0x008)		/* Distributor Implementer Identification Register*/


#define BSP_INTR_ICDIPR				(0x400)		/* Interrupt Priority Register*/


#define BSP_INTR_ICDIPTR			(0x800)		/* Interrupt Processor Targets Register*/


#define BSP_INTR_ICDISER			(0x100)		/* Interrupt Set-enable Register*/


#define BSP_INTR_ICDISPR			(0x200)		/* Interrupt Set-pending Register*/


#define BSP_INTR_ICDISR				(0x080)		/* Interrupt Security Register*/


#define BSP_INTR_ICDSGIR			(0xf00)		/* Software Generated Interrupt Register*/


#define BSP_INT_USED_NUM			(0)


#define BSP_INVALID_MACHINE				(0xff)


#define BSP_INVALID_PRIORITY		(BSP_LOWEST_PRIORITY + 1)	/*ЧȼжõȼĻͲж*/


#define BSP_IOASIC_0_IRQID			(50)		/* Irq id of IOASIC 0*/


#define BSP_IOASIC_0_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+10)


#define BSP_IOASIC_1_IRQID			(51)		/* Irq id of IOASIC 1*/


#define BSP_IOASIC_1_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+9)


#define BSP_IOASIC_2_IRQID			(52)		/* Irq id of IOASIC 2*/


#define BSP_IOASIC_2_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+8)


#define BSP_IO_BASE_ADDR				(0x20000000)						/*the base address of I/O */


#define BSP_IO_END_ADDR					(0x28000000)						/*the end address of I/O */


#define BSP_JK_OUTPUT_BIT				(10)


#define BSP_JK_OUTPUT_NO_VALUE			(0)


#define BSP_JK_OUTPUT_YES_VALUE			(1)


#define BSP_LEVEL_TRIGGER			(0x1)		/*ƽ*/


#define BSP_LOWEST_PRIORITY			(30)						/*ȼ-----------wait*/


#define BSP_MACHINE_TYPE				(0x3)


#define BSP_MEC_BASE_ADDR				(0xA00A0000)						/*the base address of system registers */


#define BSP_MEC_END_ADDR				(0xF8F01FFC)						/*the base address of system registers */


#define BSP_MON_FLAG_BIT				(12)


#define BSP_MON_NO_VALUE				(0x1)


#define BSP_MON_YES_VALUE				(0x0)


#define BSP_ONLY_SELF_POWER_ON			(0)	/*ӵ*/


#define BSP_OTHER_POWER_ON				(2)	/*бӵбӵ*/


#define BSP_PM_WORK_FLAG_BIT			(0xE)


#define BSP_POWEROFF					(0x1)


#define BSP_POWERON						(0x0)


#define BSP_POWER_ON_BIT				(0x7)


#define BSP_POWER_ON_FLAG_BIT			(0x8)


#define BSP_POWER_ON_GPIONO				(0x9)


#define BSP_POWER_ON_RESET_FLAG_BIT		(0xD)


#define BSP_POWER_ON_VALUE				(0x1)


#define BSP_PRIVATE_TIMER_BASEADDR	(BSP_INTR_GIC_BASE + 0x600)		/*˽жʱƼĴַ-BSP_PRIVATE_TIMER_BASEADDR*/


#define BSP_Prog_SRAM_Flag				(0x3)


#define BSP_RAM_BASE_ADDR				(0x40000000)						/*the base address of ram */


#define BSP_RAM_END_ADDR				(BSP_RAM_BASE_ADDR + BSPRAMSIZE)	/*the end address of ram */


#define BSP_RESET						(0xeb90146f)


#define BSP_ROMCS0_BASE_ADDR			(0x00000000)						/*the base address of boot rom*/


#define BSP_ROMCS0_END_ADDR				(0x04000000)						/*the end address of boot rom*/


#define BSP_ROMCS1_BASE_ADDR			(0x04000000)						/*the base address of boot rom*/


#define BSP_ROMCS1_END_ADDR				(0x08000000)						/*the end address of boot rom*/


#define BSP_ROMCS2_BASE_ADDR			(0x08000000)						/*the base address of boot rom*/


#define BSP_ROMCS2_END_ADDR				(0x0C000000)						/*the end address of boot rom*/


#define BSP_ROMCS3_BASE_ADDR			(0x0C000000)						/*the base address of boot rom*/


#define BSP_ROMCS3_END_ADDR				(0x10000000)						/*the end address of boot rom*/


#define BSP_ROM_Storge3_BASE					(0)


#define BSP_ROM_Storge3_END						(0)


#define BSP_SDRAM_DATA_BASE_ADDR		(0xC0000000)						/*the start address of sdram data*/


#define BSP_SDRAM_DATA_END_ADDR			(BSP_SDRAM_DATA_BASE_ADDR+SDRAM_SIZE) /*the end address of sdram data*/


#define BSP_SDRAM_EDAC_CTL				( (SDRAM_EDAC_AHBERR_EN << 3)|			\
															SDRAM_EDAC_EN )


#define BSP_SDRAM_REG_BASE_ADDR			(0xB0000000)						/*the start address of sdram reg*/


#define BSP_SDRAM_SEU_IRQID			(92)


#define BSP_SLCR_BASEADDR			(0xF8000000)


#define BSP_SOFT_RESET_BIT				(11)


#define BSP_SOFT_RESET_NO_VALUE			(1)


#define BSP_SOFT_RESET_YES_VALUE		(0)


#define BSP_SOFT_TRAP				0x00


#define BSP_SPI_M1_IRQID			(63)		/* Irq id of SPI M1*/


#define BSP_SPW0_EMEM_RX_END			(0xFFFFFFFF)


#define BSP_SPW0_EMEM_RX_START			(0xFFFFFFFF)


#define BSP_SPW0_EMEM_TX_CNT			(0xFFFFFFFF)


#define BSP_SPW0_EMEM_TX_START			(0xFFFFFFFF)


#define BSP_SPW0_IRQID				(67)		/* Irq id of SPW0*/


#define BSP_SPW1_EMEM_RX_END			(0xFFFFFFFF)


#define BSP_SPW1_EMEM_RX_START			(0xFFFFFFFF)


#define BSP_SPW1_EMEM_TX_CNT			(0xFFFFFFFF)


#define BSP_SPW1_EMEM_TX_START			(0xFFFFFFFF)


#define BSP_SPW1_IRQID				(66)		/* Irq id of SPW1*/


#define BSP_SPW2_BULK_RX_END			(0xFFF)						//0xFFF040954096U32ַ


#define BSP_SPW2_BULK_RX_START			(0)


#define BSP_SPW2_BULK_TX_CNT			(32)//(0x4000)				//󳤶0x4000bytes


#define BSP_SPW2_BULK_TX_START			(0)


#define BSP_SPW2_IRQID				(65)		/* Irq id of SPW2*/


#define BSP_SPW2_RxSEU_IRQID		(89)


#define BSP_SPW2_TxSEU_IRQID		(88)


#define BSP_SPW3_BULK_RX_END			(0xFFF)						//0xFFF040954096U32ַ


#define BSP_SPW3_BULK_RX_START			(0)


#define BSP_SPW3_BULK_TX_CNT			(32)//(0x4000)				//󳤶0x4000bytes


#define BSP_SPW3_BULK_TX_START			(0)


#define BSP_SPW3_IRQID				(64)		/* Irq id of SPW3*/


#define BSP_SPW3_RxSEU_IRQID		(91)


#define BSP_SPW3_TxSEU_IRQID		(90)


#define BSP_SPWSIZE						(16*1024)


#define BSP_SPW_0_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+16)


#define BSP_SPW_1_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+15)


#define BSP_SPW_2_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+14)


#define BSP_SPW_3_IRQID_PRIORITY	(BSP_HIGHEST_PRIORITY+13)


#define BSP_SRAM_ADDR_ONE_BIT_COUNT				(0x18)	//Ĵ


#define BSP_SRAM_ADDR_ONE_BIT_REG				(0x10)	//ķ˫ֵַ


#define BSP_SRAM_ADDR_TWO_BIT_REG				(0x20)	//˫ķ˫ֵַ


#define BSP_SRAM_BYTE_ERR_REG					(0x40)	//˫ֽڱʶĴ


#define BSP_SRAM_DATA_TWO_BIT_REG				(0x58)	//˫Ķȡ


#define BSP_SRAM_EADC_READ_BYPASS_ADDR			(0x48)	//EDAC·õַĴ


#define BSP_SRAM_EADC_TWO_BIT_REG				(0x60)	//˫ĶȡУ


#define BSP_SRAM_EADC_WRITE_BYPASS_ADDR			(0x50)	//EDACд·õַĴ


#define BSP_SRAM_EDAC_BYPASS_DATAIN				(0x8)	//EDACBYPASSעݼĴ


#define BSP_SRAM_EDAC_READBYPASS_DATA_HIGH		(0x2c)	//EDAC·ݼĴ--20λУ


#define BSP_SRAM_EDAC_READBYPASS_DATA_LOW		(0x28)	//EDAC·ݼĴ--20λУ


#define BSP_SRAM_MEM_CONFIG						(0x0)	//ռüĴ


#define BSP_SRAM_ONE_BIT_CLEAR					(0x30)	//嵥жϼĴ


#define BSP_SRAM_SEU_IRQID			(80)		/*ƬSRAMжϺ*/


#define BSP_SRAM_TWO_BIT_CLEAR					(0x38)	//λжϼĴ


#define BSP_SYS_TRAP				(0x08)		/*ϵͳʹõ*/


#define BSP_Set(addr, value)	(*(V_U32 *)((U32)(addr)) = (value))


#define BSP_TIMER_0_IRQID			(29)		/* Irq id of Timer 0	(private timer)*/


#define BSP_TIMER_1_IRQID			(27)		/* Irq id of Timer 1	(global timer)*/


#define BSP_TIMER_2_IRQID			(53)		/* Irq id of Timer 2*/


#define BSP_TIMER_3_IRQID			(54)		/* Irq id of Timer 3*/


#define BSP_TIMER_4_IRQID			(55)		/* Irq id of Timer 4*/


#define BSP_TIMER_5_IRQID			(56)		/* Irq id of Timer 5*/


#define BSP_TIMER_6_IRQID			(57)		/* Irq id of Timer 6*/


#define BSP_TIMER_7_IRQID			(58)		/* Irq id of Timer 7*/


#define BSP_TIMER_8_IRQID			(59)		/* Irq id of Timer 8*/


#define BSP_TIMER_9_IRQID			(60)		/* Irq id of Timer 9*/


#define BSP_TRAP_DATA_ABORT				(0x4)


#define BSP_TRAP_FIQ_INTERRUPT			(0x7)


#define BSP_TRAP_IRQ_INTERRUPT			(0x5)


#define BSP_TRAP_NOTUSED_INTERRUPT		(0x6)


#define BSP_TRAP_PREFETCH_ABORT			(0x3)


#define BSP_TRAP_SOFTWARE_INTERRUPT		(0x2)


#define BSP_TRAP_UNDEFINED_ISTRUCTION	(0x1)


#define BSP_UART_0_IRQID			(61)		/* Irq id of Com 0*/


#define BSP_UART_1_IRQID			(62)		/* Irq id of Com 1*/


#define BSP_UART_FREQ			400000000


#define BSP_UART_IntEnR						(0x04)				/* жʹܼĴ*/


#define BSP_Used_Int_No0			(BSP_IOASIC_0_IRQID)


#define BSP_Used_Int_No1			(BSP_1553_0_IRQID)


#define BSP_Used_Int_No2			(BSP_1553_1_IRQID)


#define BSP_Used_Int_No3			(BSP_IOASIC_1_IRQID)


#define BSP_Used_Int_No4			(BSP_SPW0_IRQID)


#define BSP_Used_Int_No5			(BSP_SPW1_IRQID)


#define BSP_WDT_CONTROL_OFFSET_REG			(0x28)


#define BSP_WDT_COUNT_OFFSET_REG			(0x24)


#define BSP_WDT_FORBIDDEN_OFFSET_REG		(0x34)


#define BSP_WDT_INT_STATUS_OFFSET_REG		(0x2C)


#define BSP_WDT_IRQID				(30)		/* Irq id of WDT Timer*/


#define BSP_WDT_RELOAD_OFFSET_REG			(0x20)


#define BSP_WDT_RESET_STATUS_OFFSET_REG		(0x30)


#define BSP_WDT_TIMER_FREQ					(CPU_FREQ)


#define BSP_WORK_FLAG_GPIONO			(0xC)


#define BSP_WORK_VALUE					(0x0)


#define BSP_WORK_VARIABLE_BIT			(0x1)


#define BULK_NOT_SUPPORT					(0)


#define Bsp_Delay(tm)							(Bsp_TimerDelay((BSP_PreciseDelay_No),(tm)))


#define CA_ACCEPTANCE_WINDOW_reg			(0x09)


#define CA_OFFSET_reg						(0x07)


#define CA_ROUND_TRIP_reg					(0x0a)


#define CERR_ADDR_REG					(0x0030)		//ķֵַ


#define CERR_DATA_REG					(0x0034)		//ķ


#define CERR_EDAC_REG					(0x0038)		//ķEDAC


#define CHECK_MORE_TICK (2)  //Ϊرյʱ䣬


#define CHECK_MORE_US (2000)  //Ϊرյʱ䣬  Ŀǰ2ms 


#define CLOSE  0x55u                  /* ϵ */


#define CLR_BITS(addr, mask)				\
	{										\
		U32 temp_reg_val = BSP_Get((addr));	\
		temp_reg_val &= ~(mask);			\
		BSP_Set((addr), temp_reg_val);		\
	}


#define CLUSTER_CYCLE_DURATION	 		 	(0x10)


#define CMD_STACK_BOUND(ptr)            ((sRtStatus.stackBase) + (((ptr) - (sRtStatus.stackBase)) & ((sRtStatus.stackSize) - 0x4u)))


#define CMD_STACK_MSGNUM(ptrNew)    ((((ptrNew) + sRtStatus.stackSize - sRtStatus.stackPtrOld) % sRtStatus.stackSize) >> 2u)


#define COM1_DATABIT_Len		data_8_bit


#define COM1_FIFO_ENABLE		BSP_DISABLE


#define COM1_PARITY_SELECT		no_check


#define COM1_RFIFOINT_LEN		rcvr_1_int


#define COM1_RINT_ENABLE		BSP_DISABLE


#define COM1_STOPBIT_SELECT		stop_1_bit


#define COM1_TFIFOINT_LEN		tet_empty_int


#define COM1_TINT_ENABLE		BSP_DISABLE


#define COM2_DATABIT_Len		data_8_bit


#define COM2_FIFO_ENABLE		BSP_DISABLE


#define COM2_PARITY_SELECT		no_check


#define COM2_RFIFOINT_LEN		rcvr_1_int


#define COM2_RINT_ENABLE		BSP_DISABLE


#define COM2_STOPBIT_SELECT		stop_1_bit


#define COM2_TFIFOINT_LEN		tet_empty_int


#define COM2_TINT_ENABLE		BSP_DISABLE


#define COMMAND_STACK_POINTER_REG       (0x0003u)    /* 命令堆栈指针寄存器(RD) */


#define COMP_PARAMS_1				(0xf4)	//IPòĴ1


#define COMP_PARAMS_2				(0xf0)	//IPòĴ2


#define COMP_TYPE					(0xfc)	//IP


#define COMP_VERSION				(0xf8)	//IP汾


#define CONFIGURATION_1_REG             (0x0001u)    /* 配置寄存器#1 (RD/WR) */


#define CONFIGURATION_2_REG             (0x0002u)    /* 配置寄存器#2 (RD/WR) */


#define CONFIGURATION_3_REG             (0x0007u)    /* 配置寄存器#3(RD/WR) */


#define CONFIGURATION_4_REG             (0x0008u)    /* 配置寄存器#4(RD/WR) */


#define CONFIGURATION_5_REG             (0x0009u)    /* 配置寄存器#5(RD/WR) */


#define CONTROL_UART			1


#define CPU_FREQ				400


#define CPU_config_done_reg					(0x31)


#define CS_OFFSET_reg						(0x06)


#define CUBE(x)             ((x)*(x)*(x))         /*                      */


#define Ceilx(x)        (ceil((float64)(x))               )


#define Cosx(x)         (cos((float64)(x))                )


#define DATA_BLK_INV_NUM                20u


#define DATA_BLK_NUM                    16u


#define DATA_ERROR 0


#define DATA_MAXIMUM_LEN					(FRAME_MAXIMUM_LEN - FRAME_SYS_OCCUPY)		/*ܹ͵ֽڸ*/


#define DATA_MINIMUM_LEN					(FRAME_MINIMUM_LEN - FRAME_SYS_OCCUPY)		/*ܹ͵Сֽڸ*/


#define DATA_RD			0x1


#define DBL_TO_FLT_HI16_ID    (0x3Cu)          /* 将64位双精度浮点数转换为32位单精度浮点数 取高16位 */


#define DBL_TO_FLT_HI24_ID    (0x3Du)          /* 将64位双精度浮点数转换为32位单精度浮点数 取高16位 */


#define DBL_TO_FLT_ID         (0x3Au)          /* 将64位双精度浮点数转换为32位单精度浮点数 */


#define DBL_TO_SI07_ID        (0x38u)          /* 将64位双精度浮点数转换为7位有符号整型数 */


#define DBL_TO_SI08(x)              ( (unint08)( (siint32)(x) ) )    /* 将64位双精度浮点数转换为8位有符号整型数 */

#define DBL_TO_SI08_ID        (0x36u)          /* ((unint08)((siint32)((float32)(x))))将64位双精度浮点数转换为8位有符号整型数 */


#define DBL_TO_SI16(x)                  ((unint16)((siint32)((float32)(x))))


#define DBL_TO_SI16_ID        (0x35u)          /* ((unint16)((siint32)((float32)(x))))将64位双精度浮点数转换为16位有符号整型数 */


#define DBL_TO_SI24_ID        (0x37u)          /* 将64位双精度浮点数转换为3字节整型数补码 */


#define DBL_TO_SI32(x)                  ((unint32)((siint32)((float32)(x))))


#define DBL_TO_SI32_ID        (0x34u)          /* ((unint32)((siint32)((float32)(x))))将64位双精度浮点数转换为32位有符号整型数 */


#define DBL_TO_SI64(x)                  ((ulong64)((llong64)(x)))


#define DBL_TO_SI64_ID        (0x33u)          /* ((ulong64)((llong64)(x)))将64位双精度浮点数转换为64位有符号整型数 */


#define DBL_TO_UN08(x)                  ((unint08)(x))


#define DBL_TO_UN08_ID        (0x26u)          /* ((unint08)(x))将64位双精度浮点数转换为8位无符号整型数  */


#define DBL_TO_UN16(x)                  ((unint16)(x))


#define DBL_TO_UN16_ID        (0x25u)          /* ((unint16)(x))将64位双精度浮点数转换为16位无符号整型数 */


#define DBL_TO_UN24_ID        (0x27u)          /* 将64位双精度浮点数转换为3字节无符号整型数 */


#define DBL_TO_UN32(x)                  ((unint32)(x))


#define DBL_TO_UN32_ID        (0x24u)          /* ((unint32)(x))将64位双精度浮点数转换为32位无符号整型数 */


#define DBL_TO_UN64(x)                  ((ulong64)(x))


#define DBL_TO_UN64_ID        (0x23u)          /* ((ulong64)(x))将64位双精度浮点数转换为64位无符号整型数,会导致错误不能使用 */


#define DEFAULT_ADKB_All_Num				DRV_ADKB_All_Num


#define DEFAULT_DAKB_All_Num				DRV_DAKB_All_Num


#define DEFAULT_VALUE_AD_B					(0)


#define DEFAULT_VALUE_AD_K					(1000)


#define DEFAULT_VALUE_DA_B					(2047500)


#define DEFAULT_VALUE_DA_K					(204800)


#define DERR_ADDR_REG					(0x0040)		//˫ķֵַ


#define DERR_DATA_REG					(0x0044)		//˫ķ


#define DERR_EDAC_REG					(0x0048)		//˫ķEDAC


#define DONT_SAVE_OLD_CONTEXT		(0x02)		/*豣ɵ*/


#define DRV_AD_CDR_ADDR         0x10


#define DRV_AD_CDR_VALUE         0x0   //SPIʱźʱĴ


#define DRV_AD_CIRCLE_AGR_ADDR     0x1C 


#define DRV_AD_CPR_ADDR         0x4


#define DRV_AD_CPR_VALUE        0x1       //SPIʱλĴ


#define DRV_AD_ENSTART_ADDR     0x14


#define DRV_AD_FRE_ADDR         0x0


#define DRV_AD_NUM_LIMIT (4)


#define DRV_AD_READ_ADDR   0x200


#define DRV_AD_SDR_ADDR         0xc


#define DRV_AD_SDR_VALUE         0x0    //SPIѡͨźӳʱĴ


#define DRV_AD_SHR_ADDR         0x8


#define DRV_AD_SHR_VALUE         0x1     //SPIѡͨźųǰʱĴ


#define DRV_AD_SINGLENUM_ADDR   0x20


#define DRV_AD_SPI_ADDR   0x9000


#define DRV_AD_SPI_MODE (1)


#define DRV_AD_SSI_MODE (0)


#define DRV_AD_SSI_WIDTH   (200)//ͬģʽ£adɼ͵ȣ֤һش


#define DRV_AD_SUMNUM_ADDR      0x24


#define DRV_AD_SWITCH_TIME_ADDR 0x18


#define DRV_AD_WRIDATA_ADDR0   0x28


#define DRV_AD_WRIDATA_ADDR1   0x2c


#define DRV_BITIN_IO_PULSE_WidthAdd1 (200000)


#define DRV_BITIN_IO_PULSE_WidthAdd2 (200000)


#define DRV_BIT_DIR_ADDR            (0x00) //D(15:0)ӦGPIO(15:0)


#define DRV_BIT_FILWID_ADDR          (0x1c)  //˲GPIO(7:0)


#define DRV_BIT_FIL_0_ADDR          (0x14)  //D(1:0):GPIO(7:0)˲ѡD(3:2):GPIO(15:8)˲ѡԴ


#define DRV_BIT_FIL_1_ADDR          (0x18)  //D(1:0):GPIO(71:64)˲ѡD(3:2):GPIO(79:72)˲ѡ


#define DRV_BIT_IN_ADDR            (0x44) //λڲɼGPIO(15:0)


#define DRV_BIT_OUT_ADDR            (0x188) //λ״̬GPIO(15:0)


#define DRV_BIT_SELOUT_ADDR          (0x180) //D(15:0)ӦGPIO(63:48)


#define DRV_BUS_BUSRDY_ADDR(i)    (0x600+0x4*(i))


#define DRV_BUS_IO_ADDR    0x400


#define DRV_BUS_NCS0_ADDR(i)    (0x20000+0x4*(i))


#define DRV_BUS_NCS1_ADDR(i)    (0x28000+0x4*(i))


#define DRV_BUS_NCS2_ADDR(i)    (0x30000+0x4*(i))


#define DRV_BUS_NCS3_ADDR(i)    (0x38000+0x4*(i))


#define DRV_Bit_In_EQU0	(HUNDRED_US)


#define DRV_Bit_In_EQU1	(HUNDRED_US)


#define DRV_Bit_In_EQU10	(TEN_US )


#define DRV_Bit_In_EQU11	(TEN_US )


#define DRV_Bit_In_EQU12	(TEN_US )


#define DRV_Bit_In_EQU13	(TEN_US )


#define DRV_Bit_In_EQU14	(TEN_US )


#define DRV_Bit_In_EQU15	(TEN_US )


#define DRV_Bit_In_EQU16	(TEN_US )


#define DRV_Bit_In_EQU17	(TEN_US )


#define DRV_Bit_In_EQU18	(TEN_US )


#define DRV_Bit_In_EQU19	(TEN_US )


#define DRV_Bit_In_EQU2	(HUNDRED_US)


#define DRV_Bit_In_EQU20	(TEN_US )


#define DRV_Bit_In_EQU21	(TEN_US )


#define DRV_Bit_In_EQU22	(TEN_US )


#define DRV_Bit_In_EQU23	(TEN_US )


#define DRV_Bit_In_EQU24	(TEN_US )


#define DRV_Bit_In_EQU25	(TEN_US )


#define DRV_Bit_In_EQU26	(TEN_US )


#define DRV_Bit_In_EQU27	(TEN_US )


#define DRV_Bit_In_EQU28	(TEN_US )


#define DRV_Bit_In_EQU29	(TEN_US )


#define DRV_Bit_In_EQU3	(HUNDRED_US)


#define DRV_Bit_In_EQU30	(HUNDRED_US)


#define DRV_Bit_In_EQU31	(HUNDRED_US)


#define DRV_Bit_In_EQU32	(HUNDRED_US)


#define DRV_Bit_In_EQU33	(HUNDRED_US)


#define DRV_Bit_In_EQU34	(HUNDRED_US)


#define DRV_Bit_In_EQU35	(TEN_US )


#define DRV_Bit_In_EQU36	(TEN_US )


#define DRV_Bit_In_EQU37	(TEN_US )


#define DRV_Bit_In_EQU4	(HUNDRED_US)


#define DRV_Bit_In_EQU5	(HUNDRED_US)


#define DRV_Bit_In_EQU6	(HUNDRED_US)


#define DRV_Bit_In_EQU7	(HUNDRED_US)


#define DRV_Bit_In_EQU8	(HUNDRED_US)


#define DRV_Bit_In_EQU9	(HUNDRED_US)


#define DRV_Bit_In_Gather0	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather1	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather10	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather11	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather12	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather13	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather14	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather15	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather16	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather17	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather18	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather19	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather2	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather20	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather21	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather22	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather23	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather24	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather25	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather26	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather27	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather28	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather29	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather3	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather30	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather31	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather32	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather33	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather34	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather35	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather36	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather37	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather4	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather5	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather6	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather7	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather8	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_Gather9	(DRV_BITIN_IO_GPIO)


#define DRV_Bit_In_IoBase0	(DRV_IO_NUM0)


#define DRV_Bit_In_IoBase1	(DRV_IO_NUM0)


#define DRV_Bit_In_IoBase10	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase11	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase12	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase13	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase14	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase15	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase16	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase17	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase18	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase19	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase2	(DRV_IO_NUM0)


#define DRV_Bit_In_IoBase20	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase21	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase22	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase23	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase24	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase25	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase26	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase27	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase28	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase29	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase3	(DRV_IO_NUM0)


#define DRV_Bit_In_IoBase30	(DRV_IO_NUM0)


#define DRV_Bit_In_IoBase31	(DRV_IO_NUM0)


#define DRV_Bit_In_IoBase32	(DRV_IO_NUM0)


#define DRV_Bit_In_IoBase33	(DRV_IO_NUM0)


#define DRV_Bit_In_IoBase34	(DRV_IO_NUM0)


#define DRV_Bit_In_IoBase35	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase36	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase37	(DRV_IO_NUM1)


#define DRV_Bit_In_IoBase4	(DRV_IO_NUM0)


#define DRV_Bit_In_IoBase5	(DRV_IO_NUM0)


#define DRV_Bit_In_IoBase6	(DRV_IO_NUM0)


#define DRV_Bit_In_IoBase7	(DRV_IO_NUM0)


#define DRV_Bit_In_IoBase8	(DRV_IO_NUM0)


#define DRV_Bit_In_IoBase9	(DRV_IO_NUM0)


#define DRV_Bit_In_NumGpio0	(0)


#define DRV_Bit_In_NumGpio1	(1)


#define DRV_Bit_In_NumGpio10	(0)


#define DRV_Bit_In_NumGpio11	(1)


#define DRV_Bit_In_NumGpio12	(2)


#define DRV_Bit_In_NumGpio13	(3)


#define DRV_Bit_In_NumGpio14	(4)


#define DRV_Bit_In_NumGpio15	(5)


#define DRV_Bit_In_NumGpio16	(6)


#define DRV_Bit_In_NumGpio17	(7)


#define DRV_Bit_In_NumGpio18	(8)


#define DRV_Bit_In_NumGpio19	(9)


#define DRV_Bit_In_NumGpio2	(2)


#define DRV_Bit_In_NumGpio20	(10)


#define DRV_Bit_In_NumGpio21	(11)


#define DRV_Bit_In_NumGpio22	(12)


#define DRV_Bit_In_NumGpio23	(13)


#define DRV_Bit_In_NumGpio24	(14)


#define DRV_Bit_In_NumGpio25	(15)


#define DRV_Bit_In_NumGpio26	(19)


#define DRV_Bit_In_NumGpio27	(20)


#define DRV_Bit_In_NumGpio28	(21)


#define DRV_Bit_In_NumGpio29	(22)


#define DRV_Bit_In_NumGpio3	(3)


#define DRV_Bit_In_NumGpio30	(10)


#define DRV_Bit_In_NumGpio31	(11)


#define DRV_Bit_In_NumGpio32	(12)


#define DRV_Bit_In_NumGpio33	(13)


#define DRV_Bit_In_NumGpio34	(15)


#define DRV_Bit_In_NumGpio35	(17)


#define DRV_Bit_In_NumGpio36	(18)


#define DRV_Bit_In_NumGpio37	(23)


#define DRV_Bit_In_NumGpio4	(4)


#define DRV_Bit_In_NumGpio5	(5)


#define DRV_Bit_In_NumGpio6	(6)


#define DRV_Bit_In_NumGpio7	(7)


#define DRV_Bit_In_NumGpio8	(8)


#define DRV_Bit_In_NumGpio9	(9)


#define DRV_Bit_In_Rev0	(DRVUNREV)


#define DRV_Bit_In_Rev1	(DRVUNREV)


#define DRV_Bit_In_Rev10	(DRVUNREV)


#define DRV_Bit_In_Rev11	(DRVUNREV)


#define DRV_Bit_In_Rev12	(DRVUNREV)


#define DRV_Bit_In_Rev13	(DRVUNREV)


#define DRV_Bit_In_Rev14	(DRVUNREV)


#define DRV_Bit_In_Rev15	(DRVUNREV)


#define DRV_Bit_In_Rev16	(DRVUNREV)


#define DRV_Bit_In_Rev17	(DRVUNREV)


#define DRV_Bit_In_Rev18	(DRVUNREV)


#define DRV_Bit_In_Rev19	(DRVUNREV)


#define DRV_Bit_In_Rev2	(DRVUNREV)


#define DRV_Bit_In_Rev20	(DRVUNREV)


#define DRV_Bit_In_Rev21	(DRVUNREV)


#define DRV_Bit_In_Rev22	(DRVUNREV)


#define DRV_Bit_In_Rev23	(DRVUNREV)


#define DRV_Bit_In_Rev24	(DRVUNREV)


#define DRV_Bit_In_Rev25	(DRVUNREV)


#define DRV_Bit_In_Rev26	(DRVUNREV)


#define DRV_Bit_In_Rev27	(DRVUNREV)


#define DRV_Bit_In_Rev28	(DRVUNREV)


#define DRV_Bit_In_Rev29	(DRVUNREV)


#define DRV_Bit_In_Rev3	(DRVUNREV)


#define DRV_Bit_In_Rev30	(DRVUNREV)


#define DRV_Bit_In_Rev31	(DRVUNREV)


#define DRV_Bit_In_Rev32	(DRVUNREV)


#define DRV_Bit_In_Rev33	(DRVUNREV)


#define DRV_Bit_In_Rev34	(DRVUNREV)


#define DRV_Bit_In_Rev35	(DRVUNREV)


#define DRV_Bit_In_Rev36	(DRVUNREV)


#define DRV_Bit_In_Rev37	(DRVUNREV)


#define DRV_Bit_In_Rev4	(DRVUNREV)


#define DRV_Bit_In_Rev5	(DRVUNREV)


#define DRV_Bit_In_Rev6	(DRVUNREV)


#define DRV_Bit_In_Rev7	(DRVUNREV)


#define DRV_Bit_In_Rev8	(DRVUNREV)


#define DRV_Bit_In_Rev9	(DRVUNREV)


#define DRV_Bit_In_Width0	(6000)


#define DRV_Bit_In_Width1	(6000)


#define DRV_Bit_In_Width10	(100)


#define DRV_Bit_In_Width11	(100)


#define DRV_Bit_In_Width12	(100)


#define DRV_Bit_In_Width13	(100)


#define DRV_Bit_In_Width14	(100)


#define DRV_Bit_In_Width15	(100)


#define DRV_Bit_In_Width16	(100)


#define DRV_Bit_In_Width17	(100)


#define DRV_Bit_In_Width18	(100)


#define DRV_Bit_In_Width19	(100)


#define DRV_Bit_In_Width2	(6000)


#define DRV_Bit_In_Width20	(100)


#define DRV_Bit_In_Width21	(100)


#define DRV_Bit_In_Width22	(100)


#define DRV_Bit_In_Width23	(100)


#define DRV_Bit_In_Width24	(100)


#define DRV_Bit_In_Width25	(100)


#define DRV_Bit_In_Width26	(100)


#define DRV_Bit_In_Width27	(100)


#define DRV_Bit_In_Width28	(100)


#define DRV_Bit_In_Width29	(100)


#define DRV_Bit_In_Width3	(6000)


#define DRV_Bit_In_Width30	(6000)


#define DRV_Bit_In_Width31	(6000)


#define DRV_Bit_In_Width32	(6000)


#define DRV_Bit_In_Width33	(6000)


#define DRV_Bit_In_Width34	(6000)


#define DRV_Bit_In_Width35	(100)


#define DRV_Bit_In_Width36	(100)


#define DRV_Bit_In_Width37	(100)


#define DRV_Bit_In_Width4	(6000)


#define DRV_Bit_In_Width5	(6000)


#define DRV_Bit_In_Width6	(6000)


#define DRV_Bit_In_Width7	(6000)


#define DRV_Bit_In_Width8	(6000)


#define DRV_Bit_In_Width9	(6000)


#define DRV_Bit_Out_Gather0	(DRV_BITOUT_IO_GPIO)


#define DRV_Bit_Out_Gather1	(DRV_BITOUT_IO_GPIO)


#define DRV_Bit_Out_Gather2	(DRV_BITOUT_IO_GPIO)


#define DRV_Bit_Out_Gather3	(DRV_BITOUT_IO_GPIO)


#define DRV_Bit_Out_Gather4	(DRV_BITOUT_IO_GPIO)


#define DRV_Bit_Out_Gather5	(DRV_BITOUT_IO_GPIO)


#define DRV_Bit_Out_Gather6	(DRV_BITOUT_IO_GPIO)


#define DRV_Bit_Out_Gather7	(DRV_BITOUT_IO_GPIO)


#define DRV_Bit_Out_Gather8	(DRV_BITOUT_IO_GPIO)


#define DRV_Bit_Out_Init0	(DRVLOW)


#define DRV_Bit_Out_Init1	(DRVLOW)


#define DRV_Bit_Out_Init2	(DRVLOW)


#define DRV_Bit_Out_Init3	(DRVLOW)


#define DRV_Bit_Out_Init4	(DRVHIGH)


#define DRV_Bit_Out_Init5	(DRVHIGH)


#define DRV_Bit_Out_Init6	(DRVHIGH)


#define DRV_Bit_Out_Init7	(DRVHIGH)


#define DRV_Bit_Out_Init8	(DRVHIGH)


#define DRV_Bit_Out_IoBase0	(DRV_IO_NUM0)


#define DRV_Bit_Out_IoBase1	(DRV_IO_NUM0)


#define DRV_Bit_Out_IoBase2	(DRV_IO_NUM0)


#define DRV_Bit_Out_IoBase3	(DRV_IO_NUM0)


#define DRV_Bit_Out_IoBase4	(DRV_IO_NUM1)


#define DRV_Bit_Out_IoBase5	(DRV_IO_NUM1)


#define DRV_Bit_Out_IoBase6	(DRV_IO_NUM1)


#define DRV_Bit_Out_IoBase7	(DRV_IO_NUM1)


#define DRV_Bit_Out_IoBase8	(DRV_IO_NUM1)


#define DRV_Bit_Out_NumGpio0	(14)


#define DRV_Bit_Out_NumGpio1	(16)


#define DRV_Bit_Out_NumGpio2	(17)


#define DRV_Bit_Out_NumGpio3	(18)


#define DRV_Bit_Out_NumGpio4	(40)


#define DRV_Bit_Out_NumGpio5	(41)


#define DRV_Bit_Out_NumGpio6	(42)


#define DRV_Bit_Out_NumGpio7	(43)


#define DRV_Bit_Out_NumGpio8	(44)


#define DRV_Bit_Out_Rev0	(DRVUNREV)


#define DRV_Bit_Out_Rev1	(DRVUNREV)


#define DRV_Bit_Out_Rev2	(DRVUNREV)


#define DRV_Bit_Out_Rev3	(DRVUNREV)


#define DRV_Bit_Out_Rev4	(DRVUNREV)


#define DRV_Bit_Out_Rev5	(DRVUNREV)


#define DRV_Bit_Out_Rev6	(DRVUNREV)


#define DRV_Bit_Out_Rev7	(DRVUNREV)


#define DRV_Bit_Out_Rev8	(DRVUNREV)


#define DRV_CAN1A           (0)


#define DRV_CAN1B           (1)


#define DRV_CAN1_BASEADDRA               (0x1400) 


#define DRV_CAN1_BASEADDRB               (0x1800) 


#define DRV_CAN1_BASE_ADDR                (0x1C00) 


#define DRV_CAN2A           (2)


#define DRV_CAN2B           (3)


#define DRV_CAN2_BASEADDRA               (0x4000) 


#define DRV_CAN2_BASEADDRB               (0x4400) 


#define DRV_CAN2_BASE_ADDR                (0x4800) 


#define DRV_CAN_RESET_TIME   (10)


#define DRV_CONTROL_CLOCK (DRVUSED)  


#define DRV_COUNT_NUM_LIMIT (18)


#define DRV_CSB_BAUD   (0xC)


#define DRV_CSB_CTRL   (0x0)


#define DRV_CSB_DATA   (0x4)


#define DRV_CSB_IOBASEA   (0x9400)


#define DRV_CSB_IOBASEB   (0x9600)


#define DRV_CSB_REV_FAIL    (0x3)//ֽһ(4ֽ)


#define DRV_CSB_REV_NULL    (0x1)   //ͲЧ


#define DRV_CSB_SEND_FAIL   (0x3)//fifoʣֽСҪ͵ֽ


#define DRV_CSB_SEND_NULL    (0x1)   //ͲЧ


#define DRV_CSB_TMFIFO   (0x8)


#define DRV_Count_EQU0	(TEN_US )


#define DRV_Count_Edge0	(DRV_COUNT_HIGH_MODE)


#define DRV_Count_Filter0	(100)


#define DRV_Count_IoBase0	(DRV_IO_NUM1)


#define DRV_Count_Mode0	(1)


#define DRV_Count_NumGpio0	(16)


#define DRV_DA_9726Clock_KB_MODE (5)


#define DRV_DA_9726_CHIP_RESET_TIME (100)


#define DRV_DA_9726_PULSE_OVER_TIME (2000)


#define DRV_DA_9726_RESET_OVER_TIME (15000)


#define DRV_DA_9762KB_MODE (4)


#define DRV_DA_9762_MODE (3)


#define DRV_DA_BUS_MODE (2)


#define DRV_DA_GPIO_MODE (1)


#define DRV_DA_LSCS_DELAY_TIME    1        //λusDAʱLSCS֮ʱʱ䣬ҪСΪ80ns


#define DRV_DA_SSI_DELAY_TIME (1)


#define DRV_DA_SSI_MODE (0)


#define DRV_Def_AD_SPI_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_AD_SSI_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_BIT_IN_Num	(38)	 //·


#define DRV_Def_BIT_IN_Type	(DRVUSED)	 //ʹø÷ʽ


#define DRV_Def_BIT_OUT_Num	(9)	 //·


#define DRV_Def_BIT_OUT_Type	(DRVUSED)	 //ʹø÷ʽ


#define DRV_Def_BUS_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_CAN_INT_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_CAN_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_CSB_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_Count_Num	(1)	 //·


#define DRV_Def_Count_Type	(DRVUSED)	 //ʹø÷ʽ


#define DRV_Def_DA_9726_CLOCK_KB_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_DA_9762KB_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_DA_9762_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_DA_BUS_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_DA_GPIO_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_DA_RESET_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_DA_SSI_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_Eight_FRE_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_Eight_INT_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_INT_GPI_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_IO_Num	(2)	 //·


#define DRV_Def_IO_Type	(DRVUSED)	 //ʹø÷ʽ


#define DRV_Def_Latch_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_PULSE_OUT_Num	(38)	 //·


#define DRV_Def_PULSE_OUT_Type	(DRVUSED)	 //ʹø÷ʽ


#define DRV_Def_Power_Mode1_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_Power_Mode2_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_Power_Mode3_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_Power_Mode4_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_SPI_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_SSI_IN_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_SSI_OUT_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_Syn_Source_Num	(2)	 //·


#define DRV_Def_Syn_Source_Type	(DRVUSED)	 //ʹø÷ʽ


#define DRV_Def_TM_INT_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_TM_Type	(DRVUNUSED)	 //ʹø÷ʽ


#define DRV_Def_Time_Num	(6)	 //·


#define DRV_Def_Time_Type	(DRVUSED)	 //ʹø÷ʽ


#define DRV_Def_UART_Num	(23)	 //·


#define DRV_Def_UART_Type	(DRVUSED)	 //ʹø÷ʽ


#define DRV_EIGHT_FRE_CLEARDOG_ADDR         (0x3DC)//ƵʲɼŹʱĴ


#define DRV_EIGHT_FRE_COUNT_ADDR(i)         (0x3A0+0x4*(i))//ƵʲɼĴ


#define DRV_EIGHT_FRE_DATA_ADDR(i)          (0x380+0x4*(i))//ƵʲɼĴ


#define DRV_EIGHT_FRE_DELAY_ADDR            (0x3C4)//ƵʲɼʱĴ


#define DRV_EIGHT_FRE_EQU_ADDR                   (0x3CC)//ƵʲɼĴ


#define DRV_EIGHT_FRE_FIL_EQU_ADDR           (0x3D0)//Ƶʲɼ˲Ĵ


#define DRV_EIGHT_FRE_FIL_WIDTH_ADDR         (0x3D4)//Ƶʲɼ˲ȼĴ


#define DRV_EIGHT_FRE_PERIOD_ADDR           (0x3C0)//ƵʲɼڼĴ


#define DRV_EIGHT_FRE_RANGE_ADDR            (0x3C8)//ƵʲɼĴ


#define DRV_EIGHT_FRE_START_ADDR                 (0x3D8)//ƵʲɼĴ


#define DRV_ERR_AD                            (0xF << 8)


#define DRV_ERR_AD_PASS_PARAMETER_NO                              (DRV_ERR_AD  | 0x1)/* ADNO */


#define DRV_ERR_AD_STRUCT_MEMBER_MODE                          (DRV_ERR_AD  | 0x2) /*ADṹ(ɼʽ)֧ͬںͶͨSPIģʽ */


#define DRV_ERR_BIT_IN                   (0x1 << 8)


#define DRV_ERR_BIT_IN_PASS_PARAMETER_NO                    (DRV_ERR_BIT_IN |  0x1) /* λ봫NO */


#define DRV_ERR_BIT_IN_STRUCT_MEMBER_GATHER             (DRV_ERR_BIT_IN  | 0x2) /*λ ṹ(ЧԱ־) */


#define DRV_ERR_BIT_OUT                (0x2 << 8)


#define DRV_ERR_BIT_OUT_PASS_PARAMETER_NO                 (DRV_ERR_BIT_OUT |  0x1) /* λNO */


#define DRV_ERR_BIT_OUT_PASS_PARAMETER_VALUE             (DRV_ERR_BIT_OUT |  0x2) /* λvalue */


#define DRV_ERR_BUS                            (0x12<< 8)


#define DRV_ERR_BUS_PASS_PARAMETER_ADDR                        (DRV_ERR_BUS  | 0x1)/* BUSADDR */


#define DRV_ERR_CAN                       (0x4 << 8)


#define DRV_ERR_CAN_PASS_PARAMETER_BAUD                     (DRV_ERR_CAN |  0x2) /* CANBAUD */


#define DRV_ERR_CAN_PASS_PARAMETER_NO                       (DRV_ERR_CAN |  0x1) /* CANNO */


#define DRV_ERR_COUNT                      (0xB << 8)


#define DRV_ERR_COUNT_PASS_PARAMETER_NO                    (DRV_ERR_COUNT |  0x1) /* NO */


#define DRV_ERR_CSB                        (0x8 << 8)


#define DRV_ERR_CSB_PASS_PARAMETER_NO                         (DRV_ERR_CSB |  0x1) /* CSBNO */


#define DRV_ERR_DA                            (0x10<< 8)


#define DRV_ERR_DA_DEFINE_MODE                                           (DRV_ERR_DA  | 0x2)/* DAdefine MODE */


#define DRV_ERR_DA_PASS_PARAMETER_NO                              (DRV_ERR_DA  | 0x1)/* DANO */


#define DRV_ERR_EIGHT                           (0x14 << 8)


#define DRV_ERR_EIGHT_PASS_PARAMETER_NO                       (DRV_ERR_EIGHT |  0x1) /*ͨģ鴫NO */


#define DRV_ERR_EQU                            (0x15 << 8)             


#define DRV_ERR_EQU_PASS_PARAMETER_ADDR                        (DRV_ERR_EQU  | 0x1)/* ˲嵱ת */


#define DRV_ERR_INT                            (0x11<< 8)


#define DRV_ERR_INT_PASS_PARAMETER_ASICNO                         (DRV_ERR_INT  | 0x2)/* INTINTNO */


#define DRV_ERR_INT_PASS_PARAMETER_INTNO                         (DRV_ERR_INT  | 0x1)/* INTINTNO */


#define DRV_ERR_INT_PASS_PARAMETER_MODE                         (DRV_ERR_INT  | 0x3)/* INTINTNO */


#define DRV_ERR_INT_PASS_PARAMETER_NO                         (DRV_ERR_INT  | 0x4)/* INT NO */


#define DRV_ERR_IO                           (0x16 << 8)             


#define DRV_ERR_IO_PASS_PARAMETER_ADDR                        (DRV_ERR_IO  | 0x1)     /*IOŴ */


#define DRV_ERR_LATCH                      (0xC << 8)


#define DRV_ERR_LATCH_PASS_PARAMETER_NO                    (DRV_ERR_LATCH |  0x1) /* 洫NO */


#define DRV_ERR_POWER                   (0x5 << 8)


#define DRV_ERR_POWER_PASS_PARAMETER_ACTION              (DRV_ERR_POWER |  0x2) /* ģ鴫action */


#define DRV_ERR_POWER_PASS_PARAMETER_NO                    (DRV_ERR_POWER |  0x1) /* ģ鴫NO */


#define DRV_ERR_PULSE                     (0xA << 8)


#define DRV_ERR_PULSE_PASS_PARAMETER_DEFEND                    (DRV_ERR_PULSE |  0x2) /* ɱģ鴫δ */


#define DRV_ERR_PULSE_PASS_PARAMETER_NO                    (DRV_ERR_PULSE |  0x1) /* ɱNO */


#define DRV_ERR_PULSE_PERIOD_WIDTH                     (0x13 << 8) // add by lcl


#define DRV_ERR_SET_ERRNO(errno)         (DRVErrNo = (errno))


#define DRV_ERR_SPI                          (0xD << 8)


#define DRV_ERR_SPI_PASS_PARAMETER_INTRECV                    (DRV_ERR_SPI |  0x2) /* SPIδ */


#define DRV_ERR_SPI_PASS_PARAMETER_NO                    (DRV_ERR_SPI |  0x1) /* SPINO */


#define DRV_ERR_SSI                           (0xE << 8)


#define DRV_ERR_SSI_PASS_PARAMETER_INTRECV                    (DRV_ERR_SSI |  0x3) /* SSIδ */


#define DRV_ERR_SSI_PASS_PARAMETER_MODE                    (DRV_ERR_SSI |  0x2) /* SSINO */


#define DRV_ERR_SSI_PASS_PARAMETER_NO                    (DRV_ERR_SSI |  0x1) /* SSINO */


#define DRV_ERR_SYN_SOURCE          (0x3 << 8)


#define DRV_ERR_SYN_SOURCE_PASS_PARAMETER_NO            (DRV_ERR_SYN_SOURCE |  0x1) /* ͬźŴNO */


#define DRV_ERR_SYN_SOURCE_PASS_PARAMETER_PERIOD    (DRV_ERR_SYN_SOURCE |  0x2) /* ͬźŴperiod */


#define DRV_ERR_SYN_SOURCE_PASS_PARAMETER_PHASE    (DRV_ERR_SYN_SOURCE |  0x4) /* ͬźŴphase */


#define DRV_ERR_SYN_SOURCE_PASS_PARAMETER_SELECT    (DRV_ERR_SYN_SOURCE |  0x3) /* ͬźŴselect */


#define DRV_ERR_SYN_SOURCE_PASS_PARAMETER_WIDTH    (DRV_ERR_SYN_SOURCE |  0x5) /* ͬźŴwidth */


#define DRV_ERR_TIME                      (0x6 << 8)


#define DRV_ERR_TIME_PASS_PARAMETER_GPS                      (DRV_ERR_TIME |  0x3) /* ʱģ鴫NO */


#define DRV_ERR_TIME_PASS_PARAMETER_NO                       (DRV_ERR_TIME |  0x1) /* ʱģ鴫NO */


#define DRV_ERR_TIME_PASS_PARAMETER_TIME                     (DRV_ERR_TIME |  0x2) /* ʱģ鴫οʱ */


#define DRV_ERR_TM                          (0x9 << 8)


#define DRV_ERR_TM_PASS_PARAMETER_BAUD                        (DRV_ERR_TM |  0x2) /* TMBAUD */


#define DRV_ERR_TM_PASS_PARAMETER_NO                             (DRV_ERR_TM |  0x1) /*TMNO */


#define DRV_ERR_UART                      (0x7 << 8)


#define DRV_ERR_UART_PASS_PARAMETER_NO                        (DRV_ERR_UART |  0x1) /* UARTNO */


#define DRV_GPS0_FLAG_TIME_ADDR            (0x1104) //GPS0


#define DRV_GPS1_FLAG_TIME_ADDR            (0x1108) //GPS1


#define DRV_GPS2_FLAG_TIME_ADDR           (0x110c) //GPS2


#define DRV_GPS3_FLAG_TIME_ADDR            (0x1110) //GPS3


#define DRV_INT_ASIC0         (0)


#define DRV_INT_ASIC1         (1)


#define DRV_INT_ASIC2         (2)


#define DRV_INT_DISABLE       (0x91D0200A)


#define DRV_INT_ENABLE         (0xEB90146F)


#define DRV_INT_ENABLE_ADDR           (0xC40) //жʹܼĴ


#define DRV_INT_MODE_ADDR            (0xD80) //жģʽĴ


#define DRV_INT_SEL_ADDR(i)              (0xD40+0xC*(i)) //жѡĴ


#define DRV_INT_SSI_RECV_ADDR              (0xCC0) //ͬжϽոĴ


#define DRV_INT_STATE_ADDR               (0xC00) //ж״̬Ĵ


#define DRV_INT_TM_SEND_ADDR              (0xD00) //TMң⴮жʣ෢͸Ĵ


#define DRV_INT_UART_RECV_ADDR           (0xC80) //첽жϽոĴ


#define DRV_IO_BASE0	(0x50000000)


#define DRV_IO_BASE1	(0x20000000)


#define DRV_IO_FRE0	(DRV_CLK_100M)


#define DRV_IO_FRE1	(DRV_CLK_20M)


#define DRV_IO_NUM0	 (0)	//0IO


#define DRV_IO_NUM1	 (1)	//1IO


#define DRV_IO_PERIOD0	(0)


#define DRV_IO_PERIOD1	(1)


#define DRV_IO_PROTECT_ALL0	(DRVUSED)


#define DRV_IO_PROTECT_ALL1	(DRVUSED)


#define DRV_LATCH_NUM_LIMIT (4)


#define DRV_PULSE_ACT_0          (0x364) //GPIO48-63


#define DRV_PULSE_ACT_1          (0x368) //GPIO64-79


#define DRV_PULSE_CIR_0         0x1c4 //ǷѭGPIO(63:48)


#define DRV_PULSE_CIR_1         0x1c8//ǷѭGPIO(79:64)


#define DRV_PULSE_COUNT_EDGE         0x80


#define DRV_PULSE_COUNT_SEL          0x60 


#define DRV_PULSE_COUNT_SOFT         0x68


#define DRV_PULSE_COUNT_VALUE        0x84 


#define DRV_PULSE_DIS         (0x294) //GPIO(48) 


#define DRV_PULSE_EN_0          (0x35c) //ʹGPIO48-63


#define DRV_PULSE_EN_1          (0x360) //ʹGPIO64-79


#define DRV_PULSE_EQU         (0x1c0) //嵱D2-0 ӦGPIO(55:48);D5-3 ӦGPIO(63:56);D8-6 ӦGPIO(71:64);D11-9ӦGPIO(79:72)


#define DRV_PULSE_LATCH_EDGE         0x58


#define DRV_PULSE_LATCH_STATUS         0x5c


#define DRV_PULSE_WID         (0x1cc) //GPIO(48)


#define DRV_PeliCAN_ACC_CODE0     (0x00000040)                     /* PeliCANܴĴ λģʽ */


#define DRV_PeliCAN_ACC_CODE1     (0x00000044)                     /* PeliCANܴĴ λģʽ */


#define DRV_PeliCAN_ACC_CODE2     (0x00000048)                     /* PeliCANܴĴ λģʽ */


#define DRV_PeliCAN_ACC_CODE3     (0x0000004C)                     /* PeliCANܴĴ λģʽ */


#define DRV_PeliCAN_ACC_MASK0     (0x00000050)                     /* PeliCANμĴ λģʽ */


#define DRV_PeliCAN_ACC_MASK1     (0x00000054)                     /* PeliCANμĴ λģʽ */


#define DRV_PeliCAN_ACC_MASK2     (0x00000058)                     /* PeliCANμĴ λģʽ */


#define DRV_PeliCAN_ACC_MASK3     (0x0000005C)                     /* PeliCANμĴ λģʽ */


#define DRV_PeliCAN_BTR0          (0x00000018)                     /* PeliCANʱ0Ĵ */


#define DRV_PeliCAN_BTR1          (0x0000001C)                     /* PeliCANʱ1Ĵ */


#define DRV_PeliCAN_COMMAND       (0x00000004)                     /* PeliCANĴ */


#define DRV_PeliCAN_INTR          (0x0000000C)                     /* PeliCANжϼĴ */


#define DRV_PeliCAN_INTR_ENABLE   (0x00000010)                     /* PeliCANжʹܼĴ */


#define DRV_PeliCAN_MODE          (0x00000000)                     /* PeliCANģʽĴ */


#define DRV_PeliCAN_OCR           (0x00000020)                     /* PeliCANƼĴ */


#define DRV_PeliCAN_RXBUF(i)      (0x00000040 + (i) * 4)        /* PeliCANջ i=[0,12] */


#define DRV_PeliCAN_RXBUFBASE     (0x00000078)                    /* PeliCANջʼַ */


#define DRV_PeliCAN_RXMSGCOUNT    (0x00000074)                     /* PeliCANϢ */


#define DRV_PeliCAN_RX_ERR        (0x00000038)                     /* PeliCANմ */


#define DRV_PeliCAN_STATUS        (0x00000008)                     /* PeliCAN״̬Ĵ */


#define DRV_PeliCAN_TIME          (0x0000007C)                     /* PeliCANʱӷƵĴ */


#define DRV_PeliCAN_TXBUF(i)      (0x00000040 + (i) * 4)        /* PeliCANͻ i=[0,12] */


#define DRV_PeliCAN_TX_ERR        (0x0000003C)                     /* PeliCANʹ */


#define DRV_Power_Mode1  (1)//ʽ1 ʹλֱӿƿ


#define DRV_Power_Mode2  (2)//ʽ21λʹλ1λʹλƿ


#define DRV_Power_Mode3  (3)//ʽ3λʹλ()Ͷλʹλƿ


#define DRV_Power_Mode4  (4)//ʽ42ƿ


#define DRV_Pulse_EQU0	(EQU_HUNDRED)


#define DRV_Pulse_EQU1	(EQU_HUNDRED)


#define DRV_Pulse_EQU10	(EQU_HUNDRED)


#define DRV_Pulse_EQU11	(EQU_HUNDRED)


#define DRV_Pulse_EQU12	(EQU_HUNDRED)


#define DRV_Pulse_EQU13	(EQU_HUNDRED)


#define DRV_Pulse_EQU14	(EQU_HUNDRED)


#define DRV_Pulse_EQU15	(EQU_HUNDRED)


#define DRV_Pulse_EQU16	(EQU_HUNDRED)


#define DRV_Pulse_EQU17	(EQU_HUNDRED)


#define DRV_Pulse_EQU18	(EQU_HUNDRED)


#define DRV_Pulse_EQU19	(EQU_HUNDRED)


#define DRV_Pulse_EQU2	(EQU_HUNDRED)


#define DRV_Pulse_EQU20	(EQU_HUNDRED)


#define DRV_Pulse_EQU21	(EQU_HUNDRED)


#define DRV_Pulse_EQU22	(EQU_HUNDRED)


#define DRV_Pulse_EQU23	(EQU_HUNDRED)


#define DRV_Pulse_EQU24	(EQU_HUNDRED)


#define DRV_Pulse_EQU25	(EQU_HUNDRED)


#define DRV_Pulse_EQU26	(EQU_HUNDRED)


#define DRV_Pulse_EQU27	(EQU_HUNDRED)


#define DRV_Pulse_EQU28	(EQU_HUNDRED)


#define DRV_Pulse_EQU29	(EQU_HUNDRED)


#define DRV_Pulse_EQU3	(EQU_HUNDRED)


#define DRV_Pulse_EQU30	(EQU_HUNDRED)


#define DRV_Pulse_EQU31	(EQU_HUNDRED)


#define DRV_Pulse_EQU32	(EQU_HUNDRED)


#define DRV_Pulse_EQU33	(EQU_HUNDRED)


#define DRV_Pulse_EQU34	(EQU_HUNDRED)


#define DRV_Pulse_EQU35	(EQU_HUNDRED)


#define DRV_Pulse_EQU36	(EQU_HUNDRED)


#define DRV_Pulse_EQU37	(EQU_HUNDRED)


#define DRV_Pulse_EQU4	(EQU_HUNDRED)


#define DRV_Pulse_EQU5	(EQU_HUNDRED)


#define DRV_Pulse_EQU6	(EQU_HUNDRED)


#define DRV_Pulse_EQU7	(EQU_HUNDRED)


#define DRV_Pulse_EQU8	(EQU_HUNDRED)


#define DRV_Pulse_EQU9	(EQU_HUNDRED)


#define DRV_Pulse_IoBase0	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase1	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase10	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase11	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase12	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase13	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase14	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase15	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase16	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase17	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase18	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase19	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase2	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase20	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase21	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase22	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase23	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase24	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase25	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase26	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase27	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase28	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase29	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase3	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase30	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase31	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase32	(DRV_IO_NUM1)


#define DRV_Pulse_IoBase33	(DRV_IO_NUM1)


#define DRV_Pulse_IoBase34	(DRV_IO_NUM1)


#define DRV_Pulse_IoBase35	(DRV_IO_NUM1)


#define DRV_Pulse_IoBase36	(DRV_IO_NUM1)


#define DRV_Pulse_IoBase37	(DRV_IO_NUM1)


#define DRV_Pulse_IoBase4	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase5	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase6	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase7	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase8	(DRV_IO_NUM0)


#define DRV_Pulse_IoBase9	(DRV_IO_NUM0)


#define DRV_Pulse_NumPulse0	(48)


#define DRV_Pulse_NumPulse1	(49)


#define DRV_Pulse_NumPulse10	(58)


#define DRV_Pulse_NumPulse11	(59)


#define DRV_Pulse_NumPulse12	(60)


#define DRV_Pulse_NumPulse13	(61)


#define DRV_Pulse_NumPulse14	(62)


#define DRV_Pulse_NumPulse15	(63)


#define DRV_Pulse_NumPulse16	(64)


#define DRV_Pulse_NumPulse17	(65)


#define DRV_Pulse_NumPulse18	(66)


#define DRV_Pulse_NumPulse19	(67)


#define DRV_Pulse_NumPulse2	(50)


#define DRV_Pulse_NumPulse20	(68)


#define DRV_Pulse_NumPulse21	(69)


#define DRV_Pulse_NumPulse22	(70)


#define DRV_Pulse_NumPulse23	(71)


#define DRV_Pulse_NumPulse24	(72)


#define DRV_Pulse_NumPulse25	(73)


#define DRV_Pulse_NumPulse26	(74)


#define DRV_Pulse_NumPulse27	(75)


#define DRV_Pulse_NumPulse28	(76)


#define DRV_Pulse_NumPulse29	(77)


#define DRV_Pulse_NumPulse3	(51)


#define DRV_Pulse_NumPulse30	(78)


#define DRV_Pulse_NumPulse31	(79)


#define DRV_Pulse_NumPulse32	(48)


#define DRV_Pulse_NumPulse33	(49)


#define DRV_Pulse_NumPulse34	(50)


#define DRV_Pulse_NumPulse35	(51)


#define DRV_Pulse_NumPulse36	(52)


#define DRV_Pulse_NumPulse37	(53)


#define DRV_Pulse_NumPulse4	(52)


#define DRV_Pulse_NumPulse5	(53)


#define DRV_Pulse_NumPulse6	(54)


#define DRV_Pulse_NumPulse7	(55)


#define DRV_Pulse_NumPulse8	(56)


#define DRV_Pulse_NumPulse9	(57)


#define DRV_Pulse_Periodicity0	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity1	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity10	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity11	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity12	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity13	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity14	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity15	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity16	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity17	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity18	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity19	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity2	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity20	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity21	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity22	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity23	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity24	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity25	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity26	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity27	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity28	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity29	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity3	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity30	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity31	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity32	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity33	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity34	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity35	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity36	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity37	(DRV_PULSE_PERIOD)


#define DRV_Pulse_Periodicity4	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity5	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity6	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity7	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity8	(DRV_PULSE_SINGLE)


#define DRV_Pulse_Periodicity9	(DRV_PULSE_SINGLE)


#define DRV_REGS_NUM (40)


#define DRV_SPI_BASE 0x7400


#define DRV_SPI_CFR          (0x1C)


#define DRV_SPI_DATA          (0x00)


#define DRV_SPI_ICR         (0x04)


#define DRV_SPI_ISR         (0x08)


#define DRV_SPI_RBN        (0x0C)


#define DRV_SPI_RIC          (0x14)


#define DRV_SPI_STR         (0x18)


#define DRV_SPI_TBN        (0x10)


#define DRV_SSI_BASE_ADDR        0x800


#define DRV_SSI_BAUD_ADDR(i)         (0x50+0x40*(i))


#define DRV_SSI_BAUD_ERR    (0x1)    //ղЧ


#define DRV_SSI_CTRL_ADDR         0x8


#define DRV_SSI_IN_MODE1 (0)//ML


#define DRV_SSI_IN_MODE2 (3)//DS


#define DRV_SSI_MODE_ERR   (0x3)   //ճʱ


#define DRV_SSI_OUT_MODE1 (1)//ML


#define DRV_SSI_OUT_MODE2 (2)//DS


#define DRV_SSI_USCFR_ADDR         0xC


#define DRV_SSI_USCNTR_ADDR(i)          (0x48+0x40*(i))


#define DRV_SSI_USDR_ADDR(i)          (0x4c+0x40*(i))


#define DRV_SSI_USFR_ADDR(i)          (0x44+0x40*(i))


#define DRV_SSI_USFR_ERR    (0x5)   //״̬


#define DRV_SSI_USMR_ADDR(i)          (0x40+0x40*(i))


#define DRV_SYN_SOURCE0_FLAG_TIME_ADDR            (0x1114)//SYN_SOURCE0


#define DRV_SYN_SOURCE1_FLAG_TIME_ADDR            (0x1118) //SYN_SOURCE1


#define DRV_SYN_SOURCE2_FLAG_TIME_ADDR           (0x111c) //SYN_SOURCE2


#define DRV_SYN_SOURCE3_FLAG_TIME_ADDR            (0x1120) //SYN_SOURCE3


#define DRV_SYN_SOURCE_FLAG_ADDR                 (0x1100)


#define DRV_Star_Time_IoBase0	(DRV_IO_NUM1)


#define DRV_Star_Time_IoBase1	(DRV_IO_NUM1)


#define DRV_Star_Time_IoBase2	(DRV_IO_NUM1)


#define DRV_Star_Time_IoBase3	(DRV_IO_NUM1)


#define DRV_Star_Time_IoBase4	(DRV_IO_NUM1)


#define DRV_Star_Time_IoBase5	(DRV_IO_NUM1)


#define DRV_Star_Time_NumTime0	(0)


#define DRV_Star_Time_NumTime1	(1)


#define DRV_Star_Time_NumTime2	(2)


#define DRV_Star_Time_NumTime3	(3)


#define DRV_Star_Time_NumTime4	(6)


#define DRV_Star_Time_NumTime5	(7)


#define DRV_Syn_Source_EQU0	(EQU_ONE)


#define DRV_Syn_Source_EQU1	(EQU_ONE)


#define DRV_Syn_Source_IoBase0	(DRV_IO_NUM1)


#define DRV_Syn_Source_IoBase1	(DRV_IO_NUM1)


#define DRV_Syn_Source_NumSyn0	(1)


#define DRV_Syn_Source_NumSyn1	(0)


#define DRV_Syn_Source_Output0	(2)


#define DRV_Syn_Source_Output1	(2)


#define DRV_TIMER_SCALER   (1)


#define DRV_TIME_0         (0x1004) //ڲƵڼĴ0  D[15:0]    


#define DRV_TIME_1         (0x1008)//ڲƵڼĴ1  D[19:16]        


#define DRV_TIME_EDGE         (0x1140)//׼źԴѡĴ


#define DRV_TIME_EQU         (0x1000)//ʱʱĴ


#define DRV_TIME_READ         (0x1148)//ʱȡĴ


#define DRV_TIME_SEL         (0x1144)//ʱƼĴ


#define DRV_TM_BAUD0   (0x20)


#define DRV_TM_BAUD1   (0x24)


#define DRV_TM_CODE   (0x0)


#define DRV_TM_DATA   (0x0)


#define DRV_TM_INIT0   (0x28)


#define DRV_TM_INIT1   (0x2c)


#define DRV_TM_IOBASEA   (0x6C00)


#define DRV_TM_IOBASEB   (0x7000)


#define DRV_TM_MCODE   (0x1)


#define DRV_TM_PCM   (0xC)


#define DRV_TM_RESET   (0x4)


#define DRV_TM_SCODE   (0x2)


#define DRV_UART_BASE          (0x2000)


#define DRV_UART_BAUDH         (0x08)


#define DRV_UART_BAUDL         (0x04)


#define DRV_UART_CTRL          (0x1C)


#define DRV_UART_DATA          (0x00)


#define DRV_UART_FIFO_0         (1024)


#define DRV_UART_FIFO_1         (256)


#define DRV_UART_INTR          (0x14)


#define DRV_UART_INT_MODE0	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE1	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE10	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE11	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE12	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE13	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE14	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE15	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE16	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE17	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE18	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE19	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE2	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE20	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE21	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE22	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE3	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE4	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE5	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE6	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE7	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE8	(DRV_INT_EDGE_TRIG)


#define DRV_UART_INT_MODE9	(DRV_INT_EDGE_TRIG)


#define DRV_UART_REV_DATAERR (0x7)    //ݴ


#define DRV_UART_REV_NULL    (0x1)    //ղЧ


#define DRV_UART_REV_STATEERR (0x5)   //״̬


#define DRV_UART_REV_TIMEOUT (0x3)   //ճʱ


#define DRV_UART_RXFIFO        (0x0C)


#define DRV_UART_SEND_NULL    (0x1)   //ͲЧ


#define DRV_UART_SEND_RUNOVER (0x5)   //ҪݴFIFO


#define DRV_UART_SEND_TIMEOUT (0x3)   //ͳʱDRV16C850ʱʱtimeout


#define DRV_UART_STAT         (0x18)


#define DRV_UART_TXFIFO        (0x10)


#define DRV_Uart_IntFlag0	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag1	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag10	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag11	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag12	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag13	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag14	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag15	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag16	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag17	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag18	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag19	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag2	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag20	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag21	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag22	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag3	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag4	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag5	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag6	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag7	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag8	(DRV_INT_DISABLE)


#define DRV_Uart_IntFlag9	(DRV_INT_DISABLE)


#define DRV_Uart_IoBase0	(DRV_IO_NUM0)


#define DRV_Uart_IoBase1	(DRV_IO_NUM0)


#define DRV_Uart_IoBase10	(DRV_IO_NUM1)


#define DRV_Uart_IoBase11	(DRV_IO_NUM1)


#define DRV_Uart_IoBase12	(DRV_IO_NUM1)


#define DRV_Uart_IoBase13	(DRV_IO_NUM1)


#define DRV_Uart_IoBase14	(DRV_IO_NUM1)


#define DRV_Uart_IoBase15	(DRV_IO_NUM1)


#define DRV_Uart_IoBase16	(DRV_IO_NUM1)


#define DRV_Uart_IoBase17	(DRV_IO_NUM1)


#define DRV_Uart_IoBase18	(DRV_IO_NUM1)


#define DRV_Uart_IoBase19	(DRV_IO_NUM1)


#define DRV_Uart_IoBase2	(DRV_IO_NUM0)


#define DRV_Uart_IoBase20	(DRV_IO_NUM1)


#define DRV_Uart_IoBase21	(DRV_IO_NUM1)


#define DRV_Uart_IoBase22	(DRV_IO_NUM1)


#define DRV_Uart_IoBase3	(DRV_IO_NUM0)


#define DRV_Uart_IoBase4	(DRV_IO_NUM0)


#define DRV_Uart_IoBase5	(DRV_IO_NUM0)


#define DRV_Uart_IoBase6	(DRV_IO_NUM0)


#define DRV_Uart_IoBase7	(DRV_IO_NUM1)


#define DRV_Uart_IoBase8	(DRV_IO_NUM1)


#define DRV_Uart_IoBase9	(DRV_IO_NUM1)


#define DRV_Uart_Mux0	(8)


#define DRV_Uart_Mux1	(8)


#define DRV_Uart_Mux10	(8)


#define DRV_Uart_Mux11	(8)


#define DRV_Uart_Mux12	(8)


#define DRV_Uart_Mux13	(8)


#define DRV_Uart_Mux14	(8)


#define DRV_Uart_Mux15	(8)


#define DRV_Uart_Mux16	(8)


#define DRV_Uart_Mux17	(8)


#define DRV_Uart_Mux18	(8)


#define DRV_Uart_Mux19	(8)


#define DRV_Uart_Mux2	(8)


#define DRV_Uart_Mux20	(8)


#define DRV_Uart_Mux21	(8)


#define DRV_Uart_Mux22	(8)


#define DRV_Uart_Mux3	(8)


#define DRV_Uart_Mux4	(8)


#define DRV_Uart_Mux5	(8)


#define DRV_Uart_Mux6	(8)


#define DRV_Uart_Mux7	(8)


#define DRV_Uart_Mux8	(8)


#define DRV_Uart_Mux9	(8)


#define DRV_Uart_NumUart0	(0)


#define DRV_Uart_NumUart1	(2)


#define DRV_Uart_NumUart10	(3)


#define DRV_Uart_NumUart11	(4)


#define DRV_Uart_NumUart12	(5)


#define DRV_Uart_NumUart13	(6)


#define DRV_Uart_NumUart14	(7)


#define DRV_Uart_NumUart15	(8)


#define DRV_Uart_NumUart16	(9)


#define DRV_Uart_NumUart17	(10)


#define DRV_Uart_NumUart18	(11)


#define DRV_Uart_NumUart19	(12)


#define DRV_Uart_NumUart2	(3)


#define DRV_Uart_NumUart20	(13)


#define DRV_Uart_NumUart21	(14)


#define DRV_Uart_NumUart22	(15)


#define DRV_Uart_NumUart3	(4)


#define DRV_Uart_NumUart4	(5)


#define DRV_Uart_NumUart5	(14)


#define DRV_Uart_NumUart6	(15)


#define DRV_Uart_NumUart7	(0)


#define DRV_Uart_NumUart8	(1)


#define DRV_Uart_NumUart9	(2)


#define DRV_WIDTH_PERIOD_ERROR (0xffffffff)


#define Data_Shift(data,bit)			(((data)>>(bit))&0x1)


#define EDAC_CONFIG_REG					(0x000C)		//EDAC


#define EDAC_CTL					(0xc0)	//EDACƼĴ


#define EDAC_ERROR 1


#define EMEM_NOT_SUPPORT					(0)


#define EMIF_INT_CLEAR_REG				(0x001C)		//ж״̬Ĵ


#define EMIF_MULTI_ERR_INT				(0x1<<11)	//emif_twobits_err


#define ENHANCE_RECV_EN						(0x02)


#define ENHANCE_TX_START					(0x01)


#define EQU_FIFTY  (0x2)          //50 us


#define EQU_HUNDRED (0x3)      //100 us


#define EQU_ONE  (0x0)           // 1us


#define EQU_TEN  (0x1)               //10 us


#define ERROR					(-1)		/* ״ֵ̬, */


#define Expx(x)         (exp((float64)(x))                )


#define FALSE					(0)			/* ߼ֵ, */


#define FILLVALUE						(0xffffffff)


#define FIQ_MODE_STACK_SIZE				(8*1024)


#define FIQ_MODE_STACK_TOP			((MEM_INT_STK_BASE - IRQ_MODE_STACK_SIZE) & 0xfffffff0)


#define FLASH256 


#define FLI_OFFSET		(6)						/* С鵥λΪ2FLI_OFFSETη(6->128ֽ) */


#define FLOAT32_MAX         FLT_MAX     /* 3.4028235e+038          */


#define FLOAT32_MIN         FLT_MIN     /* 1.1754944e-038          */


#define FLOAT64_MAX         DBL_MAX     /* 1.7976931348623157e+308 */


#define FLOAT64_MIN         DBL_MIN     /* 2.2250738585072014e-308 */


#define FLOW_CTR		0x40


#define FLT32_TO_MEM(fptr)          (*((volatile unint32 *)(fptr)))


#define FLT64_TO_MEM(fptr)          (*((volatile ulong64 *)(fptr)))


#define FLT_TO_DBL_ID         (0x3Bu)          /* 将32位单精度浮点数转换为64位双精度浮点数 */


#define FLT_TO_SI08(x)                  ((unint08)((unint32)((siint32)(x)))


#define FLT_TO_SI08_ID        (0x32u)          /* ((unint08)((unint32)((siint32)(x)))将32位单精度浮点数转换为8位有符号整型数 */


#define FLT_TO_SI16(x)                  ((unint16)((unint32)((siint32)(x)))


#define FLT_TO_SI16_ID        (0x31u)          /* ((unint16)((unint32)((siint32)(x)))将32位单精度浮点数转换为16位有符号整型数 */


#define FLT_TO_SI32(x)                  ((unint32)((siint32)(x)))


#define FLT_TO_SI32_ID        (0x30u)          /* ((unint32)((siint32)(x)))将32位单精度浮点数转换为32位有符号整型数 */


#define FLT_TO_UN08(x)                  ((unint08)(x))


#define FLT_TO_UN08_ID        (0x22u)          /* ((unint08)(x))将32位单精度浮点数转换为8位无符号整型数  */


#define FLT_TO_UN16(x)                  ((unint16)(x))


#define FLT_TO_UN16_ID        (0x21u)          /* ((unint16)(x))将32位单精度浮点数转换为16位无符号整型数 */


#define FLT_TO_UN32(x)                  ((unint32)(x))


#define FLT_TO_UN32_ID        (0x20u)          /* ((unint32)(x))将32位单精度浮点数转换为32位无符号整型数 */


#define FPU_MASK				(0x87)


#define FRAME_ER		0x40


#define FRAME_MAXIMUM_LEN					(1514)		/*֡*/


#define FRAME_MINIMUM_LEN					(60)		/*С֡*/


#define FRAME_SYS_OCCUPY					(12)		/*ϵͳռֽ*/

#define FREE_BLOCK	(0x1)			/* 1:п   */


#define F_SYNCHRONIZED					 	(0x62)


#define Fabsx(x)        (fabs((float64)(x))               )


#define Fixx(x)         ((siint32)(x)                     )     /* ȡ */


#define Floorx(x)       (floor((float64)(x))              )


#define GCS_EXTPERIOD_INT_IONUM					(1)


#define GCS_EXTPERIOD_INT_NO					(BSP_GPIO_6_IRQID)


#define GET_NEXT_BLOCK(_addr, _r)	((BHDR *) ((I8 *) (_addr) + (_r)))	/* õһĿͷָ */


#define GFS_1553B0_AVAILABLE					(0)


#define GFS_1553B1_AVAILABLE					(0)


#define GFS_A6017DEFEND_AVAILABLE				(1)


#define GFS_AB_MACHINE_SWITCH_FLAG				(1)


#define GFS_APP_CONTROLPERIOD_AVAILABLE			(0)


#define GFS_APP_TIMESILCE_AVAILABLE				(0)


#define GFS_AUTO_EN_SEUINT_ENABLE				(1)


#define GFS_CRT0_FORBID							(1)


#define GFS_DATA_CACHE_AVAILABLE				(0)


#define GFS_EEPROM_AVAILABLE					(0)


#define GFS_EMIF_SRAM_AVAILABLE					(0)


#define GFS_EXT_PERIOD_ENABLE					(1)


#define GFS_EXT_PERIOD_NEED_SET					(1)


#define GFS_IDLETASK_SEU_ENABLE_SWITCH			(1)


#define GFS_INTR_CACHE_AVAILABLE				(0)


#define GFS_MACHINE_WORK_MODE					(0x3)


#define GFS_MEMOPTEXECUTE_POSITION				(1)


#define GFS_MEMREFRESH_POSITION					(0)


#define GFS_NAND_FLASH_AVAILABLE				(0)


#define GFS_NOR_FLASH8BIT_AVAILABLE				(1)


#define GFS_NOR_FLASH_AVAILABLE					(0)


#define GFS_OBC_AUTOCMD_REFRESH					(0)


#define GFS_PARAMCFG_ENABLE						(0)


#define GFS_REBOOT_PROGLOAD_ENABLE				(0)


#define GFS_REFRESHPERIOD_DAY					(365)


#define GFS_SDRAM_AVAILABLE						(0)


#define GFS_SPW2_AVAILABLE						(0)


#define GFS_SPW3_AVAILABLE						(0)


#define GFS_TIME_SLICE_EXTRA					(1)


#define GFS_TMR_DOG_CUTOBC_FLAG					(0)


#define GFS_TMR_DOG_RESET_FLAG					(0x1)


#define GLOBAL_TIMER_NO			(0x1)


#define GPI0Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI0Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI0_CFG					GPI_OUT		/*GPI0Ϊ*/


#define GPI0_DATA					GPI_LOW		/*ʼGPI0Ϊ߻*/


#define GPI0_IntEn					BSP_DISABLE


#define GPI10Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI10Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI10_CFG					GPI_OUT		/*GPI10Ϊ*/


#define GPI10_DATA					GPI_LOW		/*ʼGPI10Ϊ߻*/


#define GPI10_IntEn					BSP_DISABLE


#define GPI11Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI11Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI11_CFG					GPI_OUT		/*GPI11Ϊ*/


#define GPI11_DATA					GPI_HIGH	/*ʼGPI11Ϊ߻*/


#define GPI11_IntEn					BSP_DISABLE


#define GPI12Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI12Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI12_CFG					GPI_IN		/*GPI12Ϊ*/


#define GPI12_DATA					GPI_LOW		/*ʼGPI12Ϊ߻*/


#define GPI12_IntEn					BSP_DISABLE


#define GPI13Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI13Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI13_CFG					GPI_IN		/*GPI13Ϊ*/


#define GPI13_DATA					GPI_LOW		/*ʼGPI13Ϊ߻*/


#define GPI13_IntEn					BSP_DISABLE


#define GPI14Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI14Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI14_CFG					GPI_IN		/*GPI14Ϊ*/


#define GPI14_DATA					GPI_LOW		/*ʼGPI14Ϊ߻*/


#define GPI14_IntEn					BSP_DISABLE


#define GPI15Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI15Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI15_CFG					GPI_IN		/*GPI15Ϊ*/


#define GPI15_DATA					GPI_LOW		/*ʼGPI15Ϊ߻*/


#define GPI15_IntEn					BSP_DISABLE


#define GPI1Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI1Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI1_CFG					GPI_IN		/*GPI1Ϊ*/


#define GPI1_DATA					GPI_LOW		/*ʼGPI1Ϊ߻*/


#define GPI1_IntEn					BSP_DISABLE


#define GPI2Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI2Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI2_CFG					GPI_IN		/*GPI2Ϊ*/


#define GPI2_DATA					GPI_LOW		/*ʼGPI2Ϊ߻*/


#define GPI2_IntEn					BSP_DISABLE


#define GPI3Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI3Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI3_CFG					GPI_IN		/*GPI3Ϊ*/


#define GPI3_DATA					GPI_LOW		/*ʼGPI3Ϊ߻*/


#define GPI3_IntEn					BSP_DISABLE


#define GPI4Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI4Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI4_CFG					GPI_IN		/*GPI4Ϊ*/


#define GPI4_DATA					GPI_LOW		/*ʼGPI4Ϊ߻*/


#define GPI4_IntEn					BSP_ENABLE


#define GPI5Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI5Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI5_CFG					GPI_IN		/*GPI5Ϊ*/


#define GPI5_DATA					GPI_LOW		/*ʼGPI5Ϊ߻*/


#define GPI5_IntEn					BSP_ENABLE


#define GPI6Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI6Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI6_CFG					GPI_IN		/*GPI6Ϊ*/


#define GPI6_DATA					GPI_LOW		/*ʼGPI6Ϊ߻*/


#define GPI6_IntEn					BSP_ENABLE


#define GPI7Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI7Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI7_CFG					GPI_IN		/*GPI7Ϊ*/


#define GPI7_DATA					GPI_LOW		/*ʼGPI7Ϊ߻*/


#define GPI7_IntEn					BSP_ENABLE


#define GPI8Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI8Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI8_CFG					GPI_OUT		/*GPI8Ϊ*/


#define GPI8_DATA					GPI_LOW		/*ʼGPI8Ϊ߻*/


#define GPI8_IntEn					BSP_DISABLE


#define GPI9Int_TRIG_MODE			INT_PULSE_TRIG		/*ѡػƽ*/


#define GPI9Int_TRIG_POLARITY		INT_HIGH_TRIG		/*ѡߵƽ/ػ͵ƽ/½ش*/


#define GPI9_CFG					GPI_OUT		/*GPI9Ϊ*/


#define GPI9_DATA					GPI_LOW		/*ʼGPI9Ϊ߻*/


#define GPI9_IntEn					BSP_DISABLE


#define GPIO_AGAINST_SHAKE_REG					(0x48)


#define GPIO_DATA_REG							(0x00)


#define GPIO_DIRECT_REG							(0x04)


#define GPIO_INT_ENABLE_REG						(0x30)


#define GPIO_INT_LEVEL_REG						(0x38)


#define GPIO_INT_MASK_REG						(0x34)


#define GPIO_INT_POLARITY_REG					(0x3c)


#define GPIO_INT_STATUS_REG						(0x40)


#define GPIO_LS_SYNC							(0x60)


#define GPIO_MODE_REG							(0x08)


#define GPIO_NUM   (32) //GPIO ·80-48, ޸


#define GPIO_PORTA_EOI_REG						(0x4c)


#define GPIO_PORT_REG							(0x50)


#define HUNDRED_US   (0x3)   // 100 us 


#define HW_RT_ADDR (24)		//RTַ


#define ICDISER2	( 	(IRQ_DMA_SEU_EN<<15)|\
						(IRQ_SRAM_SEU_EN<<16)|\
						(IRQ_EMIF_SEU_EN<<17)|\
						(IRQ_EMIF_WR2ORE_EN<<18)|\
						(IRQ_EMIF_IORDYTO_EN<<19)|\
						(IRQ_SPW2_TxSEU_EN<<24)|\
						(IRQ_SPW2_RxSEU_EN<<25)|\
						(IRQ_SPW3_TxSEU_EN<<26)|\
						(IRQ_SPW3_RxSEU_EN<<27)|\
						(IRQ_SDRAM_SEU_EN<<28)|\
						(IRQ_1553B0_SEU_EN<<29)|\
						(IRQ_1553B1_SEU_EN<<30) )


#define IDLE_TASK_ID					SYSTASKNUM


#define IFG_frame_time_reg		 		 	(0x26)


#define INTEGRATE_CYCLE_DURATION			(0x0f)


#define INTEGRATION_CYCLE_CONFIG_reg		(0x08)


#define INTERRUPT_MASK_REG              (0x0000u)    /* 中断屏蔽寄存器(RD/WR) */


#define INTERRUPT_STATUS_REG            (0x0006u)    /* 中断状态寄存器(RD) */


#define INTStackBlockBegin		(MEM_INT_STK_LOWBASE)	


#define INTStackBlockSize		(MEM_INT_STK_SIZE)


#define INT_HIGH_TRIG						0x01		/*ѡ/ش*/


#define INT_LEVEL_TRIG						0x00		/*ѡƽ*/


#define INT_LOW_TRIG						0x00		/*ѡ/½ش*/


#define INT_PULSE_TRIG						0x01		/*ѡش*/


#define INT_STA_IS_BULK_REOP				(0x40)


#define INVALID								(0xdeadbeef)


#define IN_RANGE_CLOSE(val, lo, up)     (((lo) <= (val)) && ((val) <= (up)))


#define IN_RANGE_LCUO(val, lo, up)      (((lo) <= (val)) && ((val) < (up)))


#define IN_RANGE_LOUC(val, lo, up)      (((lo) < (val)) && ((val) <= (up)))


#define IN_RANGE_OPEN(val, lo, up)      (((lo) < (val)) && ((val) < (up)))


#define IN_WDT_RESET						(0x3)		/*ڹλ*/


#define IO_6017_EN_NUM (2) //6017ʹܼĴĸ޸


#define IO_CONFIG_REG					(0x0008)		//IOռ


#define IO_RDY_TIMEOUT_REG				(0x0018)		//IOռʹReadyźʱȴReadyźŵĳʱʱ


#define IO_WS_CFG_REG					(0x0028)		//IOռȴʱ


#define IRQ_1553B0_SEU_EN				SEU_DISABLE


#define IRQ_1553B1_SEU_EN				SEU_DISABLE


#define IRQ_DMA_SEU_EN					SEU_DISABLE


#define IRQ_EMIF_IORDYTO_EN				SEU_DISABLE


#define IRQ_EMIF_SEU_EN					SEU_ENABLE


#define IRQ_EMIF_WR2ORE_EN				SEU_DISABLE


#define IRQ_MODE_STACK_SIZE				(20*1024)


#define IRQ_MODE_STACK_TOP			(MEM_INT_STK_BASE & 0xfffffff0)


#define IRQ_SDRAM_SEU_EN				SEU_DISABLE


#define IRQ_SPW2_RxSEU_EN				SEU_DISABLE


#define IRQ_SPW2_TxSEU_EN				SEU_DISABLE


#define IRQ_SPW3_RxSEU_EN				SEU_DISABLE


#define IRQ_SPW3_TxSEU_EN				SEU_DISABLE


#define IRQ_SRAM_SEU_EN					SEU_ENABLE


#define ISR_INT_NEST_SP				(0x00)		/*жǶ*/


#define ISR_INT_NOT_NEST_SP			(0x01)		/*жǶ*/


#define ISR_STACK_REST_PAR			(0x06)		/*ɷλμĴ͸Ĵ*/


#define JFM29GL256			(1)	//JFM29GL256оƬ32MС


#define JFM29GL641			(3)	//JFM29GL641оƬ4MС


#define LESS_COMMON_ERR						(0x2)


#define LIMIT_RANGE_FLT(val, lo, up)    (((float64)(val) < (float64)(lo)) ? (float64)(lo) : (((float64)(val) > (float64)(up)) ? (float64)(up) : (float64)(val)))


#define LIMIT_RANGE_INT(val, lo, up)    (((siint32)(val) < (siint32)(lo)) ? (siint32)(lo) : (((siint32)(val) > (siint32)(up)) ? (siint32)(up) : (siint32)(val)))


#define LIST_HEAD(name)     struct list_head name = LIST_HEAD_INIT(name)


#define LIST_HEAD_INIT(name) { &(name), &(name) }


#define LLONG64_MAX     0            /* Ч */


#define LLONG64_MIN     0            /* Ч */


#define LOG_BIT1_TF( pos )                 ( UI32_MAKE( 0x00, 0x32, (1),   (pos) ) )      /* 32位标志量TRUE/FALSE的判断 */


#define LOG_BIT_TO_U08( len, pos )         ( UI32_MAKE( 0x00, 0x08, (len), (pos) ) )      /* 根据比特条件给08位变量赋值 */


#define LOG_BIT_TO_U16( len, pos )         ( UI32_MAKE( 0x00, 0x16, (len), (pos) ) )      /* 根据比特条件给16位变量赋值 */


#define LOG_BIT_TO_U32( len, pos )         ( UI32_MAKE( 0x00, 0x32, (len), (pos) ) )      /* 根据比特条件给32位变量赋值 */


#define LOG_UI08BIT( len, pos )         ( UI32_MAKE( 0x00, 0x08, (len), (pos) ) )         /* 32位标志量TRUE/FALSE的判断 */


#define LOG_UI08_TF          (0x0800u)           /* 08位标志量TRUE/FALSE的判断 */


#define LOG_UI16BIT( len, pos )         ( UI32_MAKE( 0x00, 0x16, (len), (pos) ) )         /* 32位标志量TRUE/FALSE的判断 */


#define LOG_UI16_TF          (0x1600u)           /* 16位标志量TRUE/FALSE的判断 */


#define LOG_UI32BIT( len, pos )         ( UI32_MAKE( 0x00, 0x32, (len), (pos) ) )         /* 32位标志量TRUE/FALSE的判断 */


#define LOG_UI32_FT          (0x32FFu)           /* 32位标志量TRUE/FALSE的判断 */


#define LOG_UI32_TF          (0x3200u)           /* 32位标志量TRUE/FALSE的判断 */


#define LOG_UI32_TF_BIT2     (0x3201u)           /* 32位标志量TRUE/FALSE的判断 */


#define LOOKUP_DEFAULT                  0x260u


#define LOOKUP_SANUM_MAX                64u


#define LOOP_BCK		0x80


#define Log10x(x)       (log10((float64)(x))              )


#define Log2x(x)        (log2((float64)(x))               )     /* 2Ϊ */


#define Logx(x)         (log((float64)(x))                )


#define M00_LAUNCH            (0x0000u)            /* MODE00: 主动段          */


#define M01_PXSUN             (0x0101u)            /* MODE01：+X轴对日        */


#define M02_NZSUN             (0x0202u)            /* MODE02：-Z轴对日        */


#define M04_STAR              (0x0404u)            /* MODE04：恒星定向        */


#define M05_INERTIA           (0x0505u)            /* MODE05：惯性调姿        */


#define M06_ORBIT             (0x0606u)            /* MODE06：轨控定向        */


#define M07_MOONGO            (0x0707u)            /* MODE07：对月正飞        */


#define M08_MOONBACK          (0x0808u)            /* MODE08：对月倒飞        */


#define M09_GOSIDE            (0x0909u)            /* MODE09：对月正侧飞      */


#define M10_BACKSIDE          (0x0A0Au)            /* MODE10：对月倒侧飞      */


#define M11_SIDEFLY           (0x0B0Bu)            /* MODE11：对月偏置        */


#define M12_MEASURE           (0x0C0Cu)            /* MODE12：标定            */


#define M13_FIXPOINT          (0x0D0Du)            /* MODE13：固定点凝视      */


#define M14_STOP              (0x0E0Eu)            /* MODE14：停控模式        */


#define MAC_ADDR_SIZE						(6)


#define MAC_BE_select_reg					(0x2b)


#define MAC_port_select_reg		 		 	(0x25)


#define MAC_rcv_select_reg					(0x29)


#define MASK64_40BIT                0x000000FFFFFFFFFFu     /* 64λеĵ40λ */


#define MASK64_48BIT                0x0000FFFFFFFFFFFFu     /* 64λеĵ48λ */


#define MASK64_56BIT                0x00FFFFFFFFFFFFFFu     /* 64λеĵ56λ */


#define MASK64_64BIT                0xFFFFFFFFFFFFFFFFu     /* 64λ */


#define MASK_ALL8F                  0xFFFFFFFFu             /* 32λ */


#define MASK_HI16                   0xFFFF0000u             /* 32λеĸ16λ */


#define MASK_HI24                   0xFFFFFF00u             /* 32位中的低24位 */


#define MASK_LO04                   0x0000000Fu             /* 32λеĵ4λ */


#define MASK_LO08                   0x000000FFu             /* 32λеĵ8λ */


#define MASK_LO16                   0x0000FFFFu             /* 32λеĵ16λ */


#define MASK_LO24                   0x00FFFFFFu             /* 32λеĵ24λ */


#define MAX(a, b)                       ((a) > (b) ? (a): (b))


#define MAX_FLI			(30)


#define MAX_LOG2_SLI	(5)


#define MAX_SLI			(1 << MAX_LOG2_SLI)     /* MAX_SLI = 2^MAX_LOG2_SLI */


#define MAX_TRANSMISSION_DELAY_reg_HIGH 	(0x01)


#define MAX_TRANSMISSION_DELAY_reg_LOW		(0x02)


#define MDIO								(0x3f)


#define MEMBERSHIP_reg						(0x00)


#define MEMFRESHING				(0x0)


#define MEMFRESHOVER			(0x1)


#define MEM_ALIGN					((BLOCK_ALIGN) - 1)


#define MEM_APP_DATA_USED_BASEADDR		(BSP_RAM_BASE_ADDR+0x98000)


#define MEM_APP_DATA_USED_SIZE			(512*1024)


#define MEM_APP_PROG_USED_BASEADDR		(BSP_RAM_BASE_ADDR+0x18000)


#define MEM_APP_PROG_USED_SIZE			(512*1024)


#define MEM_BOOT_USED_BASEADDR			(BSP_RAM_BASE_ADDR)


#define MEM_BOOT_USED_SIZE				(96*1024)


#define MEM_EMIFSRAM_BIT		(1)


#define MEM_INT_STK_BASE				(MEM_INT_STK_LOWBASE + MEM_INT_STK_SIZE - 8)


#define MEM_INT_STK_LOWBASE				(MEM_SYS_STK_LOWBASE + MEM_SYS_STK_SIZE + MEM_ISOLATION_SIZE)


#define MEM_INT_STK_SIZE				(IRQ_MODE_STACK_SIZE + FIQ_MODE_STACK_SIZE)


#define MEM_ISOLATION_SIZE				(512)


#define MEM_NAND_DATA_POSITION				1


#define MEM_NAND_DATA_SIZE					(1536*1024)		


#define MEM_NOR8_MAP_TYPE					0x202


#define MEM_OS_USED_BASEADDR			(MEM_INT_STK_LOWBASE + MEM_INT_STK_SIZE+MEM_ISOLATION_SIZE)


#define MEM_OS_USED_SIZE				(256*1024)


#define MEM_SDRAM_BIT			(2)


#define MEM_SRAM_BIT			(0)


#define MEM_SYS_STK_BASE				(MEM_SYS_STK_LOWBASE + MEM_SYS_STK_SIZE - 8)


#define MEM_SYS_STK_LOWBASE				(MEM_TRI32_USED_BASEADDR + MEM_TRI32_USED_SIZE)


#define MEM_SYS_STK_SIZE				(SVC_MODE_STACK_SIZE + SYS_MODE_STACK_SIZE + UND_MODE_STACK_SIZE + ABT_MODE_STACK_SIZE + MON_MODE_STACK_SIZE)


#define MEM_TO_FLT32(uptr)          (*((volatile float32 *)(uptr)))


#define MEM_TO_FLT64(ulptr)         (*((volatile float64 *)(ulptr)))


#define MEM_TRAP_INFO_RECORD_BASE		(MEM_OS_USED_BASEADDR + MEM_OS_USED_SIZE + MEM_ISOLATION_SIZE)


#define MEM_TRAP_INFO_RECORD_SIZE		(16*1024)


#define MEM_TRI32_USED_BASEADDR			(BSP_RAM_BASE_ADDR+0x118000+MEM_ISOLATION_SIZE)


#define MEM_TRI32_USED_SIZE				(40*1024+MEM_ISOLATION_SIZE)


#define MGKEY								(0x36303137)


#define MIN(a, b)                       ((a) < (b) ? (a): (b))


#define MIN_BLOCK_SIZE	(0x8)	/* СĴС */


#define MODE_COLD_AUTO			(0x2A)	/*˫䱸ģʽ,Զл*/


#define MODE_COLD_NONE			(0x2B)	/*˫䱸ģʽ,Զл*/


#define MODE_QUADRA_			(0x4)


#define MODE_SINGLE				(0x1)	/*ģʽ*/


#define MODE_TRIPLE_HOT			(0x3)	/*ȱģʽ*/


#define MONITOR_DATA_STACK_ADDR_REG     (0x000Au)    /* MT数据堆栈地址寄存器(RD/WR) */


#define MON_MODE_STACK_SIZE				(8*1024)


#define MON_MODE_STACK_TOP			((ABT_MODE_STACK_TOP - ABT_MODE_STACK_SIZE) & 0xfffffff0)


#define MSG_UPLOAD( sa )                { B1553RTSaWrite( SA_MEM_T( sa ), sndMsgList[(sa)].msgBuf, sndMsgList[(sa)].size ); }  


#define MT_TRIGGER_REG                  (0x000Du)    /* MT触发器字寄存器 (RD/WR) */


#define MULERRADDR						(0xA00E0000	)


#define NELEMENTS(array)		(sizeof (array)/ sizeof ((array)[0]))


#define NOR_FLASH_SECTOR_SIZE (128*1024)	/*NOR FLASHСΪ128kB*/


#define NOR_FLASH_TOTAL_SIZE				(4*1024*1024)	/*NOR FLASHС*/

#define NO_WAIT				(0)			/* ʱֵ,ȴ */


#define NPRIO								(64)			/* ȼ */


#define NULL 					(0)			/* ֵָ */


#define NULL_PTR            (0x00u)


#define NULL_STATEMENT()    do{ }while(0)


#define NUM_FACTION	8		/*ʮС8λɵ*/


#define NorFlash_DataEdacInSameSectorAddr	(0x8320000)		/*߼λã*/


#define NorFlash_DataMaxAddr				(0x8333330)		/*ַ*/


#define NorFlash_DeviceID					(0xD7)


#define NorFlash_EraseMinWtimeS				(6)


#define NorFlash_PhysicalSectorSize			(0x08000)		/*norflashСΪ32KB*/


#define NorFlash_SectorNum_Allbit			(0xFFFE0000)	/*иλ*/


#define NorFlash_SectorSize					(0x20000)		/*128KB EDACһ32KB,ӦСΪ512KB*/


#define NorFlash_SectorSize_AddrBit_Num		(17)			/*ÿڵַλΪ17bit*/


#define NorFlash_SectorSize_bit				(0x1FFFF)		/*ÿڵַλΪ17bit*/


#define NorFlash_WriteMinWtimeUs			(200)


#define NorflashType		(JFM29GL641)


#define OBCA_ON_DUTY_AUTO_BIT  (26)


#define OBCA_ON_DUTY_BIT  (14)


#define OBCB_ON_DUTY_AUTO_BIT  (27)


#define OBCB_ON_DUTY_BIT  (15)


#define OBCC_ON_DUTY_AUTO_BIT  (28)


#define OBCC_ON_DUTY_BIT  (16)


#define OBC_ON_DUTY_AUTO_VALUE  (0)//0'Ϊ࣬'1'Ϊδ


#define OBC_ON_DUTY_VALUE  (1)//0ΪδǿƵ࣬1ΪǿƵ


#define OK						(0)			/* ״ֵ̬, */


#define ONEBIT_ERR_ADDR				(0xc4)	//ַĴ


#define ONEBIT_ERR_DATA				(0xc8)	//ݼĴ


#define ONEBIT_ERR_EDAC				(0xcc)	//УĴ


#define ONE_MILSEC            (1000u)        /* 时钟计数器当量（1毫秒）              */


#define ONE_SECOND            (1000000u)     /* 时钟计数器当量计算的1s计数值         */


#define ONE_US   (0x1)   // 1 us 


#define OPEN   0xAAu                  /* ӵ */


#define ORIGIN_12BIT          (0x800Cu)          /* 原码传递12bit */


#define ORIGIN_1BIT           (0x8001u)          /* 原码传递1bit */


#define ORIGIN_1BIT_TO_U08        0x11               /* 原码传递1bit到08位 */


#define ORIGIN_1BIT_TO_U16        0x12               /* 原码传递1bit到16位 */


#define ORIGIN_1BIT_TO_U32        0x14               /* 原码传递1bit到32位 */


#define ORIGIN_20BIT          (0x800Fu)          /* 原码传递20bit */


#define ORIGIN_2BIT           (0x8002u)          /* 原码传递2bit */


#define ORIGIN_2BIT_TO_U08        0x21               /* 原码传递2bit到08位 */


#define ORIGIN_2BIT_TO_U16        0x22               /* 原码传递2bit到16位 */


#define ORIGIN_2BIT_TO_U32        0x24               /* 原码传递2bit到32位 */


#define ORIGIN_3BIT           (0x8003u)          /* 原码传递3bit */


#define ORIGIN_3BIT_TO_U08        0x31               /* 原码传递3bit到08位 */


#define ORIGIN_3BIT_TO_U16        0x32               /* 原码传递3bit到16位 */


#define ORIGIN_3BIT_TO_U32        0x34               /* 原码传递3bit到32位 */


#define ORIGIN_3BYTE          (0x03u)          /* 原码传递3字节 */


#define ORIGIN_4BIT           (0x8004u)          /* 原码传递4bit */


#define ORIGIN_4BIT_TO_U08        0x41               /* 原码传递4bit到08位 */


#define ORIGIN_4BIT_TO_U16        0x42               /* 原码传递4bit到16位 */


#define ORIGIN_4BIT_TO_U32        0x44               /* 原码传递4bit到32位 */


#define ORIGIN_5BIT           (0x8005u)          /* 原码传递5bit */


#define ORIGIN_6BIT           (0x8006u)          /* 原码传递6bit */


#define ORIGIN_BYTE           (0x01u)          /* 原码传递1字节 */


#define ORIGIN_CODE           (0x00u)          /* 原码传递n字节 */


#define ORIGIN_DWORD          (0x04u)          /* 原码传递4字节 */


#define ORIGIN_VALUE          (0x05u)          /* 立即数赋值 */


#define ORIGIN_WORD           (0x02u)          /* 原码传递2字节 */


#define ORMEM_CONFIG_REG				(0x0004)		//ROMռ


#define OR_WS_CFG_REG					(0x0024)		//ROMռȴʱ


#define OSERROR				(-1)


#define OSFALSE				(0)		/* ߼ֵ, */


#define OSINTCLR_INIT BSP_INTR_CLR


#define OSIntLock			IntLock			/* 20231218 2115 һ*/


#define OSIntUnlock			IntUnlock


#define OSMECBASE 0x80000000


#define OSNULL				(0)		/* ֵָ */


#define OSOK				(0)


#define OSTRUE				(1)		/* ߼ֵ,ȷ */


#define OS_CPU_INT_CNT					BSP_CPU_INT_CNT				/*BSP_CPU_INT_CNTض壬OSں˶ʹOS_CPU_INT_CNT*/

#define OS_ERR_PRIOSET_ID_NULL				(OS_ERR_INTERNAL_LIB  | ( 0x2<<8) | 0x1)				/*ıȼָΪ*/


#define OS_ERR_RDYSTAT_YET					(OS_ERR_INTERNAL_LIB  | ( 0x1<<8) | 0x4)				/*̬ѾΪ̬*/


#define OS_ERR_TASKDELETE_CALL_IN_LOCK		(OS_ERR_TASK_LIB | ( 0x1<<8) | 0x5)	/* ʱɾǰ */


#define OS_IDLE_PRIO						(63)


#define OS_IDLE_TASK_STACKSIZE			(0x4000)					/* ջСú */


#define OS_INTSTK_SIZE					MEM_INT_STK_SIZE			/*ж϶ջС*/


#define OS_INT_STK_HIGHBASE						(MEM_INT_STK_BASE + OS_INTSTK_SIZE - 8)	


#define OS_INT_STK_LOWBASE						(MEM_INT_STK_BASE)


#define OS_INVALID_ID		(0)			/* Чʶ */


#define OS_IRQ_TICK_PRIORITY			(BSP_HIGHEST_PRIORITY+1)	/* ʱƬжȼֵԽСȼԽߣһЩȼΪ̶ֵĴֵЧ*/


#define OS_MEM_CHK_ID		(4)			/* ڴЧʶ */


#define OS_MEM_POOL_ADDR						(MEM_OS_USED_BASEADDR)


#define OS_MEM_POOL_SIZE				MEM_OS_USED_SIZE			/*ڴؿռСú */

#define OS_MQ_CHK_ID		(3)			/* ϢЧʶ */


#define OS_PERIODIC_INT		(-1)		/* ѭʱģʽxj,2012.11.29*/


#define OS_SEM_CHK_ID		(2)			/* źЧʶ */


#define OS_SINGLE_INT		(0)			/* ʱģʽxj,2012.11.29*/


#define OS_SLICE_NO						BSP_TimeSlice_No			/*BSP_SLICE_NOض壬OSں˶ʹOS_SLICE_NO*/

#define OS_SYSIDLETASK_NAME					(0x1001)		/*  */


#define OS_SYS_TRAP			BSP_SYS_TRAP	/*ϵͳʹ*/


#define OS_TASKINFOREC_SIZE				(0)							/*Ϣ¼С粻Ҫм¼Ϊ0 */


#define OS_TASK_CHK_ID		(1)			/* Чʶ */


#define OS_TASK_DEFAULT_OPTION				(0x0)


#define OS_TASK_DEFAULT_STACKSIZE			(0x400)


#define OS_TASK_DELAY						(0x02)


#define OS_TASK_DELETED						(0x0f)			/*added by ql,2010520*/


#define OS_TASK_INFO_REC_HIGHBASE				(0)


#define OS_TASK_INFO_REC_LOWBASE				(0)


#define OS_TASK_PEND						(0x04)


#define OS_TASK_READY						(0x01)


#define OS_TASK_RR_TICKS				(1)							/* תȼʱƬú */


#define OS_TASK_RUN							(0x10)			/* ״̬λ */


#define OS_TASK_STACK_FILL_DATA				(0x0)			/* ջú */


#define OS_TASK_STACK_FILL_DATA_SIZE		(400)			/*ջʱֽ*/


#define OS_TASK_SUSPEND						(0x08)


#define OS_TIME_TICKS					(1000/OS_TIME_TICKS_PER_SEC)      /* ʱƬȣλms*/


#define OS_TIME_TICKS_PER_SEC			(250)						/* ÿ뷢ʱƬú */


#define OTHER_OBC_ACCORDANT_BIT1 (21)//ȶһ±־


#define OTHER_OBC_ACCORDANT_BIT2 (22)//ȶһ±־


#define OTHER_OBC_ACCORDANT_VALUE (0)//'0'Ϊһ£'1'Ϊһ


#define OTHER_OBC_POWERON_BIT1 (23)//OBCӵ״̬


#define OTHER_OBC_POWERON_BIT2 (24)//OBCӵ״̬


#define OTHER_OBC_POWERON_VALUE (1)//0'Ϊδӵ磬'1'Ϊӵ


#define OUT_WDT_RESET						(0x2)		/*⹷λ*/


#define OVERRUN			0x10


#define PART_COMMU_STATE_FAIL  0xAAu  /* ͨʧ */


#define PART_COMMU_STATE_NULL  0x00u  /* δͨ */


#define PART_COMMU_STATE_SUCC  0x55u  /* ͨųɹ */


#define PAR_EN			0x20


#define PAR_ER			0x20


#define PAR_SEL			0x10


#define PORT_ERR_ADDR						(0xfff)


#define PORT_ERR_FLAG						(3<<14)


#define PORT_SEU_FLAG						(1<<14)


#define PORT_TBE_FLAG						(1<<15)


#define POWER_OFF							(0x0)		/*ϵ*/


#define PREAMBLE_reg_HIGH					(0x16)


#define PREAMBLE_reg_LOW					(0x15)


#define PRECISION_reg					 	(0x50)


#define PREV_FREE	(0x2)			/* 1:ǰ   */


#define PREV_STATE	(0x2)			/* D1:ǰбʶ   */


#define PREV_USED	(0x0)			/* 0:ǰѷ */


#define PRE_READ_TIME						(0x28)


#define PRIVATE_TIMER_NO		(0x0)


#define PTR_MASK		(3)


#define PoolBlockBegin			(MEM_OS_USED_BASEADDR)	


#define PoolBlockSize			(MEM_OS_USED_SIZE)


#define Powx(x, y)      (pow((float64)(x), (float64)(y))  )


#define QClear( qDstc )            { *(qDst) = 0.0; *((qDst)+1) = 0.0; *((qDst)+2) = 0.0; *((qDst)+3) = 1.0; }


#define QCopy( qDst, qSrc )        { *(qDst) = *(qSrc); *((qDst)+1) = *((qSrc)+1); *((qDst)+2) = *((qSrc)+2); *((qDst)+3) = *((qSrc)+3); }


#define QFirstNode(qhead)		((qhead)->Head)			/* õ׽ڵ */


#define QInsertHead(qhead, qnode)	do	 			\
			{											\
				QInsert((qhead), (Q_NODE *)OSNULL, (qnode));	\
			}while(0)


#define QInsertTail(qhead, qnode)	do				\
	 		{											\
				QInsert((qhead), (qhead)->Tail, (qnode));	\
			}while(0)


#define QLastNode(qhead)		((qhead)->Tail)			/* õ׽ڵ */


#define QNextNode(qnode)		((qnode)->Next)			/* õǰһڵ */


#define QPrevNode(qnode)		((qnode)->Prev)			/* õһڵ */


#define RAMA_ERR							(0x1)


#define RAMBUFFADDR 0x40180000


#define RAMB_ERR							(0x2)


#define RAM_BLOCK_NUM	(sizeof(RamBlocks)/sizeof(MemBlock))


#define RAM_DOUBLE_AND_SINGLE_ERR				(0x03)


#define RAM_DOUBLE_ERR							(0x02)


#define RAM_NO_ERR								(0x00)


#define RAM_SEU_ERR							(0x0) // 


#define RAM_SINGLE_ERR							(0x01)


#define RAM_TBE_ERR							(0x1) // ˫


#define RCV_PCF_PROCESS_DELAY_reg		 	(0x14)


#define RD_DATA_BYPASS				(0xe4)	//EDAC·ݼĴ


#define RD_EDAC_ADDR_BYPASS			(0xdc)	//EDAC·ַĴ


#define RD_EDAC_BYPASS				(0xe0)	//EDAC·УĴ


#define READ_TIME_OUT						(0x30)


#define REAL(i)     	(U32)(*((V_U32*)(&i)))


#define REAL64(i)     	(U64)(*((V_U64*)(&i)))


#define REAL_FLI		(MAX_FLI - FLI_OFFSET)	/* ʵʹõFLIС */


#define REG_BC_CTW_D00_RT2RT_FORMAT         0x0001      /* 0 RT-TO-RT FORMAT            */


#define REG_BC_CTW_D01_BRD_FORMAT           0x0002      /* 1 BROADCAST FORMAT           */


#define REG_BC_CTW_D02_MODE_FORMAT          0x0004      /* 2 MODE CODE FORMAT           */


#define REG_BC_CTW_D03_1553AB_SELE          0x0008      /* 3 1553A/B SELECT             */


#define REG_BC_CTW_D04_EOMINT_EN            0x0010      /* 4 EOM INTERRUPT ENABLE       */


#define REG_BC_CTW_D05_BRDCAST_MASK         0x0020      /* 5 MASK BROADCAST BIT         */


#define REG_BC_CTW_D06_OFF_TEST             0x0040      /* 6 OFF LINE SELF TEST         */


#define REG_BC_CTW_D07_CHNL_AB              0x0080      /* 7 BUS CHANNEL A/B*           */


#define REG_BC_CTW_D08_RETRY_EN             0x0100      /* 8 RETRY ENABLED              */


#define REG_BC_CTW_D09_REVDFLG_MASK         0x0200      /* 9 RESERVED BITS MASK         */


#define REG_BC_CTW_D10_TERFLG_MASK          0x0400      /* 10 TERMINAL FLAG BIT MASK    */


#define REG_BC_CTW_D11_SUBFLG_MASK          0x0800      /* 11 SUBSYS FLAG BIT MASK      */


#define REG_BC_CTW_D12_SUBBUSY_MASK         0x1000      /* 12 SUBSYS BUSY BIT MASK      */


#define REG_BC_CTW_D13_SERACQ_MASK          0x2000      /* 13 SERVICE REQUEST BIT MASK  */


#define REG_BC_CTW_D14_MSGERR_MASK          0x4000      /* 14 MESSAGE ERR MASK          */


#define REG_BC_CTW_D15_RESERVED             0x8000      /* 15 RESERVED                  */


#define REG_CFG1_D00_BC_MSG_IN_PROG         0x0001      /* 0 BC MESSAGE IN PROGRESS(Read Only)   */


#define REG_CFG1_D00_MT_MSG_IN_PRO          0x0001      /* 0  TRIGGER ACTIVE(Read Only)          */


#define REG_CFG1_D00_RT_MSG_IN_PRO          0x0001u      /* 0  RT MESSAGE IN PROGRESS(Read Only)  */


#define REG_CFG1_D01_BC_FRAME_IN_PROG       0x0002      /* 1 BC FRAME IN PROGRESS(Read Only)     */


#define REG_CFG1_D01_MT_MONI_TRIG           0x0002      /* 1  MONITOR TRIGGERED(Read Only)       */


#define REG_CFG1_D01_RT_NOT_USED            0x0002u      /* 1  NOT USED                           */


#define REG_CFG1_D02_BC_ENABLED             0x0004      /* 2 BC ENABLED(Read Only)               */


#define REG_CFG1_D02_MT_MONI_EN_R           0x0004      /* 2  MONITOR ENABLED(Read Only)         */


#define REG_CFG1_D02_RT_NOT_USED            0x0004u      /* 2  NOT USED                           */


#define REG_CFG1_D03_BC_DBL_RETRY           0x0008      /* 3 Double/SINGLE* RETRY                */


#define REG_CFG1_D03_MT_NOT_USED            0x0008      /* 3  NOT USED                           */


#define REG_CFG1_D03_RT_NOT_USED            0x0008u      /* 3  NOT USED                           */


#define REG_CFG1_D04_BC_RETRY_EN            0x0010      /* 4 RETRY ENABLED                       */


#define REG_CFG1_D04_MT_NOT_USED            0x0010      /* 4  NOT USED                           */


#define REG_CFG1_D04_RT_NOT_USED            0x0010u      /* 4  NOT USED                           */


#define REG_CFG1_D05_BC_MSG_GAPTIMER        0x0020      /* 5 INTER-MESSAGE GAP TIMER ENABLED     */


#define REG_CFG1_D05_MT_NOT_USED            0x0020      /* 5  NOT USED                           */


#define REG_CFG1_D05_RT_MSG_GAPTIMER        0x0020u      /* 5  NOT USED                           */


#define REG_CFG1_D06_BC_INTL_TRIGGER        0x0040      /* 6 INTERNAL TRIGGER ENABLED            */


#define REG_CFG1_D06_MT_NOT_USED            0x0040      /* 6  NOT USED                           */


#define REG_CFG1_D06_RT_INTL_TRIGGER        0x0040u      /* 6  NOT USED                           */


#define REG_CFG1_D07_BC_EXTL_TRIGGER        0x0080      /* 7 EXTERNAL TRIGGER ENABLED            */


#define REG_CFG1_D07_MT_EX_TRIG_EN          0x0080      /* 7  EXTERNAL TRIGGER ENABLED           */


#define REG_CFG1_D07_RT_NOT_RTFLAG          0x0080u      /* 7  RTFLAG*(Read Only)                 */


#define REG_CFG1_D08_BC_FRAME_AUTO          0x0100      /* 8  FRAME AUTO-REPEAT                  */


#define REG_CFG1_D08_MT_NOT_USED            0x0100      /* 8  NOT USED                           */


#define REG_CFG1_D08_RT_NOT_SUBSYS_FLAG     0x0100u      /* 8  SUBSYSTEM FLAG*                    */


#define REG_CFG1_D09_BC_ST_SET_STOF         0x0200      /* 9  STATUS SET STOP-ON-FRAME           */


#define REG_CFG1_D09_MT_STOP_ON_TRIG        0x0200      /* 9  STOP-ON-TRIGGER                    */


#define REG_CFG1_D09_RT_NOT_SERVICE_REQ     0x0200u      /* 9  SERVICE REQUEST*                   */


#define REG_CFG1_D10_BC_ST_SET_STOM         0x0400      /* 10 STATUS SET STOP-ON-MESSAGE         */


#define REG_CFG1_D10_MT_START_ON_TRIG       0x0400      /* 10 START-ON-TRIGGER                   */


#define REG_CFG1_D10_RT_NOT_BUSY            0x0400u      /* 10 BUSY*                              */


#define REG_CFG1_D11_BC_FRAME_STOP_ERR      0x0800      /* 11 FRAME STOP-ON-ERROR                */


#define REG_CFG1_D11_MT_TRIG_EN             0x0800      /* 11 TRIGGER ENABLED WORD               */


#define REG_CFG1_D11_RT_NOT_DYN_BUS         0x0800u      /* 11 DYNAMIC BUS CONTROL ACCEPTANCE*    */


#define REG_CFG1_D12_BC_MSG_STOP_ERR        0x1000      /* 12 MESSAGE STOP-ON-ERROR              */


#define REG_CFG1_D12_MT_MSG_MONI_EN         0x1000      /* 12 MESSAGE MONITOR ENABLED            */


#define REG_CFG1_D12_RT_MSG_MONI_EN         0x1000u      /* 12 MESSAGE MONITOR ENABLED            */


#define REG_CFG1_D13_BC_AREA_B_SELECT       0x2000      /* 13 CURRENT AREA B/A*                  */


#define REG_CFG1_D13_MT_AREA_B_SELECT       0x2000      /* 13 CURRENT AREA B/A*                  */


#define REG_CFG1_D13_RT_AREA_B_SELECT       0x2000u      /* 13 CURRENT AREA B/A*                  */


#define REG_CFG1_D14_BC_MT_SELECT           0x4000      /* 14 MT/BC-RT*                          */


#define REG_CFG1_D14_MT_MT_SELECT           0x4000      /* 14 MT/BC-RT*                          */


#define REG_CFG1_D14_RT_MT_SELECT           0x4000u      /* 14 MT/BC-RT*                          */


#define REG_CFG1_D15_BC_RT_SELECT           0x8000      /* 15 RT/BC-MT*                          */


#define REG_CFG1_D15_MT_RT_SELECT           0x8000      /* 15 RT/BC-MT*                          */


#define REG_CFG1_D15_RT_RT_SELECT           0x8000u      /* 15 RT/BC-MT*                          */


#define REG_CFG2_D00_SEP_BCST_DATA          0x0001      /* 0 SEPARATE BROADCAST DATA       */


#define REG_CFG2_D01_EHD_RT_MEMM            0x0002      /* 1 ENHANCED RT MEMORY MANAGEMENT */


#define REG_CFG2_D02_CLEAR_SR               0x0004      /* 2 CLEAR SERVICE REQUEST         */


#define REG_CFG2_D03_LEVEL_INT              0x0008      /* 3 LEVEL/PULSE INTERRUPT REQUEST */


#define REG_CFG2_D04_INT_AUTO_CLEAR         0x0010      /* 4 INTERRUPT STATUS AUTO CLEAR   */


#define REG_CFG2_D05_LOAD_TTAG_SYN          0x0020      /* 5 LOAD TIME TAG ON SYNCHRONIZE  */


#define REG_CFG2_D06_CLEAR_TTAG_SYN         0x0040      /* 6 CLEAR TIME TAG ON SYNCHRONIZE */


#define REG_CFG2_D07_TTAG_R0                0x0080      /* 7 TIME TAG RESOLUTION 0 (TTR0)  */


#define REG_CFG2_D08_TTAG_R1                0x0100      /* 8 TIME TAG RESOLUTION 1 (TTR1)  */


#define REG_CFG2_D09_TTAG_R2                0x0200      /* 9 TIME TAG RESOLUTION 2 (TTR2)  */


#define REG_CFG2_D10_256_DISBL              0x0400      /* 10 256-WORD BOUNDR DISBL        */


#define REG_CFG2_D11_INVALID_DATA           0x0800      /* 11 OVERWRITE INVALID DATA       */


#define REG_CFG2_D12_DBL_BUF_EN             0x1000      /* 12 RX SA DOUBLE BUFFER ENABLE   */


#define REG_CFG2_D13_BUSY_LUT_EN            0x2000      /* 13 BUSY LOOK UP TABLE ENABLE    */


#define REG_CFG2_D14_RAM_PTY_EN             0x4000      /* 14 RAM PARITY ENABLE            */


#define REG_CFG2_D15_EHD_INT                0x8000      /* 15 ENHANCED INTERRUPTS          */


#define REG_CFG3_D00_RT_EHD_HDL             0x0001      /* 0  ENHANCED MODE CODE HANDLING  */


#define REG_CFG3_D01_1553A_EN               0x0002      /* 1  1553A MODE CODES ENABLE      */


#define REG_CFG3_D02_RT_FFW_EN              0x0004      /* 2  RTFAIL*)/RTFLAG* WRAP ENABLE */


#define REG_CFG3_D03_BUSY_TRAN_EN           0x0008      /* 3  BUSY RX TRANSFER ENABLE      */


#define REG_CFG3_D04_ILL_TRAN_DIS           0x0010      /* 4  ILLEGAL RX TRANSFER DISABLE  */


#define REG_CFG3_D05_RT_ALT_ST_EN           0x0020      /* 5  ALTERNATE STATUS WORD ENABLE */


#define REG_CFG3_D06_RT_OVERRIDE_T_ERR      0x0040      /* 6  OVERRIDE MODE T/R* ERROR     */


#define REG_CFG3_D07_RT_ILL_DIS             0x0080      /* 7  ILLEGALIZATION DISABLED      */


#define REG_CFG3_D08_MT_DATSTK_SIZE_0       0x0100      /* 8  MT DATA STACK SIZE 0         */


#define REG_CFG3_D09_MT_DATSTK_SIZE_1       0x0200      /* 9  MT DATA STACK SIZE 1         */


#define REG_CFG3_D10_MT_DATSTK_SIZE_2       0x0400      /* 10 MT DATA STACK SIZE 2         */


#define REG_CFG3_D11_MT_CMDSTK_SIZE_0       0x0800      /* 11 MT COMMAND STACK SIZE 0      */


#define REG_CFG3_D12_MT_CMDSTK_SIZE_1       0x1000      /* 12 MT COMMAND STACK SIZE 1      */


#define REG_CFG3_D13_BCRT_CMDSTK_SIZE0      0x2000      /* 13 BC/RT COMMAND STACK SIZE 0   */


#define REG_CFG3_D14_BCRT_CMDSTK_SIZE1      0x4000      /* 14 BC/RT COMMAND STACK SIZE 1   */


#define REG_CFG3_D15_ENHANCED_EN            0x8000      /* 15 ENHANCED MODE ENABLE         */


#define REG_CFG4_D00_TM0                    0x0001      /*  0 TEST MODE 0                        */


#define REG_CFG4_D01_TM1                    0x0002      /*  1 TEST MODE 1                        */


#define REG_CFG4_D02_TM2                    0x0004      /*  2 TEST MODE 2                        */


#define REG_CFG4_D03_RTADDR_CFG5            0x0008      /*  3 LATCH RT ADDRESS WITH CFG REG #5   */


#define REG_CFG4_D04_MT_TAG_OPTION          0x0010      /*  4 MONITOR TIME GAP OPTION            */


#define REG_CFG4_D05_VALID_BUSY_BIT         0x0020      /*  5 VALID BUSY BIT/NO DATA             */


#define REG_CFG4_D06_VALID_MSG_ERR          0x0040      /*  6 VALID IF MESSAGE ERROR BIT/NO DATA */


#define REG_CFG4_D07_SEC_RETRY_ALT          0x0080      /*  7 SECOND RETRY ALT/SAME* BUS         */


#define REG_CFG4_D08_FST_RETRY_ALT          0x0100      /*  8 FIRST RETRY ALT/SAME* BUS          */


#define REG_CFG4_D09_RETRY_ST_SET           0x0200      /*  9 RETRY IF STATUS SET                */


#define REG_CFG4_D10_RETRY_MSG_ERR          0x0400      /* 10 RETRY IF 1553A AND MESSAGE ERROR   */


#define REG_CFG4_D11_BC_BCST_MK_EN          0x0800      /* 11 BROADCAST MASK ENABLED/XOR*        */


#define REG_CFG4_D12_BC_EXPD_CW_EN          0x1000      /* 12 EXPANDED BC CONTROL WORD ENABLE    */


#define REG_CFG4_D13_RT_MODE_OV_BUSY        0x2000      /* 13 MODE COMMAND OVERRIDE BUSY         */


#define REG_CFG4_D14_RT_INBW_BUSY           0x4000      /* 14 INHIBIT BIT WORD IF BUSY           */


#define REG_CFG4_D15_RT_EXBW_EN             0x8000      /* 15 EXTERNAL BIT WORD ENABLE           */


#define REG_CFG5_D00_RT_ADDRPTY_R           0x0001      /*  0 RT ADDRESS PARITY(read only)*/


#define REG_CFG5_D01_RT_A0_R                0x0002      /*  1 RT ADDRESS 0(read only)     */


#define REG_CFG5_D02_RT_A1_R                0x0004      /*  2 RT ADDRESS 1(read only)     */


#define REG_CFG5_D03_RT_A2_R                0x0008      /*  3 RT ADDRESS 2(read only)     */


#define REG_CFG5_D04_RT_A3_R                0x0010      /*  4 RT ADDRESS 3(read only)     */


#define REG_CFG5_D05_RT_A4_R                0x0020      /*  5 RT ADDRESS 4(read only)     */


#define REG_CFG5_D06_RT_A_LATCH             0x0040      /*  6 RT ADDR LATCH/TRANSPARENT* */


#define REG_CFG5_D07_BCST_DIS               0x0080      /*  7 BROADCAST DISABLED         */


#define REG_CFG5_D08_GAP_CHK_EN             0x0100      /*  8 GAP CHECK ENABLED          */


#define REG_CFG5_D09_RTIME_SELE0            0x0200      /*  9 RESPONSE TIMEOUT SELECT 0  */


#define REG_CFG5_D10_RTIME_SELE1            0x0400      /* 10 RESPONSE TIMEOUT SELECT 1  */


#define REG_CFG5_D11_EXPD_CROSS_EN          0x0800      /* 11 EXPANDED CROSSING ENABLED  */


#define REG_CFG5_D12_EXT_TX_B               0x1000      /* 12 EXTERNAL TX INHIBIT B      */


#define REG_CFG5_D13_EXT_TX_A               0x2000      /* 13 EXTERNAL TX INHIBIT A      */


#define REG_CFG5_D14_SNGL_SELT              0x4000      /* 14 SINGLE-ENDED SELECT        */


#define REG_CFG5_D15_12M_SELT               0x8000      /* 15 12 MHZ CLOCK SELECT        */


#define REG_INTMK_D00_EOM                   0x0001      /* 0  END OF MESSAGE                  */


#define REG_INTMK_D01_BC_ST_SET             0x0002      /* 1  BC STATUS SET                   */


#define REG_INTMK_D01_MT_TRIGGER            0x0002      /* 1  MT PATTERN TRIGGER              */


#define REG_INTMK_D01_RT_MD_CODE            0x0002      /* 1  RT MODE CODE                    */


#define REG_INTMK_D02_FORMAT_ERR            0x0004      /* 2  FORMAT ERROR                    */


#define REG_INTMK_D03_BC_EOF                0x0008      /* 3  BC END OF FRAME                 */


#define REG_INTMK_D04_BC_MSG_EOM            0x0010      /* 4  BC MSG EOM                      */


#define REG_INTMK_D04_RT_CTRL_EOM           0x0010      /* 4  RT SUBADDRESS CONTROL WORD EOM  */


#define REG_INTMK_D05_RT_CIRC_ROLL          0x0020      /* 5  RT CIRCULAR BUFFER ROLLOVER     */


#define REG_INTMK_D06_TIME_TAG_ERR          0x0040      /* 6  TIME TAG ROLLOVER               */


#define REG_INTMK_D07_RT_ADDR_PERR          0x0080      /* 7  RT ADDRESS PARITY ERROR         */


#define REG_INTMK_D08_BC_RETRY              0x0100      /* 8  BC RETRY                        */


#define REG_INTMK_D09_HDSHAKE_FAIL          0x0200      /* 9  HANDSHAKE FAILURE               */


#define REG_INTMK_D10_MT_DATA_ROLL          0x0400      /* 10 MT DATA STACK ROLLOVER          */


#define REG_INTMK_D11_MT_CMD_ROLL           0x0800      /* 11 MT COMMAND STACK ROLLOVER       */


#define REG_INTMK_D12_CMD_ROLL              0x1000      /* 12 BC/RT COMMAND STACK ROLLOVER    */


#define REG_INTMK_D13_TX_TOUT               0x2000      /* 13 BC/RT TRANSMITTER TIMEOUT       */


#define REG_INTMK_D14_RAM_PERR              0x4000      /* 14 RAM PARITY ERROR                */


#define REG_INTMK_D15_RSERVED               0x8000      /* 15 RESERVED                        */


#define REG_INT_ST_D00_EOM                  0x0001      /* 0  END OF MESSAGE                 */


#define REG_INT_ST_D01_BC_STATUS            0x0002      /* 1  BC STATUS SET                  */


#define REG_INT_ST_D01_MT_TRIGGER           0x0002      /* 1  MTPATTERN TRIGGER              */


#define REG_INT_ST_D01_RT_MODE              0x0002      /* 1  RT MODE CODE                   */


#define REG_INT_ST_D02_FMAT_ERR             0x0004      /* 2  FORMAT ERROR                   */


#define REG_INT_ST_D03_BC_EOF               0x0008      /* 3  BC END OF FRAME                */


#define REG_INT_ST_D04_RT_CTRL_EOM          0x0010      /* 4  RT SUBADDRESS CONTROL WORD EOM */


#define REG_INT_ST_D05_RT_BUF_ROLL          0x0020      /* 5  RT CIRCULAR BUFFER ROLLOVER    */


#define REG_INT_ST_D06_TIME_TAG_ERR         0x0040      /* 6  TIME TAG ROLLOVER              */


#define REG_INT_ST_D07_RT_ADDR_ERR          0x0080      /* 7  RT ADDRESS PARITY ERROR        */


#define REG_INT_ST_D08_BC_RETRY             0x0100      /* 8  BC RETRY                       */


#define REG_INT_ST_D09_HDSHAKE              0x0200      /* 9  HANDSHAKE FAILURE              */


#define REG_INT_ST_D10_MT_DATA_ROLL         0x0400      /* 10 MT DATA STACK ROLLOVER         */


#define REG_INT_ST_D11_MTCMD_ROLL           0x0800      /* 11 MT COMMAND STACK ROLLOVER      */


#define REG_INT_ST_D12_CMD_ROLL             0x1000      /* 12 BC/RT COMMAND STACK ROLLOVER   */


#define REG_INT_ST_D13_TRAN_TOUT            0x2000      /* 13 TRANSMITTER TIMEOUT            */


#define REG_INT_ST_D14_RAM_ERR              0x4000      /* 14 RAM PARITY ERROR               */


#define REG_INT_ST_D15_MASTER               0x8000      /* 15 MASTER INTERRUPT               */


#define REG_RT_SACW_D00_BCST_MM0            0x0001      /* 0 BCST: MEMORY MANAGEMENT 0 (MM0) */


#define REG_RT_SACW_D01_BCST_MM1            0x0002      /* 1 BCST: MEMORY MANAGEMENT 1 (MM1) */


#define REG_RT_SACW_D02_BCST_MM2            0x0004      /* 2 BCST: MEMORY MANAGEMENT 2 (MM2) */


#define REG_RT_SACW_D03_BCST_CIRC_BUF_INT   0x0008      /* 3 BCST: CIRC BUF INT              */


#define REG_RT_SACW_D04_BCST_EOM_INT        0x0010      /* 4 BCST: EOM INT                   */


#define REG_RT_SACW_D05_RX_MM0              0x0020      /* 5 RX: MEMORY MANAGEMENT 0 (MM0)   */


#define REG_RT_SACW_D06_RX_MM1              0x0040      /* 6 RX: MEMORY MANAGEMENT 1 (MM1)   */


#define REG_RT_SACW_D07_RX_MM2              0x0080      /* 7 RX: MEMORY MANAGEMENT 2 (MM2)   */


#define REG_RT_SACW_D08_RX_CIRC_BUF_INT     0x0100      /* 8 RX: CIRC BUF INT                */


#define REG_RT_SACW_D09_RX_EOM_INT          0x0200      /* 9 RX: EOM INT                     */


#define REG_RT_SACW_D10_TX_MM0              0x0400      /* 10 TX: MEMORY MANAGEMENT 0 (MM0)  */


#define REG_RT_SACW_D11_TX_MM1              0x0800      /* 11 TX: MEMORY MANAGEMENT 1 (MM1)  */


#define REG_RT_SACW_D12_TX_MM2              0x1000      /* 12 TX: MEMORY MANAGEMENT 2 (MM2)  */


#define REG_RT_SACW_D13_TX_CIRC_BUF_INT     0x2000      /* 13 TX: CIRC BUF INT               */


#define REG_RT_SACW_D14_TX_EOM_INT          0x4000      /* 14 TX: EOM INT                    */


#define REG_RT_SACW_D15_RX_DBUF_EN          0x8000      /* 15 RX: DOUBLE BUFFER ENABLE       */


#define REG_START_D00_RESET                 0x0001      /* 0 RESET               */


#define REG_START_D01_BC_START              0x0002      /* 1 BC START            */


#define REG_START_D01_MT_START              0x0002      /* 1 MT START            */


#define REG_START_D02_INT_RESET             0x0004      /* 2 INTERRUPT RESET     */


#define REG_START_D03_TTAG_RESET            0x0008      /* 3 TIME TAG RESET      */


#define REG_START_D04_TTAG_CLOCK            0x0010      /* 4 TIME TAG TEST CLOCK */


#define REG_START_D05_BC_STOF               0x0020      /* 5 BC STOP-ON-FRAME    */


#define REG_START_D06_BC_STOM               0x0040      /* 6 BC STOP-ON-MESSAGE  */


#define REG_START_D06_MT_STOM               0x0040      /* 6 MT STOP-ON-MESSAGE  */


#define REG_START_D15_D07_RESERVED          0x0000      /* 15~7 RESERVED         */


#define RESET  0x55AAu                /*  */


#define REV_EN			0x1


#define REV_INT_EN		0x4


#define ROUNDDOWN_SIZE(_r)			((_r) & (U32)(~MEM_ALIGN))


#define ROUNDUP(_x, _v)				((((U32)(~(_x)) + 1) & ((_v)-1)) + (_x))


#define ROUNDUP_SIZE(_r)			(((_r) + MEM_ALIGN) &(U32)(~MEM_ALIGN))


#define ROUND_DOWN(x, align)	((U32)(x) & (U32)(~((align) - 1)))


#define ROUND_UP(x, align)		(((U32) (x) + ((align) - 1)) & (U32)(~((align) - 1)))


#define RT_A_BROADCAST_SUBADDR(i)       ( 0x0180 + (i) )


#define RT_A_CONTROL_WORD_SUBADDR(i)    ( 0x01A0 + (i) )


#define RT_A_RECEIVE_SUBADDR(i)         ( 0x0140 + (i) )


#define RT_A_TRANSMIT_SUBADDR(i)        ( 0x0160 + (i) )


#define RT_BIT_WORD_REG                 (0x000Fu)    /* RT自测试字寄存器(RD) */


#define RT_BSTW_D00_CMDERR              0x0001  /* 0(LSB) COMMAND WORD CONTENTS ERROR */


#define RT_BSTW_D01_RT2RT_2CMDERR       0x0002  /* 1 RT-RT 2ND COMMAND ERROR          */


#define RT_BSTW_D02_RT2RT_ERR           0x0004  /* 2 RT-RT GAP/SYNCH/ADDRESS ERROR    */


#define RT_BSTW_D03_INVALIDWORD         0x0008  /* 3 INVALID WORD                     */


#define RT_BSTW_D04_NODATASYNC          0x0010  /* 4 INCORRECT DATA SYNC              */


#define RT_BSTW_D05_WDCNTERR            0x0020  /* 5 WORD COUNT ERROR                 */


#define RT_BSTW_D06_ILLCMD              0x0040  /* 6 ILLEGAL COMMAND WORD             */


#define RT_BSTW_D07_DATASTACKRL         0x0080  /* 7 DATA STACK ROLLOVER              */


#define RT_BSTW_D08_LTSTFAIL            0x0100  /* 8 LOOP TEST FAIL                   */


#define RT_BSTW_D09_NORSP               0x0200  /* 9 NO RESPONSE TIMEOUT              */


#define RT_BSTW_D10_FMTERR              0x0400  /* 10 FORMAT ERROR                    */


#define RT_BSTW_D11_RT2RT               0x0800  /* 11 RT-RT FORMAT                    */


#define RT_BSTW_D12_ERRFLG              0x1000  /* 12 ERROR FLAG                      */


#define RT_BSTW_D13_CHNL                0x2000  /* 13 CHANNEL B/A                     */


#define RT_BSTW_D14_SOM                 0x4000  /* 14 SOM                             */


#define RT_BSTW_D15_EOM                 0x8000  /* 15(MSB) EOM                        */


#define RT_BUSY_BIT_LOOKUP_TABLE        (0x0240u)    /* RT忙状态查找表(0x0240~0x0247)基址 */


#define RT_B_BROADCAST_SUBADDR(i)       ( 0x0200 + (i) )


#define RT_B_CONTROL_WORD_SUBADDR(i)    ( 0x0220 + (i) )


#define RT_B_RECEIVE_SUBADDR(i)         ( 0x01C0 + (i) )


#define RT_B_TRANSMIT_SUBADDR(i)        ( 0x01E0 + (i) )


#define RT_COMMAND_ILLEGALIZING(i)      ( 0x0300 + (i) )


#define RT_COMMAND_ILLEGALIZING_TABLE   (0x0300u)    /* RT非法命令字查找表(0x0300~0x03FF)基址 */


#define RT_COMMAND_STACK_POINT_A        (0x0100u)    /* RT堆栈A指针 */


#define RT_COMMAND_STACK_POINT_B        (0x0104u)    /* RT堆栈B指针 */


#define RT_DATA_STACK_ADDR_REG          (0x000Au)    /* RT数据堆栈地址寄存器(RD/WR) */


#define RT_LAST_COMMAND_REG             (0x000Du)    /* RT最后一个命令字寄存器 (RD/WR) */


#define RT_LOOKUP_TABLE_A               (0x0140u)    /* RT查找表A(0x0140~0x01BF)基址 */


#define RT_LOOKUP_TABLE_B               (0x01C0u)    /* RT查找表B(0x01C0~0x023F)基址 */


#define RT_MEM_ADDR_BASE                (0x28000000u)


#define RT_MEM_BUSY_TABBASE             0x0240  /* RTæ״̬ұ(0x0240~0x0247)ַ */


#define RT_MEM_CMDSTACK_PTR             (sRtStatus.stackPtr)    /* 0x0100/0x0104, RTջA/Bָ */


#define RT_MEM_CMDSTACK_PTR_A           0x0100  /* RTջAָ */


#define RT_MEM_CMDSTACK_PTR_B           0x0104  /* RTջBָ */


#define RT_MEM_CMD_ILL_TABBASE          0x0300  /* RTǷֲұ(0x0300~0x03FF)ַ */


#define RT_MEM_LOOKUP_TABBASE_A         0x0140  /* RTұA(0x0140~0x01BF)ַ */


#define RT_MEM_LOOKUP_TABBASE_B         0x01C0  /* RTұB(0x01C0~0x023F)ַ */


#define RT_MEM_MODE_CODE_DATA           0x0110  /* RTʽݴ */


#define RT_MEM_MODE_CODE_INTTAB         0x0108  /* RTʽжϲұ */


#define RT_MEM_SATAB_BCST(i)            (sRtStatus.areaSelFixSt + 0x40 + (i))   /* 0x0180/0x0200, RTջA/B㲥ұַ */


#define RT_MEM_SATAB_CTRLW(i)           (sRtStatus.areaSelFixSt + 0x60 + (i))   /* 0x01A0/0x0220, RTջA/Bֱַ */


#define RT_MEM_SATAB_RECV(i)            (sRtStatus.areaSelFixSt + 0x00 + (i))   /* 0x0140/0x01C0, RTջA/Bղұַ */


#define RT_MEM_SATAB_TRANS(i)           (sRtStatus.areaSelFixSt + 0x20 + (i))   /* 0x0160/0x01E0, RTջA/BͲұַ */


#define RT_MODE_CODE_DATA               (0x0110u)    /* RT方式代码数据存放区 */


#define RT_MODE_CODE_SELECT_INT_TABLE   (0x0108u)    /* RT方式代码中断查找表 */


#define RT_REG_ADDR_BASE                (0xA0030000u)


#define RT_SA00                     0u


#define RT_SA01                     1u


#define RT_SA02                     2u


#define RT_SA03                     3u


#define RT_SA04                     4u


#define RT_SA05                     5u


#define RT_SA06                     6u


#define RT_SA07                     7u


#define RT_SA08                     8u


#define RT_SA09                     9u


#define RT_SA10                     10u


#define RT_SA11                     11u


#define RT_SA12                     12u


#define RT_SA13                     13u


#define RT_SA14                     14u


#define RT_SA15                     15u


#define RT_SA16                     16u


#define RT_SA17                     17u


#define RT_SA18                     18u


#define RT_SA19                     19u


#define RT_SA20                     20u


#define RT_SA21                     21u


#define RT_SA22                     22u


#define RT_SA23                     23u


#define RT_SA24                     24u


#define RT_SA25                     25u


#define RT_SA26                     26u


#define RT_SA27                     27u


#define RT_SA28                     28u


#define RT_SA29                     29u


#define RT_SA30                     30u


#define RT_SA31                     31u


#define RT_STATUS_WORD_EOM              (0x8000u)    /* 消息完成标志 */


#define RT_STATUS_WORD_REG              (0x000Eu)    /* RT状态字寄存器(RD) */


#define RT_STW_D00_TERMINAL_FLG         0x0001  /* 0(LSB) TERMINAL FLAG               */


#define RT_STW_D01_DYN_BUS_ACP          0x0002  /* 1 DYNAMIC BUS CONTROL ACCEPT       */


#define RT_STW_D02_SUB_SYS_FLG          0x0004  /* 2 SUBSYSTEM FLAG                   */


#define RT_STW_D03_BUSY                 0x0008  /* 3 BUSY                             */


#define RT_STW_D04_BCST_RES             0x0010  /* 4 BROADCAST COMMAND RECEIVED       */


#define RT_STW_D05_RES                  0x0020  /* 5 RESERVED                         */


#define RT_STW_D06_RES                  0x0040  /* 6 RESERVED                         */


#define RT_STW_D07_RES                  0x0080  /* 7 RESERVED                         */


#define RT_STW_D08_SER_REQ              0x0100  /* 8 SERVICE REQUEST                  */


#define RT_STW_D09_INSTRUMENT           0x0200  /* 9 INSTRUMENTATION                  */


#define RT_STW_D10_MSG_ERR              0x0400  /* 10 MESSAGE ERROR                   */


#define RT_STW_D11_ZERO                 0x0800  /* 11 LOGIC "0"                       */


#define RT_STW_D12_ZERO                 0x1000  /* 12 LOGIC "0"                       */


#define RT_STW_D13_ZERO                 0x2000  /* 13 LOGIC "0"                       */


#define RT_STW_D14_ZERO                 0x4000  /* 14 LOGIC "0"                       */


#define RT_STW_D15_ZERO                 0x8000  /* 15(MSB) LOGIC "0"                  */


#define RT_SUBADDR_CONTROL_WORD_REG     (0x0004u)    /* RT子地址控制字寄存器2(RD/WR) */


#define RX_BULK_REOP_ENABLE_INT_BIT			(0x100)


#define RX_FIFO_EMPTY_BIT				(0x02)


#define RX_FIFO_ERROR_BITS					(0x0f)


#define RX_FIFO_NOT_EMPTY				(0x00)


#define RX_FIFO_NOT_REOP				(0x00)


#define RX_FIFO_REOP_BIT				(0x20)


#define RX_FIFO_REOP_DISABLE_INT_MASK	(0xffffff7f)


#define RX_FIFO_REOP_ENABLE_INT_BIT		(0x80)


#define RX_PKT128_BASE					(0xFFF)			


#define RX_PKT1_BASE					(0x110)			


#define RX_PKT2_BASE					(0x210)			


#define RX_PKT3_BASE					(0x310)			


#define RX_PKT4_BASE					(0x410)			


#define RX_PKT5_BASE					(0x610)			


#define RX_PKT6_BASE					(0xFFF)			


#define RX_PKT7_BASE					(0xFFF)


#define RX_STACK_REOP_ENABLE_INT_BIT		(0x200)


#define RX_TX_BULK_MODE				(0x05)


#define RX_TX_EMEM_MODE				(0x35)


#define RX_TX_FIFO_MODE				(0x00)


#define RX_TX_STACK_MODE			(0x0F)


#define S00_0BOOT             (0x0000u)            /* MODE01_0：主动段复位     */


#define S00_1RUN              (0x0001u)            /* MODE01_1：主动段运行     */


#define S01_0DAMP             (0x0100u)            /* MODE01_0：速率阻尼       */


#define S01_1PICH             (0x0101u)            /* MODE01_1：俯仰搜索       */


#define S01_2YAW              (0x0102u)            /* MODE01_2：偏航搜索       */


#define S01_3SUN              (0x0103u)            /* MODE01_3：巡航对日       */


#define S01_4HOLD             (0x0104u)            /* MODE01_4：保持           */


#define S02_0DAMP             (0x0200u)            /* MODE02_0：速率阻尼       */


#define S02_1ROLL             (0x0201u)            /* MODE02_1：滚动搜索       */


#define S02_2PICH             (0x0202u)            /* MODE02_2：俯仰搜索       */


#define S02_3SUN              (0x0203u)            /* MODE02_3：巡航对日       */


#define S02_4HOLD             (0x0204u)            /* MODE02_4：保持           */


#define S02_5MW               (0x0205u)            /* MODE02_5：轮控机动       */


#define S02_6JET              (0x0206u)            /* MODE02_6：喷气机动       */


#define S04_0STAR             (0x0400)            /* MODE04_0：恒星定向       */


#define S05_0JET              (0x0500)            /* MODE05_0：喷气调姿       */


#define S05_1MW               (0x0501)            /* MODE05_1：轮控调姿       */


#define S06_0RDY              (0x0600)            /* MODE06_0：开机前准备     */


#define S06_1BOOT             (0x0601)            /* MODE06_1：发动开机       */


#define S06_2OFF              (0x0602)            /* MODE06_2：关机后姿态稳定 */


#define S07_0JET              (0x0700)            /* MODE07_0：喷气调姿       */


#define S07_1MW               (0x0701)            /* MODE07_1：轮控调姿       */


#define S07_2MOON             (0x0702)            /* MODE07_2：对月定向       */


#define S08_0JET              (0x0800)            /* MODE08_0：喷气调姿       */


#define S08_1MW               (0x0801)            /* MODE08_1：轮控调姿       */


#define S08_2MOON             (0x0802)            /* MODE08_2：对月定向       */


#define S09_0JET              (0x0900)            /* MODE09_0：喷气调姿       */


#define S09_1MW               (0x0901)            /* MODE09_1：轮控调姿       */


#define S09_2MOON             (0x0902)            /* MODE09_2：对月定向       */


#define S10_0JET              (0x0A00)            /* MODE0A_0：喷气调姿       */


#define S10_1MW               (0x0A01)            /* MODE0A_1：轮控调姿       */


#define S10_2MOON             (0x0A02)            /* MODE0A_2：对月定向       */


#define S11_0JET              (0x0B00)            /* MODE0B_0：喷气调姿       */


#define S11_1MW               (0x0B01)            /* MODE0B_1：轮控调姿       */


#define S11_2MOON             (0x0B02)            /* MODE0B_2：对月定向       */


#define S12_0                 (0x0C00)            /* MODE0C_0       */


#define S12_1                 (0x0C01)            /* MODE0C_1       */


#define S12_2                 (0x0C02)            /* MODE0C_2       */


#define S12_3                 (0x0C03)            /* MODE0C_3       */


#define S12_4                 (0x0C04)            /* MODE0C_4       */


#define S12_5                 (0x0C05)            /* MODE0C_5       */


#define S12_6                 (0x0C06)            /* MODE0C_6       */


#define S12_7                 (0x0C07)            /* MODE0C_7       */


#define S13_0                 (0x0D00u)            /* MODE13_0：大角度凝视      */


#define S13_1                 (0x0D01u)            /* MODE13_1：小角度凝视      */


#define S14_0                 (0x0E00u)            /* MODE15：停控模式        */


#define SA_ADDR_NULL                    ( 0xFE0u )            /* 空地址（未用子地址）             */


#define SA_MEM_R( sa )                  ( SUBADDR_MEM( rcvMsgList[(sa)].saOffset ) )


#define SA_MEM_T( sa )                  ( SUBADDR_MEM( sndMsgList[(sa)].saOffset ) ) 


#define SCONR	 					(0x0)	//SDRAMüĴ


#define SCSLR0_LOW	 				(0x14)	//Ƭѡ0ַĴ


#define SCTLR	 					(0xc)	//SDRAMƼĴ


#define SDRAM_EDAC_AHBERR_EN	(BSP_ENABLE)


#define SDRAM_EDAC_EN			(BSP_ENABLE)


#define SDRAM_INIT_FILL_SIZE				(4*1024*1024)


#define SDRAM_INIT_FILL_StartAdd			(BSP_SDRAM_DATA_BASE_ADDR+SDRAM_INIT_LOADER_FILLED_SIZE)


#define SDRAM_INIT_LOADER_FILLED_SIZE		(0x00000)


#define SDRAM_SCONR 			(0x001C3388)


#define SDRAM_SCTLR				(0x3288)


#define SDRAM_SIZE				(128 * 1024 * 1024)


#define SDRAM_SREFR				(0x13D)  //@up by V1.03(0.0s)_0118


#define SDRAM_STMG0R 			(0x2261495)


#define SDRAM_STMG1R 			(0x70008)


#define SDRAM_TWO_BITS_ERR_INT			(0x1)		//sdram_twobits_err


#define SECTORSIZE  32*1024


#define SET_BITS(addr, mask, val)			\
	{										\
		U32 temp_reg_val = BSP_Get((addr));	\
		temp_reg_val &= ~(mask);			\
		temp_reg_val |= (val) & (mask);		\
		BSP_Set((addr), temp_reg_val);		\
	}


#define SEU_DISABLE							(0x0)


#define SEU_ENABLE							(0x1)


#define SEU_ERR								(0x1)


#define SI08_TO_DBL(x)                  ((float64)((siint08)(x)))


#define SI16_TO_DBL(x)                  ((float64)((siint16)(x)))


#define SI16_TO_FLT(x)                  ((float32)((siint16)(x)))


#define SI16_TO_SI08_ID       (0x59u)          /* 将16位整数转换为8位整型数 */


#define SI32_TO_DBL(x)                  ((float64)((siint32)(x)))


#define SI32_TO_FLT(x)                  ((float32)((siint32)(x)))


#define SIINT08_MAX         SCHAR_MAX   /*  127 */


#define SIINT08_MIN         SCHAR_MIN   /* -128 */


#define SIINT16_MAX         SHRT_MAX    /*  32767 */


#define SIINT16_MIN         SHRT_MIN    /* -32768 */


#define SIINT32_MAX         INT_MAX     /*  2147483647 */


#define SIINT32_MIN         INT_MIN     /* -2147483648 */


#define SINGLEBITERROR 1


#define SIZEOF(v)                       ((unint32)sizeof(v))


#define SMALL_BLOCK		(128)					/* FLI_OFFSETӦ */


#define SMC_CLOCK_CORR_PIT_reg				(0x0d)


#define SMSKR0						(0x54)	//Ƭѡ0ַĴ


#define SM_COLDSTART_TIMT_reg				(0x04)


#define SM_LISTEN_TIME_OUT_reg				(0x03)


#define SM_RESTART_TIMT_reg					(0x05)


#define SM_SCH_REC_PIT_reg					(0x0b)


#define SM_SYNC_EVAL_PIT_reg				(0x0e)


#define SOFT_APP_RESET						(0xeb90146f)


#define SOFT_RESET							(0x1)		/*λ*/

#define SOFT_SYS_RESET						(0xeb9090eb)


#define SPEED_SEL						 	(0x3e)


#define SPW0_RX_RAM_BASE			(0x2a004000)


#define SPW0_TX_RAM_BASE			(0x2a000000)


#define SPW1_RX_RAM_BASE			(0x2b004000)


#define SPW1_TX_RAM_BASE			(0x2b000000)


#define SPW2_BASE 						(0xA0070000)


#define SPW2_ERR							(0x1)


#define SPW2_RAMA_ERR					(0x4)	//spw2_twobits_err


#define SPW2_RX_MEM_BASE 				(0x2c004000)


#define SPW2_RX_RAM_BASE			(0x2c004000)


#define SPW2_RX_TWO_BITS_ERR_INT		(0x10)	/*spw2_rx_twobits_err*/


#define SPW2_TX_MEM_BASE 				(0x2c000000)


#define SPW2_TX_RAM_BASE			(0x2c000000)


#define SPW2_TX_TWO_BITS_ERR_INT		(0x08)	/*spw2_tx_twobits_err*/


#define SPW3_BASE						(0xA0080000)


#define SPW3_ERR							(0x2)


#define SPW3_RAMA_ERR					(0x8)	//spw3_twobits_err


#define SPW3_RX_MEM_BASE 				(0x2d004000)


#define SPW3_RX_RAM_BASE			(0x2d004000)


#define SPW3_RX_TWO_BITS_ERR_INT		(0x04)	/*spw3_rx_twobits_err*/


#define SPW3_TX_MEM_BASE 				(0x2d000000)


#define SPW3_TX_RAM_BASE			(0x2d000000)


#define SPW3_TX_TWO_BITS_ERR_INT		(0x02)	/*spw3_tx_twobits_err*/


#define SPW_BULK_EOP_TYPE_ADDR				(0x3C)	/*EOP*/


#define SPW_BULK_RX_BASE_ADDR				(0x34)	/*BULKģʽ£һPACKETڽRAMд洢ݵĻַ*/


#define SPW_BULK_RX_CNT_ADDR				(0x1C)	/*RX-BULKģʽ£ݵĸ*/


#define SPW_BULK_RX_END_ADDR				(0x38)	/*BULKģʽ£һPACKETڽRAMд洢ݵĽַ*/


#define SPW_BULK_RX_PACK_STA_ADDR			(0x20)	/*ǿRX-BULKģʽ£ݵĸ*/


#define SPW_BULK_TX_PACKET_CFG_ADDR			(0x18)	/*ǿģʽ£TXͰüĴ*/


#define SPW_CLR_INT_STATUS			(0x01)


#define SPW_CLR_ISR_STATUS_ADDR				(0x1C)	/*ж״̬Ĵ*/


#define SPW_CODEC_ADDR						(0x14)	/*״̬Ĵ*/


#define SPW_CONNECT_BIT				(0x06)


#define SPW_CTRL_ADDR						(0x04)	/*ƼĴ*/


#define SPW_DISCONNECT_BIT			(0x01)


#define SPW_DISCONNECT_ERR					(0x1)


#define SPW_EMEM_RX_BASE_ADDR				(0x88)	/*RX-EMEMģʽ£ýⲿ洢еĻַ*/


#define SPW_EMEM_RX_END_ADDR				(0x8C)	/*RX-EMEMģʽ£ýⲿ洢еĽַ*/


#define SPW_EMEM_TX_BASE_ADDR				(0x80)	/*TX-EMEMģʽ£÷ⲿ洢еĻַ*/


#define SPW_EMEM_TX_CNT_ADDR				(0x84)	/*TX-EMEMģʽ£÷ݵĸ*/


#define SPW_ENHANCE_CTRL_ADDR				(0x10)	/*ǿģʽüĴ*/


#define SPW_ERR_HEAD						(0xfffffff0)


#define SPW_ESC_ERR							(0x4)


#define SPW_FIFO_TX_EOP_ADDR				(0x14)	/*EOPüĴ*/


#define SPW_FIFO_TX_OVER_ERR				(0x0)


#define SPW_INQUIRE					(0x00)


#define SPW_INT						(0x01)


#define SPW_INT_STA_ADDR					(0x24)	/*ж״̬Ĵ*/


#define SPW_MEM_GAP						(0x1000)


#define SPW_MODE_ADDR						(0x0C)	/*ģʽüĴ*/


#define SPW_MODE_BULK				(0x02)


#define SPW_MODE_EMEM				(0x04)


#define SPW_MODE_FIFO				(0x01)


#define SPW_MODE_STACK				(0x03)


#define SPW_NUM						(4)


#define SPW_NUM_0					(0x00)


#define SPW_NUM_1					(0x01)


#define SPW_NUM_2					(0x02)


#define SPW_NUM_3					(0x03)


#define SPW_OTHER_ERR					(0x3)


#define SPW_PARITY_ERR						(0x2)


#define SPW_REG_0					(0xa0050000)


#define SPW_REG_1					(0xa0060000)


#define SPW_REG_2					(0xa0070000)


#define SPW_REG_3					(0xa0080000)


#define SPW_RFIFO_ADDR						(0x00)	/*FIFOĴ*/


#define SPW_RXRAM_A_ADDR					(0x40)	/*RXRAM A˿ڳĵַ*/


#define SPW_RXRAM_B_ADDR					(0x44)	/*RXRAM B˿ڳĵַ*/


#define SPW_RXRAM_EDAC_ERR_CLR_ADDR			(0x44)	/*RAM˿ڵ˫־*/


#define SPW_RX_CREDIT_ERR					(0x8)


#define SPW_RX_ERR							(0x0)


#define SPW_RX_NO_ERR						(0x0)


#define SPW_RX_TIMEOUT_HOLD_ADDR			(0x30)	/*ճʱĴ,Ϊ1us*/


#define SPW_RX_TIME_CODE_CFG_ADDR			(0x2C)	/*ʱĴ*/


#define SPW_TFIFO_ADDR						(0x00)	/*FIFOĴ*/


#define SPW_TIMEOUT_ERR						(0x9)


#define SPW_TIME_CODE_CFG_ADDR				(0x28)	/*ʱĴ*/


#define SPW_TWO_BITS_ERR_INT			(0xf<<1)	//b15531_twobits_err


#define SPW_TXBPS_100M				(100)


#define SPW_TXBPS_10M				(10)


#define SPW_TXBPS_133M				(133)


#define SPW_TXBPS_160M				(160)


#define SPW_TXBPS_200M				(200)


#define SPW_TXBPS_20M				(20)


#define SPW_TXBPS_266M				(266)


#define SPW_TXBPS_2M				(2)


#define SPW_TXBPS_400M				(400)


#define SPW_TXBPS_40M				(40)


#define SPW_TXBPS_4M				(4)


#define SPW_TXBPS_50M				(50)


#define SPW_TXBPS_66M				(66)


#define SPW_TXBPS_80M				(80)


#define SPW_TXBPS_8M				(8)


#define SPW_TXRAM_A_ADDR					(0x48)	/*TXRAM A˿ڳĵַ*/


#define SPW_TXRAM_B_ADDR					(0x4c)	/*TXRAM B˿ڳĵַ*/


#define SPW_TXRAM_EDAC_ERR_CLR_ADDR			(0x40)	/*RAM˿ڵ˫־*/


#define SPW_TX_CLK					(800)


#define SPW_TX_ERR							(0x1)


#define SPW_TX_RATE_ADDR					(0x08)	/*üĴ*/


#define SPW_TX_TIME_CODE_CFG_ADDR			(0x2C)	/*ʱĴ*/


#define SQUARE(x)           ((x)*(x))             /* ƽ                     */


#define SRAM_REG_BASE							(0x40200000)


#define SRAM_TWO_BITS_ERR_INT			(0x1<<12)	//sram_twobits_err


#define SREFR			 			(0x10)	//SDRAMˢ¼Ĵ	


#define STACK_CUR_ADDR					(0x100 * 4)		//ջǰַ


#define STACK_NOT_SUPPORT					(0)


#define STACK_PKT_CNT_ADDR				(0x101 * 4)		//ǰջЧpacke


#define STACK_RX_PKT_CNT				(5)


#define STACK_TX_PKT_CNT				(5)


#define START_RESET_REG                 (0x0003u)    /* 开始/复位寄存器(WR) */


#define STMG0R	 					(0x4)	//SDRAMʱĴ0


#define STMG1R	 					(0x8)	//SDRAMʱĴ1


#define SUBADDR_MEM( offset )           ( ABSUI_TO_VADDR( RT_MEM_ADDR_BASE + 4 * (offset) ) )


#define SUM_VALUE					(0xdeadbeef)


#define SVC_MODE_STACK_SIZE				(8*1024)


#define SVC_MODE_STACK_TOP			(MEM_SYS_STK_BASE & 0xfffffff0)


#define SYSDataBegin			(MEM_APP_DATA_USED_BASEADDR)	


#define SYSDataSize				(MEM_APP_DATA_USED_SIZE)


#define SYSFALSE				(0x0)


#define SYSHOOKMAXNUM						16


#define SYSLoadBegin			(MEM_BOOT_USED_BASEADDR)	


#define SYSLoadSize				(MEM_BOOT_USED_SIZE)


#define SYSProgBegin			(MEM_APP_PROG_USED_BASEADDR)	


#define SYSProgSize				(MEM_APP_PROG_USED_SIZE)


#define SYSStackBlockBegin		(MEM_SYS_STK_LOWBASE)	


#define SYSStackBlockSize		(MEM_SYS_STK_SIZE)


#define SYSTRUE					(0xeb90146f)


#define SYS_BOOT_RUN_INFO_BASEADDR		(BSP_RAM_BASE_ADDR+0xD200)


#define SYS_BOOT_RUN_INFO_SIZE			(1*1024)


#define SYS_BOOT_TRAP_INFO_BASEADDR		(BSP_RAM_BASE_ADDR+0xC400)


#define SYS_BOOT_TRAP_INFO_SIZE			(3*1024)


#define SYS_CLOCK  (0x0)//ϵͳʱ


#define SYS_CTRLPERIOD_DEVIATION_VALUE (16)


#define SYS_DISABLE							(0x0)


#define SYS_ENABLE							(0xeb90146f)


#define SYS_ERROR							(0x0)


#define SYS_FIRST_OBC_ACCORDANT_BIT		(4)	//ݱȶһ±־õַ


#define SYS_FIRST_OBC_ACCORDANT_VALUE		(0)	//ݱȶһ±־λ'1'Ϊһ£'0'Ϊһ


#define SYS_GPT_DATR	*(V_U32 *)0x3fff0604


#define SYS_IntEnableTask_DataCom   (0xeb)


#define SYS_LESS_COMMON_TRAP_INFO_RECORD_SIZE 		(4*1024)	


#define SYS_MAX_FLASH_Auto_Check_Size		(0x80)	/*һԼ32*4B,СΪsize,ֹһˢ¹п*/


#define SYS_MAX_FLASH_Repair_Read_Size  	(0x80)	/*һ޸32*4B*/


#define SYS_MAX_FLASH_Repair_Write_Size  	(0x08)	/*һ޸д2*4B*/


#define SYS_MAX_FLASH_SetSum_Read_Size  	(0x80)	/*һۼӺͶ32*4B*/


#define SYS_MAX_FLASH_SetSum_Write_Size  	(0x08)	/*һۼӺд2*4B*/


#define SYS_MAX_PERIOD_TIME_MS						(SYS_PERIOD_TIME_MS)


#define SYS_MAX_TICKNUM_PER_PERIOD				(SYS_MAX_PERIOD_TIME_MS/OS_TIME_TICKS)


#define SYS_MAX_TICK_INDEXNUM_PER_PERIOD	((SYS_MAX_TICKNUM_PER_PERIOD>>5)+1)


#define SYS_MODE_STACK_SIZE				(20*1024)


#define SYS_MODE_STACK_TOP			((SVC_MODE_STACK_TOP - SVC_MODE_STACK_SIZE) & 0xfffffff0)


#define SYS_NORFLASH_CONTROL_ADDR			(0xa00d0000)


#define SYS_NORFLASH_CONTROL_BIT			(0)


#define SYS_NORFLASH_DISABLE_VALUE			(0x0)


#define SYS_NORFLASH_ENABLE_VALUE			(0x1)


#define SYS_NORFLASH_STATUS_ADDR			(0xa00d0000)


#define SYS_NORFLASH_STATUS_BIT				(0)


#define SYS_NORF_ASK						(0x02)//   Y                   ѯ


#define SYS_NORF_DOUBLE_ERR					(0x08)//        Y           Y  norflashд̱ʾݳ˫


#define SYS_NORF_MODE_ERR					(0x0C)//        Y              βʧܣmode


#define SYS_NORF_NOTALIGN_ERR				(0x09)//        Y              βʧܣNORFSRAMַ


#define SYS_NORF_NOTINNORF_ERR				(0x0A)//        Y              βʧܣNorflashЧַռ


#define SYS_NORF_NOTINSRAM_ERR				(0x0B)//        Y              βʧܣSRAMЧַռ


#define SYS_NORF_OK							(0x07)//        Y           Y  Խ²


#define SYS_NORF_OPTNULL					(0x06)//             Y         ղ


#define SYS_NORF_OPT_ERR					(0x0D)//        Y              ǰָִУflashӦָ


#define SYS_NORF_READ						(0x00)//   Y    Y    Y      Y  


#define SYS_NORF_REFRESH					(0x04)//        Y    Y      Y  ˢnorflash


#define SYS_NORF_REPAIR						(0x05)//        Y    Y      Y  ޸norflash


#define SYS_NORF_SUM						(0x03)//   Y    Y    Y      Y  ۼӺͲд


#define SYS_NORF_WRITE						(0x01)//   Y    Y    Y      Y  д


#define SYS_NorFlash1_EndAddr 			NorFlash_DataEdacInSameSectorAddr


#define SYS_NorFlash1_StartAddr			(0x08000000)


#define SYS_NorFlash2_DieNum			(0x1)/*Ƭ*/


#define SYS_NorFlash2_DieSize			(0x01000000)


#define SYS_NorFlash2_EndAddr			(0x10000000)


#define SYS_NorFlash2_Size 				(0x04000000)


#define SYS_NorFlash2_StartAddr			(0x0c000000)


#define SYS_NorFlash_ADDAParam1_Base		(0x08140000)		/*ϵַ*/


#define SYS_NorFlash_ADDAParam2_Base		(0x08260000)		/*ϵַ*/


#define SYS_NorFlash_Data1_Base				(0x08140000)		/*ַ*/


#define SYS_NorFlash_Data1_Size				SYS_NorFlash_Data_Size	/*С*/


#define SYS_NorFlash_Data2_Base				(0x08260000)		/*ַ*/


#define SYS_NorFlash_Data2_Size				SYS_NorFlash_Data_Size	/*С*/


#define SYS_NorFlash_DataArea				(0x6A)/**/


#define SYS_NorFlash_DataArea_A				(0xAA)/**/


#define SYS_NorFlash_DataArea_B				(0x5A)/**/


#define SYS_NorFlash_DataIntervalSectorNum	((SYS_NorFlash_Data2_Base-SYS_NorFlash_Data1_Base)>>NorFlash_SectorSize_AddrBit_Num)


#define SYS_NorFlash_Data_Size				(0x00000000)		/*С*/


#define SYS_NorFlash_IllegalArea			(0xFFFFFFFF)/*Ƿnorflash*/


#define SYS_NorFlash_OtherArea				(0x78)/**/


#define SYS_NorFlash_Prog1_Base				(0x08040000)		/*ݳַ*/


#define SYS_NorFlash_Prog1_Size 			SYS_NorFlash_Prog_Size


#define SYS_NorFlash_Prog2_Base				(0x08160000)		/*ݳַ*/


#define SYS_NorFlash_Prog2_Size 			SYS_NorFlash_Prog_Size


#define SYS_NorFlash_ProgArea				(0x95)/**/


#define SYS_NorFlash_ProgArea_A				(0x55)/*ݳ*/


#define SYS_NorFlash_ProgArea_B				(0xA5)/*ݳ*/


#define SYS_NorFlash_ProgIntervalSectorNum	((SYS_NorFlash_Prog2_Base-SYS_NorFlash_Prog1_Base)>>NorFlash_SectorSize_AddrBit_Num)


#define SYS_NorFlash_ProgNum				(2) 				/*norflash洢ĳ,ȡֵ 1  2*/


#define SYS_NorFlash_Prog_Size				(0x100000)


#define SYS_NorFlash_RefreshData_Enable				(0)		/*0:ʾˢflash; 1:ʾˢflash*/


#define SYS_NorFlash_Repair_Buff_BaseAddr			(0x4017AC00)	/*norflash޸norflash޸ַ*/


#define SYS_NorFlash_Repair_Erase			(0x3)


#define SYS_NorFlash_Repair_EraseErr		(0x8)


#define SYS_NorFlash_Repair_ErrorInfo_BaseAddr		(0x405AF400)	/*norflash޸Ϣnorflash޸Ϣ¼ַ*/


#define SYS_NorFlash_Repair_ErrorInfo_Size			(0x8000)		/*norflash޸Ϣnorflash޸Ϣ¼ֽڴС*/


#define SYS_NorFlash_Repair_Init			(0x1)


#define SYS_NorFlash_Repair_OK				(0x0)


#define SYS_NorFlash_Repair_OtherErr		(0x9)


#define SYS_NorFlash_Repair_Read			(0x2)


#define SYS_NorFlash_Repair_ReadErr			(0x6)


#define SYS_NorFlash_Repair_Record			(0x5)


#define SYS_NorFlash_Repair_Write			(0x4)


#define SYS_NorFlash_Repair_WriteErr		(0x7)


#define SYS_NorFlash_SectorSize					(0x40000) /*256KB EDACһ64KB,ӦСΪ256KB*/


#define SYS_NorFlash_SectorSize_bit				(0x3FFFF)/*ÿڵַλΪ18bit*/


#define SYS_NorFlash_SetSum_Erase			(0x3)


#define SYS_NorFlash_SetSum_EraseErr		(0x8)


#define SYS_NorFlash_SetSum_Init			(0x1)


#define SYS_NorFlash_SetSum_OK				(0x0)


#define SYS_NorFlash_SetSum_OtherErr		(0x9)


#define SYS_NorFlash_SetSum_Read			(0x2)


#define SYS_NorFlash_SetSum_ReadErr			(0x6)


#define SYS_NorFlash_SetSum_Record			(0x5)


#define SYS_NorFlash_SetSum_Write			(0x4)


#define SYS_NorFlash_SetSum_WriteErr		(0x7)


#define SYS_NorFlash_TrapRecord_BaseAddr	(0x08280000) 		/*norflash¼λtrapϢĴ洢ַ*/


#define SYS_NorFlash_TrapRecord_Enable			(0)


#define SYS_NorFlash_TrapRecord_Size		(128*1024) 			/*norflash¼λtrapϢĴ洢ռС,Ĭһռ*/


#define SYS_OK								(0xeb90146f)


#define SYS_ProgOfNorFlash_SectorNum		(SYS_NorFlash_Prog1_Size>>NorFlash_SectorSize_AddrBit_Num)


#define SYS_RAM_BLOCK_BEGIN_A	(SYSTRI32_A_BASEADDR+SYSTRI32_EACHSIZE-SYS_RAM_BLOCK_SIZE)


#define SYS_RAM_BLOCK_BEGIN_B	(SYSTRI32_B_BASEADDR+SYSTRI32_EACHSIZE-SYS_RAM_BLOCK_SIZE)


#define SYS_RAM_BLOCK_BEGIN_C	(SYSTRI32_C_BASEADDR+SYSTRI32_EACHSIZE-SYS_RAM_BLOCK_SIZE)


#define SYS_RAM_BLOCK_SIZE 							(1*1024)


#define SYS_SCHEDULE_BASED_ON_TIME_TABLE	(1)


#define SYS_SCHED_MODE_NUM					(1)


#define SYS_SEU_TRAP_INFO_RECORD_SIZE 				(12*1024)


#define SYS_Self_JK_Flag					(0x0)


#define SYS_Self_Not_JK_Flag				(0xeb90146f)


#define SYS_TMR_CUTCLOCK_NUM (37)


#define SYS_TMR_CUTCLOCK_PERIOD (200)


#define SYS_TMR_DATACOMPARE_ADDR (0x401BAC00)


#define SYS_TMR_DATACOMPARE_SIZE (256*1024)


#define SYS_TMR_DATA_Region0			(0x401fac00)	/*the base address of the first area */


#define SYS_TMR_DATA_Region0_SIZE		(4*1024)		/*the size of the first area 4kB */


#define SYS_TMR_DATA_Region1			(SYS_TMR_DATA_Region0+SYS_TMR_DATA_Region0_SIZE+SYS_ISOLATION_SIZE) /*the base address of the second area*/


#define SYS_TMR_DATA_Region1_SIZE		(4*1024)		/*the size of the second area 4kB */


#define SYS_TMR_DATA_Region2			(SYS_TMR_DATA_Region1+SYS_TMR_DATA_Region1_SIZE+SYS_ISOLATION_SIZE) /*the base address of the third area */


#define SYS_TMR_DATA_Region2_SIZE		(4*1024)		/*the size of the third area 4kB */


#define SYS_TMR_DATA_Region3			(SYS_TMR_DATA_Region2+SYS_TMR_DATA_Region2_SIZE+SYS_ISOLATION_SIZE) /*the base address of the third area */


#define SYS_TMR_DATA_Region3_SIZE		(4*1024)	/*the size of the third area 4kB */


#define SYS_TMR_EXCHANGE_BYTE_TIME_US (15)//768k,1.3us*11=14.3us


#define SYS_TMR_EXCHANGE_EXTRA_TIME (1000)//۽ֽڣͳһ1000us


#define SYS_TMR_EXCHANGE_WORD   (10)//ϵͳֽ һΪ0xeb90146f,ڶΪۼӺֿͣʼΪң


#define SYS_TMR_TASK_NUM  (2)


#define SYS_TMR_UART_BAUD (768000)


#define SYS_TRI32_BASEADDR					(MEM_TRI32_USED_BASEADDR)		/*ȡ׵ַ*/

#define Sgn3f(x)        (Sgn3(x) )/* V2.00ɾúܺϲSgn3 */


#define Sinx(x)         (sin((float64)(x))                )


#define Sqrtx(x)        (sqrt((float64)(x))               )


#define TASKINFOTM_WIDTH			(5)


#define TASK_DONT_RUN						(0x55555555)/*ֹ*/


#define TASK_IS_OVER						(0xBBBBBBBB)/*״̬Ϊн*/


#define TASK_RUN_ALLOW						(0x0)/*ֹ*/


#define TASK_RUN_IN_ALL						(0x0)		/*ȫ*/


#define TASK_RUN_IN_PART					(0xeb90146f)/*񽵼*/

#define TASK_START_RUN						(0xAAAAAAAA)/*״̬Ϊʼ*/


#define TBE_ERR								(0x2)


#define TC_RESET							(0x4)		/*ңظλ*/


#define TEN_US   (0x2)   // 10 us 


#define TEST_MODE_0_REG                 (0x0010u)


#define TEST_MODE_1_REG                 (0x0011u)


#define TEST_MODE_2_REG                 (0x0012u)


#define TEST_MODE_3_REG                 (0x0013u)


#define TEST_MODE_4_REG                 (0x0014u)


#define TEST_MODE_5_REG                 (0x0015u)


#define TEST_MODE_6_REG                 (0x0016u)


#define TEST_MODE_7_REG                 (0x0017u)


#define TF_FULL			0x200


#define TIMER_RELOAD_MODE 						(0x01)


#define TIMER_SCALER 			1 /*ʱĵ,λusSOC2008ʱһƵ*/


#define TIMER_SINGLE_MODE 						(0x00)


#define TIME_D2L(a)           ((llong64)((float64)(a) * (float64)(ONE_SECOND))) /* 浮点星时(s)转换为整型星时(星时计数器当量) */


#define TIME_EDGE_DOWN        (0u)      /* 星时基准信号边沿选择 下降沿             */


#define TIME_EDGE_UP          (1u)      /* 星时基准信号边沿选择 上升沿             */


#define TIME_L2D(a)           ((float64)(a) / (float64)(ONE_SECOND))            /* 整型星时(星时计数器当量)转换为浮点星时(s) */


#define TIME_LOCK_ACCE        (4u)      /* 时钟锁存通道选择 加计同步信号锁存星时   */


#define TIME_LOCK_GPS0        (2u)      /* 时钟锁存通道选择 GPS0信号锁存星时计数值 */


#define TIME_LOCK_GPS1        (3u)      /* 时钟锁存通道选择 GPS1信号锁存星时计数值 */


#define TIME_LOCK_NOW         (0u)      /* 时钟锁存通道选择 当前星时锁存计数值     */


#define TIME_LOCK_PD          (1u)      /* 时钟锁存通道选择 控制周期锁存计数值     */


#define TIME_LOCK_STS         (5u)      /* 时钟锁存通道选择 星敏同步信号锁存星时   */


#define TIME_TAG_REG                    (0x0005u)    /* 时间标记寄存器(RD/WR) */


#define TLSF_SIGNATURE	(0x2A59FA59)			/* TLSFʶ */


#define TM0_cnt 14//ֶθ


#define TM10_cnt 15//ֶθ


#define TM11_cnt 15//ֶθ


#define TM12_cnt 1//ֶθ


#define TM13_cnt 1//ֶθ


#define TM14_cnt 1//ֶθ


#define TM15_cnt 1//ֶθ


#define TM16_cnt 24//ֶθ


#define TM17_cnt 24//ֶθ


#define TM18_cnt 15//ֶθ


#define TM19_cnt 15//ֶθ


#define TM1_cnt 15//ֶθ


#define TM2_cnt 1//ֶθ


#define TM3_cnt 1//ֶθ	


#define TM4_cnt 24//ֶθ	


#define TM5_cnt 17//ֶθ


#define TM6_cnt 16//ֶθ


#define TM7_cnt 18//ֶθ


#define TM8_cnt 14//ֶθ


#define TM9_cnt 14//ֶθ


#define TMAX                (0.136)           /* ʱ         */


#define TMIN                (0.03)            /* Сʱ    */


#define TMIN2               (0.02)            /* Сʱ    */


#define TMR_CLOCK1_STATUS (19)


#define TMR_CLOCK2_STATUS (20)


#define TMR_UART1_NUM (5)


#define TMR_UART2_NUM (6)


#define TMTYPE_E            (0x0u)            /* Ѳ      */


#define TMTYPE_IMUDEV_TEST  (0x2u)            /*         */


#define TMTYPE_M            (0x1u)            /* Ѳ        */


#define TR32BlockBegin			(MEM_TRI32_USED_BASEADDR) 


#define TR32BlockSize			(MEM_TRI32_USED_SIZE)


#define TRANSPARENT_CLOCK_reg_HIGH			(0x22)


#define TRANSPARENT_CLOCK_reg_LOW			(0x23)


#define TRANS_EN		0x2


#define TRANS_INT_EN	0x8


#define TRAP_GET_INT_NEST_CNT 		0x0D 			/*ȡжǶײ*/


#define TRAP_GET_SLICE_INT_NO		0x12			/*ȡʱƬж*/


#define TRAP_GET_TRAP_SYS 			0x0C 			/*ȡϢ*/


#define TRAP_INT_CONNECT 			0x02			/*жϹҽ*/


#define TRAP_INT_DISCONNECT 		0x03			/*жɾ*/


#define TRAP_NULL					0x00			/*Ч*/


#define TRAP_SWITCH 				0x01			/*л*/


#define TRAP_TASK_DELETE_SELF	 	0x0F 			/*ɾ*/


#define TRAP_TASK_START_SELF	 	0x0E 			/**/


#define TRUE					(1)			/* ߼ֵ,ȷ */


#define TS_EMPTY		0x2


#define TTE_BASE 0x70010000


#define TTE_SOFT_RESET		 		 		(0x52)


#define TTTableSendbase 0x400


#define TT_FRAME_ID_HEAD					(0xabadbabe)


#define TT_MAC_LABEL						(0x2A)


#define TT_MAC_LABEL_reg					(0x2a)


#define TT_RECV_RAM_START_ADDR				(0x69000000)


#define TT_SEND_RAM_START_ADDR				(0x68000000)//ÿռ32*2kռ


#define TT_SERVICE							(0x1)


#define TT_VLINK_NUM						(12)


#define TT_partition_state_reg				(0x72)


#define TT_recv_almost_full_flag			(0x4d)


#define TT_recv_partition_base_addr			(0x3C)


#define TT_recv_rd_frame_done_reg			(0x38)


#define TT_recv_vl_id_reg					(0x4c)


#define TT_recv_vl_length_reg				(0x4d)


#define TT_recv_vl_num_reg					(0x38)


#define TT_recv_vl_partition_addr			(0x4d)


#define TT_send_partition_addr_reg			(0x33)


#define TT_send_partition_base_addr			(0x3A)


#define TT_send_vl_id_reg					(0x32)


#define TT_send_vl_length_reg				(0x34)


#define TT_send_wr_done_reg					(0x36)


#define TWOBITERROR 2


#define TWOBITS_ERR_ADDR			(0xd0)	//˫ַĴ


#define TWOBITS_ERR_DATA	 	 	(0xd4)	//˫ݼĴ


#define TWOBITS_ERR_EDAC	 	 	(0xd8)	//˫УĴ


#define TWOPI64  6.283185307179586


#define TX_FIFO_EOP						(0x03)


#define TX_FIFO_TXFLUSH_BIT				(0x03)


#define TX_PKT128_BASE					(0xFFF)			


#define TX_PKT128_BYTE_CNT				(1024)


#define TX_PKT128_END_TYPE				(0)


#define TX_PKT128_TIME_GAP				(5000)


#define TX_PKT1_BASE					(0x120)			


#define TX_PKT1_BYTE_CNT				(32)


#define TX_PKT1_END_TYPE				(0)


#define TX_PKT1_TIME_GAP				(5000)


#define TX_PKT2_BASE					(0x220)			


#define TX_PKT2_BYTE_CNT				(64)


#define TX_PKT2_END_TYPE				(0)


#define TX_PKT2_TIME_GAP				(5000)


#define TX_PKT3_BASE					(0x320)			


#define TX_PKT3_BYTE_CNT				(128)


#define TX_PKT3_END_TYPE				(0)


#define TX_PKT3_TIME_GAP				(5000)


#define TX_PKT4_BASE					(0x420)			


#define TX_PKT4_BYTE_CNT				(256)


#define TX_PKT4_END_TYPE				(0)


#define TX_PKT4_TIME_GAP				(5000)


#define TX_PKT5_BASE					(0x620)			


#define TX_PKT5_BYTE_CNT				(512)


#define TX_PKT5_END_TYPE				(0)


#define TX_PKT5_TIME_GAP				(5000)


#define TX_PKT6_BASE					(0xFFF)			


#define TX_PKT6_BYTE_CNT				(1024)


#define TX_PKT6_END_TYPE				(0)


#define TX_PKT7_BASE					(0xFFF)			


#define TYPE_reg							(0x20)


#define Tanx(x)         (tan((float64)(x))                )


#define Test_MaxRunTimeAddr 0x40122200  


#define TmCnt 20   //ңָ


#define TrapErr								(0x0)


#define TrapTrue							(0xeb90146f)


#define UARTPORT			0


#define UART_DLH (0x04)


#define UART_DLL (0x00)


#define UART_FCR (0x08)


#define UART_IER (0x04)


#define UART_IIR (0x08)


#define UART_LCR (0x0C)


#define UART_LSR (0x14)


#define UART_MCR (0x10)


#define UART_MSR (0x18)


#define UART_RBR (0x00) // Ĵ


#define UART_THR (0x00)


#define UI08_BIT_CLR(uv, bp)            ((uv) = (((unint32)(uv)) & ((0x01u << (bp)) ^ MASK_LO08)))


#define UI08_BIT_GET(uv, bp)            ((unint08)((((unint32)(uv)) >> (bp)) & 0x01u))


#define UI08_BIT_SET(uv, bp)            ((uv) = (((unint32)(uv)) | ((0x01u << (bp)) & MASK_LO08)))


#define UI08_MAKE04(h4, l4)             ((unint08)((((unint32)((h4) & MASK_LO04)) << 4u) | ((unint32)((l4) & MASK_LO04))))


#define UI08_MAKEUC16_B( dst, src )         { (dst)[0] = (src)[0];  (dst)[1] = (src)[1];  }


#define UI08_MAKEUC16_L( dst, src )         { (dst)[0] = (src)[1];  (dst)[1] = (src)[0]; }


#define UI08_MAKEUC24_B( dst, src )         { (dst)[0] = (src)[1];  (dst)[1] = (src)[2]; (dst)[2] = (src)[3]; }


#define UI08_MAKEUC24_L( dst, src )         { (dst)[0] = (src)[2];  (dst)[1] = (src)[1]; (dst)[2] = (src)[0]; }


#define UI08_MAKEUC32_B( dst, src )         { (dst)[0] = (src)[0];  (dst)[1] = (src)[1]; (dst)[2] = (src)[2];  (dst)[3] = (src)[3]; }


#define UI08_MAKEUC32_L( dst, src )         { (dst)[0] = (src)[3];  (dst)[1] = (src)[2]; (dst)[2] = (src)[1];  (dst)[3] = (src)[0]; }


#define UI08_MAKEUC64_B( dst, src )         { (dst)[0] = (src)[0];  (dst)[1] = (src)[1]; (dst)[2] = (src)[2];  (dst)[3] = (src)[3];  \
                                              (dst)[4] = (src)[4];  (dst)[5] = (src)[5]; (dst)[6] = (src)[6];  (dst)[7] = (src)[7]; }


#define UI08_MAKEUC64_L( dst, src )         { (dst)[0] = (src)[7];  (dst)[1] = (src)[6]; (dst)[2] = (src)[5];  (dst)[3] = (src)[4];  \
                                              (dst)[4] = (src)[3];  (dst)[5] = (src)[2]; (dst)[6] = (src)[1];  (dst)[7] = (src)[0]; }


#define UI16_BIT_CLR(uv, bp)            ((uv) = (((unint32)(uv)) & ((0x01u << (bp)) ^ MASK_LO16)))


#define UI16_BIT_GET(uv, bp)            ((unint16)((((unint32)(uv)) >> (bp)) & 0x01u))


#define UI16_BIT_GET1(uv, bp)           ((unint16)((((unint32)(uv)) >> (bp)) & 0x01))


#define UI16_BIT_GET2(uv, bp)           ((unint16)((((unint32)(uv)) >> (bp)) & 0x03))


#define UI16_BIT_GET5(uv, bp)           ((unint16)((((unint32)(uv)) >> (bp)) & 0x01Fu))


#define UI16_BIT_SET(uv, bp)            ((uv) = (((unint32)(uv)) | ((0x01u << (bp)) & MASK_LO16)))


#define UI16_BIT_SET1(uv, bp, bv)       ((uv) = (unint16)((((unint32)(uv)) & ((0x01 << (bp)) ^ (MASK_LO16))) | ((bv) << (bp))))


#define UI16_BIT_SET2(uv, bp, bv)       ((uv) = (unint16)((((unint32)(uv)) & ((0x03 << (bp)) ^ (MASK_LO16))) | ((bv) << (bp))))


#define UI16_BIT_SET4(uv, bp, bv)       ((uv) = (unint16)((((unint32)(uv)) & ((0x0F << (bp)) ^ (MASK_LO16))) | ((bv) << (bp))))


#define UI16_HI8(ui16)                  ((unint08)((((unint32)(ui16)) >> 8u) & MASK_LO08))


#define UI16_LO8(ui16)                  ((unint08)((((unint32)(ui16))      ) & MASK_LO08))


#define UI16_MAKE(hi8, lo8)             ((unint16)((((unint32)((hi8) & MASK_LO08)) <<  8u) | ((unint32)((lo8) & MASK_LO08))))


#define UI16_MAKE_HI12(hi8, lo8)        ((unint16)((((unint32)(hi8)) << 4u) | (((unint32)(lo8)) >> 4u)))


#define UI32_BIT_CLR(uv, bp)            (BIT_CLR((uv), (bp), MASK_ALL8F))


#define UI32_BIT_GET(uv, bp)            (BIT_GET((uv), (bp)))


#define UI32_BIT_GET1(uv, bp)           (((uv) >> (bp)) & 0x001u)


#define UI32_BIT_GET10(uv, bp)          (((uv) >> (bp)) & 0x3FFu)


#define UI32_BIT_GET12(uv, bp)          (((uv) >> (bp)) & 0xFFFu)


#define UI32_BIT_GET2(uv, bp)           (((uv) >> (bp)) & 0x003u)


#define UI32_BIT_GET20(uv, bp)          (((uv) >> (bp)) & 0xFFFFFu)


#define UI32_BIT_GET23(uv, bp)          (((uv) >> (bp)) & 0x7FFFFFu)


#define UI32_BIT_GET3(uv, bp)           (((uv) >> (bp)) & 0x007u)


#define UI32_BIT_GET4(uv, bp)           (((uv) >> (bp)) & 0x00Fu)


#define UI32_BIT_GET5(uv, bp)           (((uv) >> (bp)) & 0x01Fu)


#define UI32_BIT_GET6(uv, bp)           (((uv) >> (bp)) & 0x03Fu)


#define UI32_BIT_GET7(uv, bp)           (((uv) >> (bp)) & 0x07Fu)


#define UI32_BIT_GET8(uv, bp)           (((uv) >> (bp)) & 0x0FFu)


#define UI32_BIT_GETN(uv, bp, n)        (((uv) >> (bp)) & UI32_BIT_MASKN((n)))


#define UI32_BIT_MASKN(n)               (MASK_ALL8F >> (32u - (n)))


#define UI32_BIT_SET(uv, bp)            (BIT_SET((uv), (bp), MASK_ALL8F))


#define UI32_BIT_SET1(uv, bp, bv)       ((uv) = ((uv) & ((0x01u << (bp)) ^ (MASK_ALL8F))) | ((bv) << (bp)))


#define UI32_BIT_SET12(uv, bp, bv)      ((uv) = ((uv) & ((0xFFFu << (bp)) ^ (MASK_ALL8F))) | ((bv) << (bp)))


#define UI32_BIT_SET2(uv, bp, bv)       ((uv) = ((uv) & ((0x03u << (bp)) ^ (MASK_ALL8F))) | ((bv) << (bp)))


#define UI32_BIT_SET20(uv, bp, bv)      ((uv) = ((uv) & ((0xFFFFFu << (bp)) ^ (MASK_ALL8F))) | ((bv) << (bp)))


#define UI32_BIT_SET3(uv, bp, bv)       ((uv) = ((uv) & ((0x07u << (bp)) ^ (MASK_ALL8F))) | ((bv) << (bp)))


#define UI32_BIT_SET4(uv, bp, bv)       ((uv) = ((uv) & ((0x0Fu << (bp)) ^ (MASK_ALL8F))) | ((bv) << (bp)))


#define UI32_BIT_SET5(uv, bp, bv)       ((uv) = ((uv) & ((0x1Fu << (bp)) ^ (MASK_ALL8F))) | ((bv) << (bp)))


#define UI32_BIT_SET6(uv, bp, bv)       ((uv) = ((uv) & ((0x3Fu << (bp)) ^ (MASK_ALL8F))) | ((bv) << (bp)))


#define UI32_BIT_SET7(uv, bp, bv)       ((uv) = ((uv) & ((0x7Fu << (bp)) ^ (MASK_ALL8F))) | ((bv) << (bp)))


#define UI32_BIT_SET8(uv, bp, bv)       ((uv) = ((uv) & ((0xFFu << (bp)) ^ (MASK_ALL8F))) | ((bv) << (bp)))


#define UI32_BYTE_CLR(uv, hl)           ((uv) = ((uv) & ((0xFFu << ((3u - (hl)) << 3u)) ^ (MASK_ALL8F))))


#define UI32_BYTE_GET(uv, hl)           (((uv) >> ((3u - (hl)) << 3u)) & 0xFFu)


#define UI32_BYTE_SET(uv, hl, byv)      ((uv) = ((uv) & ((0xFFu << ((3u - (hl)) << 3u)) ^ (MASK_ALL8F))) | ((byv) << ((3u - (hl)) << 3u)))


#define UI32_BYTE_SET_HIHI8(ui08, val)  (((ui08) & 0x00FFFFFFu) | ((val) << 24u))


#define UI32_BYTE_SET_HILO8(ui08, val)  (((ui08) & 0xFF00FFFFu) | ((val) << 16u))


#define UI32_BYTE_SET_LOHI8(ui08, val)  (((ui08) & 0xFFFF00FFu) | ((val) <<  8u))


#define UI32_BYTE_SET_LOLO8(ui08, val)  (((ui08) & 0xFFFFFF00u) | ((val)      ))


#define UI32_HI16(ui32)                 ((unint16)(((ui32) >> 16u) & MASK_LO16))


#define UI32_HIHI8(ui32)                ((unint08)(((ui32) >> 24u) & MASK_LO08))


#define UI32_HIHI8_SET(val32, ui08)     ((val32) = ((val32) & 0x00FFFFFFu) | (((ui08) & MASK_LO08) << 24u))


#define UI32_HILO8(ui32)                ((unint08)(((ui32) >> 16u) & MASK_LO08))


#define UI32_HILO8_SET(val32, ui08)     ((val32) = ((val32) & 0xFF00FFFFu) | (((ui08) & MASK_LO08) << 16u))


#define UI32_LO16(ui32)                 ((unint16)(((ui32)       ) & MASK_LO16))


#define UI32_LOHI8(ui32)                ((unint08)(((ui32) >>  8u) & MASK_LO08))


#define UI32_LOHI8_SET(val32, ui08)     ((val32) = ((val32) & 0xFFFF00FFu) | (((ui08) & MASK_LO08) <<  8u))


#define UI32_LOLO8(ui32)                ((unint08)(((ui32)       ) & MASK_LO08))


#define UI32_LOLO8_SET(val32, ui08)     ((val32) = ((val32) & 0xFFFFFF00u) | (((ui08) & MASK_LO08)       ))


#define UI32_MAKE(hh8, hl8, lh8, ll8)   ((((unint32)((hh8) & MASK_LO08)) << 24u) | (((unint32)((hl8) & MASK_LO08)) << 16u) | (((unint32)((lh8) & MASK_LO08)) << 8u) | ((unint32)((ll8) & MASK_LO08)))


#define UI32_MAKE16(h16, l16)           ((((unint32)((h16) & MASK_LO16)) << 16u) | ((unint32)((l16) & MASK_LO16)))


#define UI64_HI32(ui64)                 ((unint32)(((ui64) >> 32u) & MASK_ALL8F))


#define UI64_HIHI16(ui64)               ((unint16)(((ui64) >> 48u) & MASK_LO16))


#define UI64_HILO16(ui64)               ((unint16)(((ui64) >> 32u) & MASK_LO16))


#define UI64_LO32(ui64)                 ((unint32)(((ui64)       ) & MASK_ALL8F))


#define UI64_LOHI16(ui64)               ((unint16)(((ui64) >> 16u) & MASK_LO16))


#define UI64_LOLO16(ui64)               ((unint16)(((ui64)       ) & MASK_LO16))


#define UI64_MAKE16(hh, hl, lh, ll)     ((((ulong64)((hh) & MASK_LO16)) << 48u) | (((ulong64)((hl) & MASK_LO16)) << 32u) | (((ulong64)((lh) & MASK_LO16)) << 16u) | ((ulong64)((ll) & MASK_LO16)))


#define UI64_MAKE32(hh, ll)             ((((ulong64)((hh) & MASK_ALL8F)) << 32u) | ((ulong64)((ll) & MASK_ALL8F)))


#define UI8_HI4(ui8)                    ((unint08)((((unint32)(ui8)) >> 4u) & MASK_LO04))


#define UI8_LO4(ui8)                    ((unint08)((((unint32)(ui8))      ) & MASK_LO04))


#define ULONG64_MAX     0u            /* Ч */


#define ULONG64_MIN     0u          /* Ч */


#define UN08_TO_DBL(x)                  ((float64)(x))


#define UN08_TO_UN32_ID       (0x58u)          /* 将8位整数转换为32位整型数 */


#define UN16_TO_DBL(x)                  ((float64)(x))


#define UN16_TO_FLT(x)                  ((float32)(x))


#define UN32_TO_DBL(x)                  ((float64)(x))


#define UN32_TO_FLT(x)                  ((float32)(x))


#define UN32_TO_SI08_ID       (0x50u)          /* 将32位整数转换为8位有符号整型数 */


#define UN32_TO_SI16_ID       (0x51u)          /* 将32位整数转换为16位有符号整型数 */


#define UN32_TO_UN08_ID       (0x56u)          /* 将32位整数转换为8位无符号整型数 */


#define UN64_TO_SI32_ID       (0x40u)          /* 将64位长整型数转换为32位有符号数 */


#define UND_MODE_STACK_SIZE				(8*1024)


#define UND_MODE_STACK_TOP			((SYS_MODE_STACK_TOP - SYS_MODE_STACK_SIZE) & 0xfffffff0)


#define UNINT08_MAX         UCHAR_MAX   /*  255 */


#define UNINT08_MIN         0u          /*  0 */


#define UNINT16_MAX         USHRT_MAX   /*  65535 */


#define UNINT16_MIN         0u          /*  0 */


#define UNINT32_MAX         UINT_MAX    /*  4294967295 */


#define UNINT32_MIN         0u          /*  0 */


#define USED_BLOCK	(0x0)			/* 0:ѷ */


#define USE_NEW_PAR_CONTEXT			(0x03)		/*·*/


#define USE_NEW_TASK_CONTEXT		(0x05)		/**/


#define USE_OLD_PAR_CONTEXT			(0x04)		/*ɷ*/


#define USR_EMIFRAM_REFRESHwordSize			USR_RAMREFRESHwordSize


#define USR_RAMREFRESHwordSize		(0x400)


#define USR_SDRAM_REFRESHwordSize			USR_RAMREFRESHwordSize


#define USR_SRAM_REFRESHwordSize			USR_RAMREFRESHwordSize


#define V3Copy( qDst, qSrc )        { *(qDst) = *(qSrc); *((qDst)+1) = *((qSrc)+1); *((qDst)+2) = *((qSrc)+2);  }


#define WAIT_FOREVER		(-1)		/* ʱֵ,õȴ */


#define WDT_RESET_TIME				(4000000) 


#define WHEELNUM 4


#define WORKING_OBC_ADDR			(0xA00D0050)


#define WORKING_OBC_SRL_BITSNUM			(2)	//0:A;	1:B;	3:C	


#define WRMEM_CONFIG_REG				(0x0000)		//RAMռ


#define WR_EDAC_ADDR_BYPASS			(0xe8) 	//EDACд·ַĴ


#define WR_EDAC_DATA_BYPASS			(0xec) 	//EDACд·ݼĴ


#define WR_WS_CFG_REG					(0x0020)		//RAMռȴʱ


#define XWTRI32_A_BASEADDR					(APPTRI32_A_BASEADDR+APPTRI32_EACHSIZE+SYS_ISOLATION_SIZE)	/*OBDHȡһ׵ַ*/

#define XWTRI32_B_BASEADDR					(APPTRI32_B_BASEADDR+APPTRI32_EACHSIZE+SYS_ISOLATION_SIZE)


#define XWTRI32_C_BASEADDR					(APPTRI32_C_BASEADDR+APPTRI32_EACHSIZE+SYS_ISOLATION_SIZE)


#define _AD_Param_Init_HANDLE_FUNC_			Drv_AD_CHIP_Param_Init


#define _CPH_R_Version_					"1.03(0.0s)"


#define _DA_Param_Init_HANDLE_FUNC_			Drv_DA_CHIP_Param_Init


#define _XH_R_Version_					"1.04(0.0v)"


#define __ADD_DATA_NORFLASH__			(0)		/*Ƿڶflash,Ϊ1,Ϊ0*/


#define __ADKB_ENABLE__						(0)


#define __ALL_TIMER_NUM__			(10)


#define __APB_TIMER_NUM__			(8)


#define __ComNum__	2


#define __DAKB_ENABLE__						(0)


#define __DATA_END__			LITTLE_ENDIAN


#define __GPIO_NUMBER__				(16)


#define __OSINFOREC_H__											
#include "UTILStd.h"


#define __OS_CONSOLE_EN__ 				0							/*̨ʹ(1)ֹ(0)*/


#define __OS_MEM_USED_COMPUTE__ 		0							/*ṩڴ״̬ӹ*/


#define __OS_MQ_EN__ 					0							/*Ϣʹ(1)ֹ(0)*/


#define __OS_RRSCHED_EN__				1							/*ͬȼȴ(1)ΪʱƬת(0)ΪFIFO*/


#define __OS_SCHED_REC_EN__ 			0							/*Ϣ¼ʹ(1)ֹ(0)*/


#define __OS_SEM_EN__ 					0							/*źʹ(1)ֹ(0)*/


#define __OS_STACK_REC_EN__ 			0							/*ջϢ鹦ʹ(1)ֹ(0)*/


#define __OS_TIME_EN__ 					1							/*ʱ/ȡԼʱʹ(1)ֹ(0)*/


#define __OS_TIME_JDE_EN__				0							/* JDE ʹ*/


#define __UART_NUM__				(2)


#define __USE_FUDANWEI_SMALLSECTOR__	(0)		/*Ƿʹø΢norflashС,ʹΪ1,ʹΪ0*/


#define __USE_REPAIR_BUFFER__						(1)				/*SRAMǷnorflash޸norflash޸߼ʹ,Ϊ1,Ϊ0*/


#define __USE_REPAIR_ERRORINFO_BUFFER__ 			(0)


#define check_even 							(1<<3)|(0x1<<4)	/*żУ*/


#define check_odd							(1<<3)|(0x0<<4)	/*У*/


#define container_of(address, type, field) \
            ((type *)((char *)(address) - offsetof(type, field)))


#define data_5_bit							(0x0)			/*5λλ*/


#define data_6_bit							(0x1)			/*6λλ*/


#define data_7_bit							(0x2)			/*7λλ*/


#define data_8_bit							(0x3)			/*8λλ*/


#define flag 0


#define freq 400


#define hash_find(pos, table, userkey, type_of)     \
    do {                                            \
            list_for_each_entry(pos, type_of, &table[hash_key(table, userkey)], list) \
            {                                       \
                if (pos->key == userkey) {break;}   \
            }                                       \
            if ((&pos->list) == (&table[hash_key(table, userkey)])) {pos = 0;}        \
        } while (0)


#define hash_init(node) INIT_LIST_HEAD(&node)


#define hash_insert(table, cell)  list_add_tail(&(cell.list), &(table[hash_key(table, cell.key)]))


#define hash_key(table, userkey)    (userkey % ARRAY_SIZE(table))


#define inline __inline


#define list_entry(ptr, type, member) \
                container_of(ptr, type, member)


#define list_for_each(pos, head) \
    for (pos = (head)->next;  pos != (head); pos = pos->next)


#define list_for_each_entry(pos, typeof_pos, head, member) \
    for (pos = list_entry((head)->next, typeof_pos, member); \
         &pos->member != (head); \
         pos = list_entry(pos->member.next, typeof_pos, member))


#define list_for_each_entry_continue(pos, typeof_pos, head, member) \
    for (pos = list_entry(pos->member.next, typeof_pos, member); \
         &pos->member != (head); \
         pos = list_entry(pos->member.next, typeof_pos, member))


#define list_for_each_entry_reverse(pos, typeof_pos, head, member) \
    for (pos = list_entry((head)->prev, typeof_pos, member); \
         &pos->member != (head); \
         pos = list_entry(pos->member.prev, typeof_pos, member))


#define list_for_each_entry_safe(pos, typeof_pos, n, typeof_n, head, member) \
                    for (pos = list_entry((head)->next, typeof_pos, member), \
                         n = list_entry(pos->member.next, typeof_pos, member); \
                         &pos->member != (head); \
                         pos = n, n = list_entry(n->member.next, typeof_n, member))


#define list_for_each_prev(pos, head) \
    for (pos = (head)->prev;  pos != (head); pos = pos->prev)


#define list_for_each_safe(pos, n, head) \
    for (pos = (head)->next, n = pos->next; pos != (head); pos = n, n = pos->next)


#define list_prepare_entry(pos, typeof_pos, head, member) \
        ((pos) ? : list_entry(head, typeof_pos, member))


#define monaddr 0xA00D0050


#define monbit 0xc


#define no_check							(0x0<<3)		/*У*/


#define norwpaddr 0xA00D0000


#define norwpbit 0


#define offsetof(type, field)    ((int)&((type *)0)->field)


#define outWdtaddr 0xA00D0000


#define outWdtbit 0x8


#define poweronaddr 0xA00D0050


#define poweronbit 0xd


#define progdestaddr 0x40018000


#define progsize 0x00080000


#define progsrcaddr1 0x08100000


#define progsrcaddr2 0x08300000


#define progsum1 0xdeadbeef


#define progsum2 0xdeadbeef


#define r16(addr)				(*(volatile U16 *)(addr))


#define r32(addr)				(*(volatile U32 *)(addr))


#define r8(addr)				(*(volatile U8 *)(addr))


#define rcvr_1_int							(0x0)			/*FIFO1ֽ*/


#define rcvr_full_int						(0x3)			/*FIFO  2 ֽ*/


#define rcvr_half_half_int					(0x1)			/*FIFO 1/4*/


#define rcvr_half_int						(0x2)			/*FIFO 1/2*/


#define readSPW(spwBaseAddr,offsetAddr)			(Bsp_IO_Read((spwBaseAddr) + (offsetAddr)))


#define readTTE(addr)						(Bsp_IO_Read(TTE_BASE + ((addr) << 2)))


#define softResetaddr 0xA00D0000


#define softResetbit 0xb


#define speed_sel							(0x3e)


#define stop_1_5_bit						(0x1<<2)		/*1.5ֹͣλ*/


#define stop_1_bit							(0x0<<2)		/*1ֹͣλ*/


#define stop_2_bit							(0x1<<2)		/*2ֹͣλ*/


#define tcResetAddr 0x40017A00


#define tcResetBit 0x0


#define tet_1_int							(0x1)			/*FIFO  2 ֽ*/


#define tet_empty_int						(0x0)			/*մ*/


#define tet_half_half_int					(0x2)			/*FIFO 1/4*/


#define tet_half_int						(0x3)			/*FIFO 1/2*/


#define uart_ref_clk						(0<<0)			/* uart_ref_clk*/


#define uart_ref_clk_div8					(0x1<<0)		/* uart_ref_clk/8*/


#define uploadcfgaddr 0x08580000


#define uploadmode 0x55555555


#define w16(addr, val)			(*(volatile U16 *)(addr)= (val))


#define w32(addr, val)			(*(volatile U32 *)(addr)= (val))


#define w8(addr, val)			(*(volatile U8 *)(addr)= (val))


#define writeSPW(spwBaseAddr,offsetAddr, val)	Bsp_IO_Write(((spwBaseAddr) + (offsetAddr)), (U32)(val))


#define writeTTE(addr, val)					Bsp_IO_Write((TTE_BASE + ((addr) << 2)), (val))


/* --- 自动提取的枚举定义 (ENUMS) --- */

typedef enum sem_b_state	/* ֵźֵ */
	{
		SEM_EMPTY,				/* 0: ź */
		SEM_FULL				/* 1: ź */
	} SEM_B_STATE;

typedef enum sem_type		/* ź */
	{
		OS_SEM_BINARY,			/* 0: ֵź */
		OS_SEM_MUTEX,			/* 1: ź */
		OS_SEM_COUNT			/* 2: ź */
	} SEM_TYPE;

#endif // AUTO_GENERATED_COMMON_H

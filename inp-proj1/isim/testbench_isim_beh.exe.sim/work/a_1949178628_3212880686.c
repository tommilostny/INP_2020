/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/tommilostny/FITkit-svn/apps/INP/inp-proj1/tb.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3499444699;

unsigned char ieee_p_2592010699_sub_374109322130769762_503743352(char *, unsigned char );
char *ieee_p_3499444699_sub_17544701978858283880_3536714472(char *, char *, int , int );


static void work_a_1949178628_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    int64 t3;
    int64 t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;

LAB0:    xsi_set_current_line(56, ng0);

LAB3:    t1 = (t0 + 2128U);
    t2 = *((char **)t1);
    t3 = *((int64 *)t2);
    t4 = (t3 / 2);
    t1 = (t0 + 1192U);
    t5 = *((char **)t1);
    t6 = *((unsigned char *)t5);
    t7 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t6);
    t1 = (t0 + 4024);
    t8 = (t1 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = t7;
    xsi_driver_first_trans_delta(t1, 0U, 1, t4);
    t12 = (t0 + 4024);
    xsi_driver_intertial_reject(t12, t4, t4);

LAB2:    t13 = (t0 + 3912);
    *((int *)t13) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_1949178628_3212880686_p_1(char *t0)
{
    char t3[16];
    char *t1;
    char *t2;
    char *t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    char *t10;
    unsigned char t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    unsigned char t17;
    unsigned char t18;
    int t19;
    int t20;
    int t21;
    unsigned int t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;

LAB0:    t1 = (t0 + 3592U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(61, ng0);
    t2 = (t0 + 2368U);
    t4 = *((char **)t2);
    t5 = (0 - 0);
    t6 = (t5 * 1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t2 = (t4 + t8);
    t9 = *((unsigned char *)t2);
    t10 = ieee_p_3499444699_sub_17544701978858283880_3536714472(IEEE_P_3499444699, t3, ((int)(t9)), 8);
    t11 = (8U != 8U);
    if (t11 == 1)
        goto LAB4;

LAB5:    t12 = (t0 + 4088);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t10, 8U);
    xsi_driver_first_trans_fast(t12);
    xsi_set_current_line(62, ng0);
    t2 = (t0 + 2248U);
    t4 = *((char **)t2);
    t5 = (0 - 0);
    t6 = (t5 * 1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t2 = (t4 + t8);
    t9 = *((unsigned char *)t2);
    t10 = ieee_p_3499444699_sub_17544701978858283880_3536714472(IEEE_P_3499444699, t3, ((int)(t9)), 8);
    t11 = (8U != 8U);
    if (t11 == 1)
        goto LAB6;

LAB7:    t12 = (t0 + 4152);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t10, 8U);
    xsi_driver_first_trans_fast(t12);
    xsi_set_current_line(63, ng0);

LAB10:    t2 = (t0 + 3928);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB11;

LAB1:    return;
LAB4:    xsi_size_not_matching(8U, 8U, 0);
    goto LAB5;

LAB6:    xsi_size_not_matching(8U, 8U, 0);
    goto LAB7;

LAB8:    t10 = (t0 + 3928);
    *((int *)t10) = 0;
    xsi_set_current_line(64, ng0);
    t2 = (t0 + 4216);
    t4 = (t2 + 56U);
    t10 = *((char **)t4);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(65, ng0);
    t2 = (t0 + 7021);
    *((int *)t2) = 0;
    t4 = (t0 + 7025);
    *((int *)t4) = 7;
    t5 = 0;
    t19 = 7;

LAB15:    if (t5 <= t19)
        goto LAB16;

LAB18:    xsi_set_current_line(70, ng0);

LAB33:    *((char **)t1) = &&LAB34;
    goto LAB1;

LAB9:    t4 = (t0 + 1152U);
    t11 = xsi_signal_has_event(t4);
    if (t11 == 1)
        goto LAB12;

LAB13:    t9 = (unsigned char)0;

LAB14:    if (t9 == 1)
        goto LAB8;
    else
        goto LAB10;

LAB11:    goto LAB9;

LAB12:    t10 = (t0 + 1192U);
    t12 = *((char **)t10);
    t17 = *((unsigned char *)t12);
    t18 = (t17 == (unsigned char)3);
    t9 = t18;
    goto LAB14;

LAB16:    xsi_set_current_line(66, ng0);
    t10 = (t0 + 2368U);
    t12 = *((char **)t10);
    t10 = (t0 + 7021);
    t20 = xsi_vhdl_mod(*((int *)t10), 2);
    t21 = (t20 - 0);
    t6 = (t21 * 1);
    xsi_vhdl_check_range_of_index(0, 1, 1, t20);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t13 = (t12 + t8);
    t9 = *((unsigned char *)t13);
    t14 = ieee_p_3499444699_sub_17544701978858283880_3536714472(IEEE_P_3499444699, t3, ((int)(t9)), 8);
    t15 = (t3 + 12U);
    t22 = *((unsigned int *)t15);
    t22 = (t22 * 1U);
    t11 = (8U != t22);
    if (t11 == 1)
        goto LAB19;

LAB20:    t16 = (t0 + 4088);
    t23 = (t16 + 56U);
    t24 = *((char **)t23);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    memcpy(t26, t14, 8U);
    xsi_driver_first_trans_fast(t16);
    xsi_set_current_line(67, ng0);
    t2 = (t0 + 2248U);
    t4 = *((char **)t2);
    t2 = (t0 + 7021);
    t20 = *((int *)t2);
    t21 = (t20 - 0);
    t6 = (t21 * 1);
    xsi_vhdl_check_range_of_index(0, 7, 1, *((int *)t2));
    t7 = (1U * t6);
    t8 = (0 + t7);
    t10 = (t4 + t8);
    t9 = *((unsigned char *)t10);
    t12 = ieee_p_3499444699_sub_17544701978858283880_3536714472(IEEE_P_3499444699, t3, ((int)(t9)), 8);
    t13 = (t3 + 12U);
    t22 = *((unsigned int *)t13);
    t22 = (t22 * 1U);
    t11 = (8U != t22);
    if (t11 == 1)
        goto LAB21;

LAB22:    t14 = (t0 + 4152);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t23 = (t16 + 56U);
    t24 = *((char **)t23);
    memcpy(t24, t12, 8U);
    xsi_driver_first_trans_fast(t14);
    xsi_set_current_line(68, ng0);

LAB25:    t2 = (t0 + 3944);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB26;
    goto LAB1;

LAB17:    t2 = (t0 + 7021);
    t5 = *((int *)t2);
    t4 = (t0 + 7025);
    t19 = *((int *)t4);
    if (t5 == t19)
        goto LAB18;

LAB30:    t20 = (t5 + 1);
    t5 = t20;
    t10 = (t0 + 7021);
    *((int *)t10) = t5;
    goto LAB15;

LAB19:    xsi_size_not_matching(8U, t22, 0);
    goto LAB20;

LAB21:    xsi_size_not_matching(8U, t22, 0);
    goto LAB22;

LAB23:    t10 = (t0 + 3944);
    *((int *)t10) = 0;
    goto LAB17;

LAB24:    t4 = (t0 + 1152U);
    t11 = xsi_signal_has_event(t4);
    if (t11 == 1)
        goto LAB27;

LAB28:    t9 = (unsigned char)0;

LAB29:    if (t9 == 1)
        goto LAB23;
    else
        goto LAB25;

LAB26:    goto LAB24;

LAB27:    t10 = (t0 + 1192U);
    t12 = *((char **)t10);
    t17 = *((unsigned char *)t12);
    t18 = (t17 == (unsigned char)3);
    t9 = t18;
    goto LAB29;

LAB31:    goto LAB2;

LAB32:    goto LAB31;

LAB34:    goto LAB32;

}


extern void work_a_1949178628_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1949178628_3212880686_p_0,(void *)work_a_1949178628_3212880686_p_1};
	xsi_register_didat("work_a_1949178628_3212880686", "isim/testbench_isim_beh.exe.sim/work/a_1949178628_3212880686.didat");
	xsi_register_executes(pe);
}

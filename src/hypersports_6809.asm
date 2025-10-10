
;	map(0x1000, 0x10bf).ram().share(m_spriteram);
;	map(0x10c0, 0x10ff).ram().share(m_scroll);
;	map(0x1400, 0x1400).w("watchdog", FUNC(watchdog_timer_device::reset_w));
;	map(0x1480, 0x1487).w("mainlatch", FUNC(ls259_device::write_d0));
;	map(0x1500, 0x1500).w("soundlatch", FUNC(generic_latch_8_device::write));
;	map(0x1600, 0x1600).portr("DSW2");
;	map(0x1680, 0x1680).portr("SYSTEM");
;	map(0x1683, 0x1683).portr("DSW1");
;	map(0x2000, 0x27ff).ram().w(FUNC(base_state::videoram_w)).share(m_videoram);
;	map(0x2800, 0x2fff).ram().w(FUNC(base_state::colorram_w)).share(m_colorram);
;	map(0x3000, 0x37ff).ram();
;	map(0x3800, 0x3fff).ram().share("nvram");
;	map(0x4000, 0xffff).rom();
;	ls259_device &mainlatch(LS259(config, "mainlatch")); // F2
;	mainlatch.q_out_cb<0>().set(FUNC(base_state::flip_screen_set));
;	mainlatch.q_out_cb<1>().set(m_soundbrd, FUNC(trackfld_audio_device::sh_irqtrigger_w)); // SOUND ON
;	mainlatch.q_out_cb<2>().set_nop(); // END
;	mainlatch.q_out_cb<3>().set(FUNC(base_state::coin_counter_w<0>)); // COIN 1
;	mainlatch.q_out_cb<4>().set(FUNC(base_state::coin_counter_w<1>)); // COIN 2
;	mainlatch.q_out_cb<5>().set_nop(); // SA
;	mainlatch.q_out_cb<7>().set(FUNC(base_state::irq_mask_w)); // INT

; page $38xx

game_playing_00 = $00
dsw2_copy_0d = $0d
event_pointer_1c = $1c
event_pointer_1e = $1e
event_sub_state_28 = $28
event_sub_state_2a = $2a
current_level_68 = $68
current_event_69 = $69
chrono_hundredth_second_71 = $71
chrono_second_72 = $72
speed_msb_b0 = $b0
nb_long_horse_turns_ef = $ef
watchdog_1400 = $1400
sound_queue_3340 = $3340
current_level_3068 = $3068

dsw2_1600 = $1600
system_1680 = $1680
in0_1681 = $1681
in1_1682 = $1682
dsw1_1683 = $1683
sprite_ram_1000 = $1000
scroll_registers_10c0 = $10c0
flip_screen_set_1480 = $1480
sh_irqtrigger_w_1481 = $1481
coin_counter_1_w_1483 = $1483
coin_counter_1_w_1484 = $1484
irq_mask_w_1487 = $1487
audio_register_w_1500 = $1500
video_ram_2000 = $2000
color_ram_2800 = $2800

;	PORT_START("SYSTEM")
;	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_COIN1 )
;	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_COIN2 )
;	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_COIN3 )
;	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_START1 )
;	PORT_BIT( 0x10, IP_ACTIVE_LOW, IPT_START2 )
;	PORT_BIT( 0x20, IP_ACTIVE_LOW, IPT_COIN4 )
;	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_UNKNOWN )
;	PORT_BIT( 0x80, IP_ACTIVE_LOW, IPT_UNKNOWN )
;
;	PORT_START("P1_P2")
;	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_BUTTON3 ) PORT_PLAYER(1)
;	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_BUTTON2 ) PORT_PLAYER(1)
;	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_BUTTON1 ) PORT_PLAYER(1)
;	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_START3 )
;	PORT_BIT( 0x10, IP_ACTIVE_LOW, IPT_BUTTON3 ) PORT_PLAYER(2)
;	PORT_BIT( 0x20, IP_ACTIVE_LOW, IPT_BUTTON2 ) PORT_PLAYER(2)
;	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_BUTTON1 ) PORT_PLAYER(2)
;	PORT_BIT( 0x80, IP_ACTIVE_LOW, IPT_UNKNOWN )
;
;	PORT_START("P3_P4")
;	PORT_BIT( 0x01, IP_ACTIVE_LOW, IPT_BUTTON3  ) PORT_PLAYER(3) //PORT_COCKTAIL  These were commented out
;	PORT_BIT( 0x02, IP_ACTIVE_LOW, IPT_BUTTON2  ) PORT_PLAYER(3) //PORT_COCKTAIL  before the system changed.
;	PORT_BIT( 0x04, IP_ACTIVE_LOW, IPT_BUTTON1  ) PORT_PLAYER(3) //PORT_COCKTAIL  Why?
;	PORT_BIT( 0x08, IP_ACTIVE_LOW, IPT_START4 )
;	PORT_BIT( 0x10, IP_ACTIVE_LOW, IPT_BUTTON3  ) PORT_PLAYER(4) //PORT_COCKTAIL
;	PORT_BIT( 0x20, IP_ACTIVE_LOW, IPT_BUTTON2  ) PORT_PLAYER(4) //PORT_COCKTAIL
;	PORT_BIT( 0x40, IP_ACTIVE_LOW, IPT_BUTTON1  ) PORT_PLAYER(4) //PORT_COCKTAIL
;	PORT_BIT( 0x80, IP_ACTIVE_LOW, IPT_UNKNOWN )
;
;	PORT_START("DSW1")
;	KONAMI_COINAGE_LOC(DEF_STR( Free_Play ), "No Coin B", SW1)
;	// "No Coin B" = coins produce sound, but no effect on coin counter
;
;	PORT_START("DSW2")
;	PORT_DIPNAME( 0x01, 0x01, "After Last Event" ) PORT_DIPLOCATION("SW2:1")
;	PORT_DIPSETTING(    0x01, "Game Over" )
;	PORT_DIPSETTING(    0x00, "Game Continues" )
;	PORT_DIPNAME( 0x02, 0x00, DEF_STR( Cabinet ) ) PORT_DIPLOCATION("SW2:2")
;	PORT_DIPSETTING(    0x00, DEF_STR( Upright ) )
;	PORT_DIPSETTING(    0x02, DEF_STR( Cocktail ) )
;	PORT_DIPNAME( 0x04, 0x00, DEF_STR( Demo_Sounds ) ) PORT_DIPLOCATION("SW2:3")
;	PORT_DIPSETTING(    0x04, DEF_STR( Off ) )
;	PORT_DIPSETTING(    0x00, DEF_STR( On ) )
;	PORT_DIPNAME( 0x08, 0x08, "World Records" ) PORT_DIPLOCATION("SW2:4")
;	PORT_DIPSETTING(    0x08, "Don't Erase" )
;	PORT_DIPSETTING(    0x00, "Erase on Reset" )
;	PORT_DIPNAME( 0xf0, 0x40, DEF_STR( Difficulty ) ) PORT_DIPLOCATION("SW2:5,6,7,8")
;	PORT_DIPSETTING(    0xf0, "Easy 1" )
;	PORT_DIPSETTING(    0xe0, "Easy 2" )
;	PORT_DIPSETTING(    0xd0, "Easy 3" )
;	PORT_DIPSETTING(    0xc0, "Easy 4" )
;	PORT_DIPSETTING(    0xb0, "Normal 1" )
;	PORT_DIPSETTING(    0xa0, "Normal 2" )
;	PORT_DIPSETTING(    0x90, "Normal 3" )
;	PORT_DIPSETTING(    0x80, "Normal 4" )
;	PORT_DIPSETTING(    0x70, "Normal 5" )
;	PORT_DIPSETTING(    0x60, "Normal 6" )
;	PORT_DIPSETTING(    0x50, "Normal 7" )
;	PORT_DIPSETTING(    0x40, "Normal 8" )
;	PORT_DIPSETTING(    0x30, "Difficult 1" )
;	PORT_DIPSETTING(    0x20, "Difficult 2" )
;	PORT_DIPSETTING(    0x10, "Difficult 3" )
;	PORT_DIPSETTING(    0x00, "Difficult 4" )




reset_4000:
4000: 7F 36 05       CLR    irq_mask_w_1487
4003: 10 CE 15 02    LDS    #$3780
4007: 86 18          LDA    #$30
4009: 1F 03          TFR    A,DP
400B: 7F 3C A8       CLR    flip_screen_set_1480
400E: 8E A8 22       LDX    #$2000
4011: 86 9A          LDA    #$18
; clear video ram/set attribute
4013: 5F             CLRB
4014: E7 AB 8A 82    STB    $0800,X		; [video_address]
4018: A7 A8          STA    ,X+			; [video_address]
401A: B7 9C 28       STA    watchdog_1400
401D: 8C A0 88       CMPX   #$2800
4020: 26 D0          BNE    $4014
4022: 86 83          LDA    #$01
4024: 8E 12 82       LDX    #$3000
4027: 6F A8          CLR    ,X+
4029: B7 9C 88       STA    watchdog_1400
402C: 8C 10 88       CMPX   #$3800
402F: 26 D4          BNE    $4027
4031: 8E 92 82       LDX    #$1000
4034: 6F A2          CLR    ,X+
4036: B7 96 28       STA    watchdog_1400
4039: 8C 9C 88       CMPX   #watchdog_1400
403C: 26 DE          BNE    $4034
403E: 4F             CLRA
403F: 5F             CLRB
4040: 12             NOP
4041: 12             NOP
4042: 12             NOP
4043: 12             NOP
4044: 12             NOP
4045: 12             NOP
4046: 12             NOP
4047: 12             NOP
4048: 12             NOP
4049: 12             NOP
404A: 12             NOP
404B: 12             NOP
404C: B7 3C 88       STA    watchdog_1400
404F: 4A             DECA
4050: 26 CC          BNE    $4040
4052: 5A             DECB
4053: 26 C9          BNE    $4040
4055: 8E B1 82       LDX    #$3300
4058: CC D7 77       LDD    #$FFFF
405B: ED A9          STD    ,X++
405D: 8C BB C8       CMPX   #sound_queue_3340
4060: 26 DB          BNE    $405B
4062: 8E B1 22       LDX    #$3300
4065: 9F 9E          STX    event_pointer_1c
4067: 9F 36          STX    event_pointer_1e
4069: 8E BB C8       LDX    #sound_queue_3340
406C: 9F 14          STX    $3C
406E: 9F B6          STX    $3E
4070: B6 34 01       LDA    dsw1_1683
4073: 43             COMA
4074: 97 2E          STA    $0C
4076: B6 94 28       LDA    dsw2_1600
4079: 43             COMA
407A: 97 85          STA    dsw2_copy_0d
407C: 85 2A          BITA   #$02
407E: 27 8A          BEQ    $4082
4080: 0C 38          INC    $1A
4082: 84 72          ANDA   #$F0
4084: 44             LSRA
4085: 44             LSRA
4086: 44             LSRA
4087: 44             LSRA
4088: 97 26          STA    $0E
408A: 96 84          LDA    $0C
408C: 84 27          ANDA   #$0F
408E: 48             ASLA
408F: 8E ED 62       LDX    #$CF40
4092: EC 04          LDD    A,X
4094: DD 2A          STD    $08
4096: 96 8E          LDA    $0C
4098: 84 D8          ANDA   #$F0
409A: 44             LSRA
409B: 44             LSRA
409C: 44             LSRA
409D: 8E 47 E8       LDX    #$CF60
40A0: EC A4          LDD    A,X
40A2: DD 88          STD    $0A
40A4: 96 2F          LDA    dsw2_copy_0d
40A6: 85 8A          BITA   #$08
40A8: 10 27 88 D9    LBEQ   $40FD
40AC: 8E 10 88       LDX    #$3800
40AF: CE ED A2       LDU    #$CF80
40B2: 86 85          LDA    #$07
40B4: 97 62          STA    $40
40B6: 86 81          LDA    #$03
40B8: 97 69          STA    $41
40BA: 86 94          LDA    #$1C
40BC: 97 6A          STA    $42
40BE: 86 8B          LDA    #$03
40C0: 97 61          STA    $43
40C2: 6F 02          CLR    ,X+
40C4: C6 20          LDB    #$02
40C6: A6 46          LDA    ,U
40C8: 44             LSRA
40C9: 44             LSRA
40CA: 44             LSRA
40CB: 44             LSRA
40CC: A7 A8          STA    ,X+
40CE: A6 48          LDA    ,U+
40D0: 84 2D          ANDA   #$0F
40D2: A7 02          STA    ,X+
40D4: 5A             DECB
40D5: 26 6D          BNE    $40C6
40D7: 96 6A          LDA    $42
40D9: A7 08          STA    ,X+
40DB: A7 A8          STA    ,X+
40DD: A7 08          STA    ,X+
40DF: B7 36 22       STA    watchdog_1400
40E2: 0A C3          DEC    $41
40E4: 0C 60          INC    $42
40E6: 0A C1          DEC    $43
40E8: 26 F0          BNE    $40C2
40EA: 30 80          LEAX   $8,X
40EC: 0A 68          DEC    $40
40EE: 26 4E          BNE    $40B6
40F0: 8E 1A 64       LDX    #$38E6
40F3: CC 35 F7       LDD    #$17D5
40F6: DD CA          STD    $48
40F8: CC 28 A3       LDD    #$002B
40FB: 20 22          BRA    $4107
40FD: 8E B1 F8       LDX    #$3970
4100: C6 9C          LDB    #$BE
4102: D7 CB          STB    $49
4104: CC 22 A9       LDD    #$002B
4107: 6F A8          CLR    ,X+
4109: A7 08          STA    ,X+
410B: 6F A8          CLR    ,X+
410D: E7 08          STB    ,X+
410F: E7 A2          STB    ,X+
4111: E7 02          STB    ,X+
4113: 0A 6A          DEC    $48
4115: 26 83          BNE    $4118
4117: 4F             CLRA
4118: 0A 61          DEC    $49
411A: 26 63          BNE    $4107
411C: 96 25          LDA    dsw2_copy_0d
411E: 84 80          ANDA   #$08
4120: 27 32          BEQ    $4132
4122: B6 94 A3       LDA    in0_1681
4125: 43             COMA
4126: 84 D7          ANDA   #$55
4128: 81 7D          CMPA   #$55
412A: 26 8E          BNE    $4132
412C: 86 2C          LDA    #$04
412E: 97 A8          STA    $20
4130: 20 5A          BRA    $41AA
4132: 8E A2 22       LDX    #$2000
4135: CC 92 92       LDD    #$1010
4138: 6F A1 80 88    CLR    $0800,X		;  [video_address]
413C: 6F A1 80 89    CLR    $0801,X		;  [video_address]
4140: ED A3          STD    ,X++		;  [video_address_word]
4142: B7 96 22       STA    watchdog_1400
4145: 8C AA 82       CMPX   #$2800
4148: 26 C6          BNE    $4138
414A: FC B7 28       LDD    $3F00
414D: 10 83 89 20    CMPD   #$0102
4151: 26 94          BNE    $4169
4153: 8E 1D 32       LDX    #$3F10
4156: CE BD A8       LDU    #$3F80
4159: C6 DF          LDB    #$57
415B: A6 A8          LDA    ,X+
415D: B7 9C 88       STA    watchdog_1400
4160: A1 E2          CMPA   ,U+
4162: 26 87          BNE    $4169
4164: 5A             DECB
4165: 26 76          BNE    $415B
4167: 20 2E          BRA    $416F
4169: 7F B7 88       CLR    $3F00
416C: 7F 17 89       CLR    $3F01
416F: 8E ED 88       LDX    #$CFAA
4172: FC BD 22       LDD    $3F00
4175: 10 83 83 2A    CMPD   #$0102
4179: 26 8B          BNE    $417E
417B: 8E E7 E8       LDX    #$CFC0
417E: CE AC 27       LDU    #$2405
4181: 86 94          LDA    #$16
4183: 97 6A          STA    $48
; loop to write "QUALIFY DIP SW"
4185: A6 02          LDA    ,X+
4187: 80 18          SUBA   #$30
4189: B7 9C 88       STA    watchdog_1400
418C: BD 6A A4       JSR    write_char_and_move_cursor_422c
418F: 0A 6A          DEC    $48
4191: 26 70          BNE    $4185
4193: 4F             CLRA
4194: 5F             CLRB
4195: B7 96 82       STA    watchdog_1400
4198: 12             NOP
4199: 12             NOP
419A: 12             NOP
419B: 12             NOP
419C: 12             NOP
419D: 12             NOP
419E: 12             NOP
419F: 12             NOP
41A0: 12             NOP
41A1: 12             NOP
41A2: 12             NOP
41A3: 12             NOP
41A4: 4A             DECA
41A5: 26 6C          BNE    $4195
41A7: 5A             DECB
41A8: 26 C3          BNE    $4195
41AA: 86 89          LDA    #$01
41AC: B7 3C 0F       STA    irq_mask_w_1487
41AF: 1C CD          ANDCC  #$EF
master_mainloop_41b1:
41B1: 9E 9C          LDX    event_pointer_1e
41B3: EC A6          LDD    ,X
41B5: 48             ASLA
41B6: 25 7B          BCS    master_mainloop_41b1
41B8: 10 8E 77 77    LDY    #$FFFF
41BC: 10 AF 09       STY    ,X++
41BF: 8C 11 62       CMPX   #sound_queue_3340
41C2: 26 81          BNE    $41C7
41C4: 8E 11 82       LDX    #$3300
41C7: 9F 36          STX    event_pointer_1e
41C9: 8E 47 B8       LDX    #event_table_cf30
41CC: AD BE          JSR    [A,X]		; [jump_table]
41CE: 20 69          BRA    master_mainloop_41b1

reset_display_41d0:
41D0: 7F 36 05       CLR    irq_mask_w_1487
41D3: 8E 14 22       LDX    #$3600
41D6: CC 82 D0       LDD    #$00F8
41D9: ED 09          STD    ,X++
41DB: ED A9          STD    ,X++
41DD: 8C BE 00       CMPX   #$3688
41E0: 26 D5          BNE    $41D9
41E2: 8E B4 E2       LDX    #$36C0
41E5: 5F             CLRB
41E6: ED 03          STD    ,X++
41E8: ED A9          STD    ,X++
41EA: 8C BF 28       CMPX   #$3700
41ED: 26 7F          BNE    $41E6
41EF: 8E 02 22       LDX    #$2000
41F2: 86 8A          LDA    #$08
41F4: 97 62          STA    $40
41F6: 0F C3          CLR    $41
41F8: 86 38          LDA    #$10
41FA: 6F 01 20 28    CLR    $0800,X			;  [video_address]
41FE: A7 08          STA    ,X+			;  [video_address]
4200: 0A 63          DEC    $41
4202: 26 74          BNE    $41FA
4204: 0A 62          DEC    $40
4206: 26 70          BNE    $41FA
4208: 86 29          LDA    #$01
420A: B7 9C AF       STA    irq_mask_w_1487
420D: 39             RTS

420E: D7 19          STB    $91
4210: 39             RTS

4211: 58             ASLB
4212: 8E 4D CB       LDX    #$CFE9
4215: AE 07          LDX    B,X
4217: EE A9          LDU    ,X++
4219: E6 08          LDB    ,X+
421B: C1 17          CMPB   #$3F
421D: 27 84          BEQ    $422B
421F: 96 B3          LDA    $91
4221: A7 4B 8A 22    STA    $0800,U					;  [video_address]
4225: C0 B2          SUBB   #$30
4227: E7 E8          STB    ,U+					;  [video_address]
4229: 20 66          BRA    $4219
422B: 39             RTS

write_char_and_move_cursor_422c:
422C: 5F             CLRB
422D: E7 41 80 22    STB    $0800,U					;  [video_address]
4231: A7 42          STA    ,U+					;  [video_address]
4233: 39             RTS

4234: CE 07 47       LDU    #$25C5
4237: 0F 6B          CLR    $43
4239: 96 38          LDA    speed_msb_b0
423B: C6 22          LDB    #$0A
423D: 3D             MUL
423E: DB 39          ADDB   $B1
4240: C1 33          CMPB   #$11
4242: 25 86          BCS    $4248
4244: C6 33          LDB    #$11
4246: 0C C1          INC    $43
4248: D7 69          STB    $41
424A: D7 CA          STB    $42
424C: 27 25          BEQ    $425B
424E: CC 87 22       LDD    #$0F00
4251: E7 4B 8A 22    STB    $0800,U					;  [video_address]
4255: A7 42          STA    ,U+					;  [video_address]
4257: 0A 69          DEC    $41
4259: 26 7E          BNE    $4251
425B: 96 6B          LDA    $43
425D: 26 94          BNE    $427B
425F: 8E ED FB       LDX    #$CFD9
4262: 5F             CLRB
4263: 96 90          LDA    $B2
4265: A1 02          CMPA   ,X+
4267: 25 2B          BCS    $426C
4269: 5C             INCB
426A: 20 71          BRA    $4265
426C: 8E E7 55       LDX    #$CFDD
426F: A6 A7          LDA    B,X
4271: 27 8A          BEQ    $427B
4273: 6F EB 2A 82    CLR    $0800,U					;  [video_address]
4277: A7 E8          STA    ,U+					;  [video_address]
4279: 0C CA          INC    $42
427B: 86 39          LDA    #$11
427D: 90 CA          SUBA   $42
427F: 27 2D          BEQ    $4290
4281: 97 C0          STA    $42
4283: CC 29 22       LDD    #$0B00
4286: E7 4B 20 28    STB    $0800,U					;  [video_address]
428A: A7 48          STA    ,U+					;  [video_address]
428C: 0A 6A          DEC    $42
428E: 26 7E          BNE    $4286
4290: 33 63          LEAU   $1,U
4292: 96 32          LDA    speed_msb_b0
4294: 8D B4          BSR    write_char_and_move_cursor_422c
4296: 96 33          LDA    $B1
4298: 8D BA          BSR    write_char_and_move_cursor_422c
429A: 96 3A          LDA    $B2
429C: 8D A6          BSR    write_char_and_move_cursor_422c
429E: 96 3B          LDA    $B3
42A0: 20 A8          BRA    write_char_and_move_cursor_422c
42A2: DE 61          LDU    $E3
42A4: 96 E6          LDA    $C4
42A6: C6 8E          LDB    #$0C
42A8: D7 6F          STB    $47
42AA: BD D9 12       JSR    $513A
42AD: 97 CE          STA    $46
42AF: 1F BA          TFR    B,A
42B1: D6 C5          LDB    $47
42B3: BD 60 0F       JSR    $422D
42B6: 96 C4          LDA    $46
42B8: BD 6A A5       JSR    $422D
42BB: 86 D3          LDA    #$FB
42BD: 7E CA A5       JMP    $422D

draw_chrono_42c0:
42C0: C6 02          LDB    #$20
42C2: B6 94 A2       LDA    system_1680
42C5: 84 A2          ANDA   #$20
42C7: 27 2A          BEQ    $42CB
42C9: C6 C8          LDB    #$40
42CB: 8E 06 FD       LDX    #$2ED5	
42CE: E7 09          STB    ,X++		; [video_address]
42D0: E7 A2          STB    ,X+			; [video_address]
42D2: E7 03          STB    ,X++		; [video_address]
42D4: E7 A2          STB    ,X+			; [video_address]
42D6: E7 06          STB    ,X			; [video_address]
42D8: 8E 07 9D       LDX    #$2F15
42DB: E7 A9          STB    ,X++		; [video_address]
42DD: E7 08          STB    ,X+         ; [video_address]
42DF: E7 A3          STB    ,X++        ; [video_address]
42E1: E7 02          STB    ,X+         ; [video_address]
42E3: E7 A6          STB    ,X          ; [video_address]
42E5: 8E A4 57       LDX    #$26D5
42E8: CE 0F 9D       LDU    #$2715
42EB: 96 58          LDA    $70
42ED: 48             ASLA
42EE: A7 09          STA    ,X++		; [video_address]
42F0: 4C             INCA
42F1: A7 43          STA    ,U++		; [video_address]
42F3: 96 53          LDA    chrono_hundredth_second_71
42F5: 84 72          ANDA   #$F0
42F7: 44             LSRA
42F8: 44             LSRA
42F9: 44             LSRA
42FA: A7 08          STA    ,X+		; [video_address]
42FC: 4C             INCA
42FD: A7 48          STA    ,U+		; [video_address]
42FF: 96 53          LDA    chrono_hundredth_second_71
4301: 84 8D          ANDA   #$0F
4303: 48             ASLA
4304: A7 A3          STA    ,X++	; [video_address]
4306: 4C             INCA
4307: A7 E9          STA    ,U++	; [video_address]
4309: 96 FA          LDA    chrono_second_72
430B: 84 D8          ANDA   #$F0
430D: 44             LSRA
430E: 44             LSRA
430F: 44             LSRA
4310: A7 A2          STA    ,X+		; [video_address]
4312: 4C             INCA
4313: A7 E2          STA    ,U+		; [video_address]
4315: 96 F0          LDA    chrono_second_72
4317: 84 27          ANDA   #$0F
4319: 48             ASLA
431A: A7 0C          STA    ,X		; [video_address]
431C: 4C             INCA
431D: A7 4C          STA    ,U		; [video_address]
431F: 39             RTS

4320: 96 22          LDA    game_playing_00
4322: 26 83          BNE    $4325
4324: 39             RTS

4325: 8E B1 52       LDX    #$33D0
4328: CE 0E CC       LDU    #$2644
432B: 86 2C          LDA    #$04
432D: 97 C8          STA    $40
432F: 0F 63          CLR    $41
4331: A6 06          LDA    ,X
4333: 10 27 22 FD    LBEQ   $43B6
4337: 85 08          BITA   #$20
4339: 10 26 88 52    LBNE   $43B7
433D: 84 98          ANDA   #$10
433F: 27 21          BEQ    $4344
4341: 5F             CLRB
4342: 20 8B          BRA    $434D
4344: 10 8E 4D 67    LDY    #$CFE5
4348: A6 AC          LDA    ,X
434A: 4A             DECA
434B: E6 8E          LDB    A,Y
434D: D7 FD          STB    $75
434F: A6 A6          LDA    ,X
4351: 84 8D          ANDA   #$0F
4353: BD 60 0F       JSR    $422D
4356: 86 A2          LDA    #$20
4358: BD 6A A5       JSR    $422D
435B: 33 69          LEAU   $1,U
435D: 10 8E BB 42    LDY    #$3360
4361: A6 06          LDA    ,X
4363: 84 32          ANDA   #$10
4365: 27 84          BEQ    $436D
4367: 10 8E E7 5E    LDY    #$CFD6
436B: 20 20          BRA    $4375
436D: A6 0C          LDA    ,X
436F: 4A             DECA
4370: C6 21          LDB    #$03
4372: 3D             MUL
4373: 31 89          LEAY   D,Y
4375: D6 F7          LDB    $75
4377: A6 88          LDA    ,Y+
4379: BD CA A5       JSR    $422D
437C: A6 88          LDA    ,Y+
437E: BD CA 0F       JSR    $422D
4381: A6 22          LDA    ,Y+
4383: BD 60 0F       JSR    $422D
4386: 33 C3          LEAU   $1,U
4388: 30 29          LEAX   $1,X
438A: BD CB D4       JSR    $43FC
438D: BD DA 2B       JSR    $52A3
4390: 96 4E          LDA    $6C
4392: 27 87          BEQ    $4399
4394: CC 3B 03       LDD    #$1981
4397: 20 2B          BRA    $439C
4399: CC 92 0B       LDD    #$1A83
439C: E7 E1 80 88    STB    $0800,U					;  [video_address]
43A0: A7 E6          STA    ,U					;  [video_address]
43A2: 0C C3          INC    $41
43A4: CE 04 C6       LDU    #$2644
43A7: 96 69          LDA    $41
43A9: C6 C8          LDB    #$40
43AB: 3D             MUL
43AC: 33 E3          LEAU   D,U
43AE: 30 8D          LEAX   $5,X
43B0: 0A 62          DEC    $40
43B2: 10 26 DD 59    LBNE   $4331
43B6: 39             RTS

43B7: 84 27          ANDA   #$0F
43B9: BD CA A4       JSR    write_char_and_move_cursor_422c
43BC: 86 08          LDA    #$20
43BE: BD CA 0E       JSR    write_char_and_move_cursor_422c
43C1: 33 C3          LEAU   $1,U
43C3: 86 31          LDA    #$13
43C5: BD C0 AE       JSR    write_char_and_move_cursor_422c
43C8: 86 08          LDA    #$20
43CA: BD CA 04       JSR    write_char_and_move_cursor_422c
43CD: 86 AD          LDA    #$25
43CF: BD 60 0E       JSR    write_char_and_move_cursor_422c
43D2: 33 C4          LEAU   $6,U
43D4: 30 23          LEAX   $1,X
43D6: 20 48          BRA    $43A2
43D8: 0F 57          CLR    $7F
43DA: D6 FD          LDB    $75
43DC: A6 AC          LDA    ,X
43DE: 27 9A          BEQ    $43F2
43E0: BD 60 AF       JSR    $422D
43E3: 0C 5D          INC    $7F
43E5: 96 E9          LDA    $6B
43E7: 27 39          BEQ    $43FA
43E9: 86 05          LDA    #$8D
43EB: BD 6A 04       JSR    write_char_and_move_cursor_422c
43EE: D6 FD          LDB    $75
43F0: 20 2A          BRA    $43FA
43F2: 33 C3          LEAU   $1,U
43F4: 96 49          LDA    $6B
43F6: 27 80          BEQ    $43FA
43F8: 33 69          LEAU   $1,U
43FA: 20 AC          BRA    $4420
43FC: 0F 57          CLR    $7F
43FE: D6 FD          LDB    $75
4400: A6 A6          LDA    ,X
4402: 26 86          BNE    $4408
4404: 86 32          LDA    #$10
4406: 20 80          BRA    $440A
4408: 0C 57          INC    $7F
440A: BD CA 05       JSR    $422D
440D: 96 E3          LDA    $6B
440F: 27 2D          BEQ    $4420
4411: 86 92          LDA    #$10
4413: E6 A6          LDB    ,X
4415: 27 86          BEQ    $441B
4417: 86 A5          LDA    #$8D
4419: C6 88          LDB    #$00
441B: BD 6A 05       JSR    $422D
441E: D6 FD          LDB    $75
4420: A6 23          LDA    $1,X
4422: 26 84          BNE    $442A
4424: 0D 5D          TST    $7F
4426: 26 80          BNE    $442A
4428: 86 38          LDA    #$10
442A: BD CA 05       JSR    $422D
442D: A6 8A          LDA    $2,X
442F: BD 60 0F       JSR    $422D
4432: 96 EB          LDA    current_event_69
4434: 81 22          CMPA   #$00
4436: 27 8E          BEQ    $4444
4438: 81 2A          CMPA   #$02
443A: 27 80          BEQ    $4444
443C: 81 2E          CMPA   #$06
443E: 27 8C          BEQ    $4444
4440: 81 21          CMPA   #$03
4442: 26 97          BNE    $4459
4444: 86 A9          LDA    #$8B
4446: D6 E9          LDB    $6B
4448: 26 22          BNE    $4454
444A: 86 02          LDA    #$8A
444C: D6 41          LDB    current_event_69
444E: C1 8E          CMPB   #$06
4450: 26 20          BNE    $4454
4452: 86 A9          LDA    #$2B
4454: BD 60 AE       JSR    write_char_and_move_cursor_422c
4457: D6 5D          LDB    $75
4459: A6 8B          LDA    $3,X
445B: BD 6A 05       JSR    $422D
445E: 96 E1          LDA    current_event_69
4460: 81 26          CMPA   #$04
4462: 26 85          BNE    $446B
4464: 86 AE          LDA    #$8C
4466: BD C0 04       JSR    write_char_and_move_cursor_422c
4469: D6 FD          LDB    $75
446B: A6 2C          LDA    $4,X
446D: 7E CA A5       JMP    $422D
4470: 96 22          LDA    game_playing_00
4472: 26 83          BNE    $4475
4474: 39             RTS

4475: 8E B6 1A       LDX    #$3498
4478: CE 08 49       LDU    #$20C1
447B: 96 29          LDA    $01
447D: 4C             INCA
447E: 97 C8          STA    $40
4480: 10 8E 4D 67    LDY    #$CFE5
4484: A6 A6          LDA    ,X
4486: 4A             DECA
4487: E6 8E          LDB    A,Y
4489: D7 CF          STB    $47
448B: 4C             INCA
448C: BD 6A A5       JSR    $422D
448F: 86 02          LDA    #$20
4491: BD C0 AF       JSR    $422D
4494: 33 63          LEAU   $1,U
4496: 10 8E 1B 48    LDY    #$3360
449A: A6 08          LDA    ,X+
449C: 4A             DECA
449D: C6 8B          LDB    #$03
449F: 3D             MUL
44A0: 31 89          LEAY   D,Y
44A2: D6 C5          LDB    $47
44A4: 8D 2A          BSR    $44AE
44A6: 33 4A 1A       LEAU   $32,U
44A9: 0A C8          DEC    $40
44AB: 26 FB          BNE    $4480
44AD: 39             RTS

44AE: 0F C9          CLR    $41
44B0: A6 82          LDA    ,Y+
44B2: BD C0 0F       JSR    $422D
44B5: A6 22          LDA    ,Y+
44B7: BD 6A 05       JSR    $422D
44BA: A6 28          LDA    ,Y+
44BC: BD 6A A5       JSR    $422D
44BF: 33 63          LEAU   $1,U
44C1: 86 81          LDA    #$03
44C3: 97 60          STA    $42
44C5: A6 06          LDA    ,X
44C7: 44             LSRA
44C8: 44             LSRA
44C9: 44             LSRA
44CA: 44             LSRA
44CB: 26 2C          BNE    $44D1
44CD: 0D C9          TST    $41
44CF: 27 25          BEQ    $44D8
44D1: 0C C3          INC    $41
44D3: BD 60 0F       JSR    $422D
44D6: 20 80          BRA    $44DA
44D8: 33 69          LEAU   $1,U
44DA: A6 08          LDA    ,X+
44DC: 84 27          ANDA   #$0F
44DE: 26 8C          BNE    $44E4
44E0: 0D 63          TST    $41
44E2: 27 85          BEQ    $44EB
44E4: 0C 63          INC    $41
44E6: BD C0 05       JSR    $422D
44E9: 20 8A          BRA    $44ED
44EB: 33 69          LEAU   $1,U
44ED: 0A CA          DEC    $42
44EF: 26 F6          BNE    $44C5
44F1: 4F             CLRA
44F2: 7E C0 0F       JMP    $422D

irq_44f5:
44F5: 7F 96 05       CLR    irq_mask_w_1487
44F8: 86 29          LDA    #$01
44FA: B7 9C 28       STA    watchdog_1400
44FD: BD CD 94       JSR    read_inputs_451c
4500: BD 67 C6       JSR    $4544
4503: BD 67 F6       JSR    $45D4
4506: 0C 8D          INC    $0F
4508: 96 08          LDA    $20
450A: 48             ASLA
450B: 8E FB 12       LDX   #table_d33a
450E: AD 1E          JSR    [A,X]		; [jump_table]
4510: BD 6D 50       JSR    $4FD2
4513: BD 6D 9F       JSR    $4FBD
4516: 86 83          LDA    #$01
4518: B7 3C 0F       STA    irq_mask_w_1487
451B: 3B             RTI

read_inputs_451c:
451C: 8E 18 98       LDX    #$3010
451F: 86 21          LDA    #$03
4521: 97 CA          STA    $48
4523: A6 23          LDA    $1,X
4525: A7 80          STA    $2,X
4527: A6 AC          LDA    ,X
4529: A7 89          STA    $1,X
452B: 30 2B          LEAX   $3,X
452D: 0A C0          DEC    $48
452F: 26 D0          BNE    $4523
4531: B6 94 02       LDA    system_1680
4534: 43             COMA
4535: 97 92          STA    $10
4537: B6 3E A9       LDA    in0_1681
453A: 43             COMA
453B: 97 3B          STA    $13
453D: B6 9E 0A       LDA    in1_1682
4540: 43             COMA
4541: 97 94          STA    $16
4543: 39             RTS

4544: 96 2E          LDA    $0C
4546: 84 8D          ANDA   #$0F
4548: 81 27          CMPA   #$0F
454A: 26 8D          BNE    $4551
454C: 86 4B          LDA    #$63
454E: 97 8B          STA    $03
4550: 39             RTS

4551: 96 86          LDA    $04
4553: 27 26          BEQ    $4559
4555: 0A 86          DEC    $04
4557: 86 29          LDA    #$01
4559: B7 9C 0B       STA    coin_counter_1_w_1483
455C: 96 2E          LDA    $06
455E: 27 8C          BEQ    $4564
4560: 0A 24          DEC    $06
4562: 86 83          LDA    #$01
4564: B7 36 06       STA    coin_counter_1_w_1484
4567: 96 3A          LDA    $12
4569: 9A 99          ORA    $11
456B: 43             COMA
456C: 94 38          ANDA   $10
456E: 84 8F          ANDA   #$07
4570: 27 39          BEQ    $458D
4572: 97 CA          STA    $48
4574: 96 22          LDA    game_playing_00
4576: 26 8B          BNE    $4581
4578: 4F             CLRA
4579: BD C6 3F       JSR    $4EB7
457C: 86 12          LDA    #$3A
457E: BD C6 95       JSR    $4EB7
4581: 8D 97          BSR    $4598
4583: 96 6A          LDA    $48
4585: 85 83          BITA   #$01
4587: 26 2D          BNE    $458E
4589: 85 8A          BITA   #$02
458B: 26 2E          BNE    $4593
458D: 39             RTS

458E: 86 8B          LDA    #$03
4590: 97 26          STA    $04
4592: 39             RTS

4593: 86 21          LDA    #$03
4595: 97 84          STA    $06
4597: 39             RTS

4598: 96 60          LDA    $48
459A: 85 89          BITA   #$01
459C: 26 21          BNE    $45A7
459E: 85 8A          BITA   #$02
45A0: 26 35          BNE    $45B9
45A2: 0C 81          INC    $03
45A4: 20 01          BRA    $45C9
45A6: 39             RTS

45A7: 0C 2D          INC    $05
45A9: 96 8D          LDA    $05
45AB: 91 20          CMPA   $08
45AD: 26 7F          BNE    $45A6
45AF: 96 2B          LDA    $09
45B1: 9B 81          ADDA   $03
45B3: 97 21          STA    $03
45B5: 0F 87          CLR    $05
45B7: 20 38          BRA    $45C9
45B9: 0C 8F          INC    $07
45BB: 96 2F          LDA    $07
45BD: 91 82          CMPA   $0A
45BF: 26 C7          BNE    $45A6
45C1: 96 89          LDA    $0B
45C3: 9B 21          ADDA   $03
45C5: 97 81          STA    $03
45C7: 0F 2F          CLR    $07
45C9: 96 8B          LDA    $03
45CB: 81 4C          CMPA   #$64
45CD: 25 8C          BCS    $45D3
45CF: 86 41          LDA    #$63
45D1: 97 81          STA    $03
45D3: 39             RTS

45D4: 9E 1C          LDX    $3E
45D6: 9C BE          CMPX   $3C
45D8: 26 29          BNE    $45DB
45DA: 39             RTS

45DB: A6 A8          LDA    ,X+
45DD: B7 9D 88       STA    audio_register_w_1500
45E0: 4F             CLRA
45E1: B7 96 03       STA    sh_irqtrigger_w_1481
45E4: 12             NOP
45E5: 12             NOP
45E6: 12             NOP
45E7: 12             NOP
45E8: 4C             INCA
45E9: B7 9C 09       STA    sh_irqtrigger_w_1481
45EC: 8C 1B E8       CMPX   #$3360
45EF: 26 21          BNE    $45F4
45F1: 8E B1 C2       LDX    #sound_queue_3340
45F4: 9F 1C          STX    $3E
45F6: 39             RTS

45F7: BD A1 CB       JSR    $89E3
45FA: 96 AA          LDA    $22
45FC: 48             ASLA
45FD: 8E 5B CC       LDX   #table_d344
4600: 6E B4          JMP    [A,X]		; [jump_table]
4602: 8E 51 6E       LDX   #table_d34c
4605: 96 A0          LDA    $22
4607: 48             ASLA
4608: 6E BE          JMP    [A,X]		; [jump_table]
460A: 7F 9C A8       CLR    flip_screen_set_1480
460D: 8E 5B DA       LDX   #table_d352
4610: 96 06          LDA    $24
4612: 48             ASLA
4613: AD B4          JSR    [A,X]		; [jump_table]
4615: BD 2C 62       JSR    $AEE0
4618: BD 70 08       JSR    $5880
461B: 4D             TSTA
461C: 27 2C          BEQ    $4622
461E: 0C AA          INC    $22
4620: 0F 06          CLR    $24
4622: 39             RTS

4623: 7F 36 A2       CLR    flip_screen_set_1480
4626: 4F             CLRA
4627: BD 66 B2       JSR    queue_event_4e9a
462A: CC 89 29       LDD    #$0101
462D: BD C6 12       JSR    queue_event_4e9a
4630: CC 20 84       LDD    #$0206
4633: BD 6C B8       JSR    queue_event_4e9a
4636: CC 83 22       LDD    #$010A
4639: BD C6 12       JSR    queue_event_4e9a
463C: CC 2A 8C       LDD    #$0204
463F: BD 6C B8       JSR    queue_event_4e9a
4642: 86 80          LDA    #$02
4644: 97 07          STA    $25
4646: 0C A6          INC    $24
4648: 39             RTS

4649: 0A AD          DEC    $25
464B: 26 2A          BNE    $464F
464D: 0C AC          INC    $24
464F: 39             RTS

4650: CC 23 83       LDD    #$0101
4653: BD 6C B8       JSR    queue_event_4e9a
4656: 96 8D          LDA    $0F
4658: 84 38          ANDA   #$10
465A: 27 80          BEQ    $4664
465C: CE 0D 0E       LDU    #$2586
465F: C6 36          LDB    #$14
4661: 7E D0 77       JMP    $52F5
4664: D6 21          LDB    $03
4666: C1 86          CMPB   #$04
4668: 25 2A          BCS    $466C
466A: C6 8C          LDB    #$04
466C: CB 3C          ADDB   #$14
466E: 86 8A          LDA    #$02
4670: 7E 6C 18       JMP    queue_event_4e9a

start_game_4673:
4673: 0C 22          INC    game_playing_00
4675: 0F 9B          CLR    $19
4677: 0F 33          CLR    $1B
4679: 4F             CLRA
467A: 5F             CLRB
467B: 8E 18 48       LDX    #$3060
467E: ED 09          STD    ,X++
4680: ED A3          STD    ,X++
4682: 8C B3 22       CMPX   #$3100
4685: 26 75          BNE    $467E
4687: 8E 1C A8       LDX    #$3480
468A: ED 09          STD    ,X++
468C: ED A9          STD    ,X++
468E: 8C BC 8A       CMPX   #$34A8
4691: 26 75          BNE    $468A
4693: 8E 17 22       LDX    #$3500
4696: ED 03          STD    ,X++
4698: ED A9          STD    ,X++
469A: 8C BD A8       CMPX   #$3580
469D: 26 7F          BNE    $4696
469F: 8E 17 22       LDX    #$3500
46A2: 96 83          LDA    $01
46A4: 4C             INCA
46A5: 97 CA          STA    $48
46A7: 86 29          LDA    #$01
46A9: A7 0C          STA    ,X
46AB: D6 24          LDB    $0C
46AD: C4 87          ANDB   #$0F
46AF: C1 2D          CMPB   #$0F
46B1: 26 8A          BNE    $46BB
46B3: D6 2F          LDB    dsw2_copy_0d
46B5: C4 8A          ANDB   #$08
46B7: 27 2A          BEQ    $46BB
46B9: 86 BA          LDA    #$32
46BB: A7 29          STA    $1,X
46BD: 30 00 A8       LEAX   $20,X
46C0: 0A 6A          DEC    $48
46C2: 26 61          BNE    $46A7
46C4: 0C 00          INC    $22
46C6: 0F A6          CLR    $24
46C8: 39             RTS

46C9: 8E 5B D0       LDX   #table_d358
46CC: 96 0E          LDA    $26
46CE: 48             ASLA
46CF: 6E B4          JMP    [A,X]		; [jump_table]

46D1: 96 AA          LDA    event_sub_state_28
46D3: 48             ASLA
46D4: 8E F1 E4       LDX   #table_d366
46D7: 6E BE          JMP    [A,X]		; [jump_table]

46D9: 8E 5B E4       LDX   #table_d36c
46DC: 96 02          LDA    event_sub_state_2a
46DE: 48             ASLA
46DF: 6E B4          JMP    [A,X]		; [jump_table]

46E1: 0D 82          TST    game_playing_00
46E3: 27 2C          BEQ    $46F3
46E5: CE 51 F2       LDU    #$D370
46E8: 96 40          LDA    current_level_68
46EA: C6 8F          LDB    #$07
46EC: BD 8E 8E       JSR    $A606
46EF: A6 E4          LDA    A,U
46F1: 97 EB          STA    current_event_69
46F3: 4F             CLRA
46F4: BD 6C 18       JSR    queue_event_4e9a
46F7: 86 2A          LDA    #$02
46F9: 97 A3          STA    $2B
46FB: 0C 02          INC    event_sub_state_2a
46FD: 39             RTS

46FE: 0A A3          DEC    $2B
4700: 26 2B          BNE    $470B
4702: 0F E7          CLR    $65
4704: BD 7F 93       JSR    $5D11
4707: 0C 00          INC    event_sub_state_28
4709: 0F A2          CLR    event_sub_state_2a
470B: 39             RTS

470C: BD 57 BF       JSR    $7F37
470F: 4F             CLRA
4710: 5F             CLRB
4711: 8E B1 02       LDX    #$3380
4714: ED A3          STD    ,X++
4716: ED 03          STD    ,X++
4718: 8C 1B 70       CMPX   #$33F8
471B: 26 DF          BNE    $4714
471D: 8E BC 20       LDX    #$34A8
4720: ED A3          STD    ,X++
4722: 8C B6 C6       CMPX   #$34E4
4725: 26 7B          BNE    $4720
4727: 8E 1C CE       LDX    #$34E6
472A: ED 09          STD    ,X++
472C: 8C 1C 78       CMPX   #$34F0
472F: 26 DB          BNE    $472A
4731: 0F 99          CLR    $1B
4733: 0F 49          CLR    $6B
4735: 96 EB          LDA    current_event_69
4737: 81 2B          CMPA   #$03
4739: 26 A2          BNE    $4765
473B: 0C 43          INC    $6B
473D: 8E BB 59       LDX    #$33D1
4740: C6 26          LDB    #$04
4742: 86 92          LDA    #$10
4744: A7 A2          STA    ,X+
4746: A7 02          STA    ,X+
4748: A7 A8          STA    ,X+
474A: A7 08          STA    ,X+
474C: A7 A9          STA    ,X++
474E: 5A             DECB
474F: 26 D1          BNE    $4744
4751: 96 98          LDA    $1A
4753: 27 32          BEQ    $4765
4755: 8E B7 82       LDX    #$3500
4758: 0F 33          CLR    $1B
475A: A6 0C          LDA    ,X
475C: 26 2F          BNE    $4765
475E: A6 00 02       LDA    $20,X
4761: 26 80          BNE    $4765
4763: 0C 39          INC    $1B
4765: 86 BF          LDA    #$3D
4767: BD 66 9B       JSR    force_queue_sound_event_4eb3
476A: 86 89          LDA    #$01
476C: B7 1C 7B       STA    $34F3
476F: 0C 0A          INC    event_sub_state_28
4771: 39             RTS

4772: BD D7 1E       JSR    $553C
4775: 86 85          LDA    #$07
4777: BD 66 B2       JSR    queue_event_4e9a
477A: BD DF 2B       JSR    $5703
477D: BD DE 2E       JSR    $56A6
4780: 8D 1C          BSR    $47C0
4782: 96 82          LDA    game_playing_00
4784: 26 17          BNE    $47BB
4786: 7D B6 CD       TST    $34E5
4789: 27 94          BEQ    $47A7
478B: CE 0F 2C       LDU    #$2704
478E: 8E 5B A9       LDX    #$D38B
4791: 10 8E 51 B1    LDY    #$D393
4795: 86 8A          LDA    #$08
4797: 97 60          STA    $48
4799: A6 08          LDA    ,X+
479B: A0 88          SUBA   ,Y+
479D: BD CA A4       JSR    write_char_and_move_cursor_422c
47A0: 0A 6A          DEC    $48
47A2: 26 77          BNE    $4799
47A4: 7F 16 67       CLR    $34E5
47A7: 96 24          LDA    $0C
47A9: 84 87          ANDA   #$0F
47AB: 81 27          CMPA   #$0F
47AD: 26 84          BNE    $47BB
47AF: CC 23 28       LDD    #$010A
47B2: BD CC B8       JSR    queue_event_4e9a
47B5: CC 80 AA       LDD    #$0228
47B8: BD 66 12       JSR    queue_event_4e9a
47BB: 0F 00          CLR    event_sub_state_28
47BD: 0C AE          INC    $26
47BF: 39             RTS

47C0: 8E 12 E2       LDX    #$3060
47C3: CE 04 7A       LDU    #$2658
47C6: BD D5 6A       JSR    $5742
47C9: 86 89          LDA    #$01
47CB: 97 5D          STA    $75
47CD: 7E CB 74       JMP    $43FC
47D0: BD 7A AE       JSR    $582C
47D3: BD 70 EE       JSR    $52CC
47D6: BD D4 F4       JSR    $56DC
47D9: 96 A0          LDA    event_sub_state_28
47DB: 48             ASLA
47DC: 8E FB FF       LDX   #table_d377
47DF: 6E B4          JMP    [A,X]		; [jump_table]
47E1: 4F             CLRA
47E2: 5F             CLRB
47E3: 8E 12 52       LDX    #$3070
47E6: ED 03          STD    ,X++
47E8: ED A9          STD    ,X++
47EA: 8C B8 50       CMPX   #$3078
47ED: 26 7F          BNE    $47E6
47EF: 8E 12 B8       LDX    #$309A
47F2: ED 03          STD    ,X++
47F4: 8C 11 82       CMPX   #$3300
47F7: 26 D1          BNE    $47F2
47F9: 8E BC 88       LDX    #$3400
47FC: ED A9          STD    ,X++
47FE: ED 09          STD    ,X++
4800: 8C 16 02       CMPX   #$3480
4803: 26 D5          BNE    $47FC
4805: FD B6 73       STD    $34F1
4808: 7F 1C 6F       CLR    $34E7
480B: 7F 1C CE       CLR    $34E6
480E: 8E BC D6       LDX    #$34F4
4811: ED 03          STD    ,X++
4813: 8C 16 DE       CMPX   #$34FC
4816: 26 7B          BNE    $4811
4818: FD 1B 7C       STD    $33F4
481B: FD 1B DE       STD    $33F6
481E: BD D8 05       JSR    $5027
4821: 4F             CLRA
4822: D6 98          LDB    $1A
4824: 26 2C          BNE    $4834
4826: D6 EB          LDB    current_event_69
4828: C1 2B          CMPB   #$03
482A: 27 80          BEQ    $4834
482C: D6 31          LDB    $19
482E: C1 8A          CMPB   #$02
4830: 25 20          BCS    $4834
4832: 86 83          LDA    #$01
4834: B7 36 02       STA    flip_screen_set_1480
4837: 97 2A          STA    $02
4839: BD 27 27       JSR    $AFAF
483C: BD 87 49       JSR    $AFC1
483F: BD 72 33       JSR    $5011
4842: BD D3 76       JSR    $5154
4845: 86 87          LDA    #$05
4847: 97 8D          STA    $A5
4849: 96 E3          LDA    $6B
484B: 27 21          BEQ    $4856
484D: BD DB B0       JSR    $5338
4850: BD 6D 65       JSR    $4FE7
4853: BD 77 96       JSR    $55B4
4856: BD D1 29       JSR    $5301
4859: 96 E3          LDA    $6B
485B: 26 24          BNE    $4869
485D: BD C7 6F       JSR    $4FE7
4860: BD 77 36       JSR    $55B4
4863: BD 7A 77       JSR    $5855
4866: BD D5 D4       JSR    $57FC
4869: 0C A0          INC    event_sub_state_28
486B: 39             RTS

486C: 8E FB 0F       LDX   #table_d387
486F: 96 08          LDA    event_sub_state_2a
4871: 48             ASLA
4872: 6E 14          JMP    [A,X]		; [jump_table]
4874: 8E F1 19       LDX   #table_d39b
4877: 96 41          LDA    current_event_69
4879: 48             ASLA
487A: AD 1E          JSR    [A,X]		; [jump_table]
487C: 0C 02          INC    event_sub_state_2a
487E: 39             RTS

487F: 8E F1 8B       LDX   #table_d3a9
4882: 96 EB          LDA    current_event_69
4884: 48             ASLA
4885: AD 14          JSR    [A,X]		; [jump_table]
4887: 0C 00          INC    event_sub_state_28
4889: 0F A2          CLR    event_sub_state_2a
488B: 39             RTS

488C: BD 7C B9       JSR    $5431
488F: 86 21          LDA    #$03
4891: 0D 82          TST    game_playing_00
4893: 26 20          BNE    $4897
4895: 86 85          LDA    #$07
4897: 97 00          STA    event_sub_state_28
4899: 39             RTS

489A: BD 27 E9       JSR    $AFC1
489D: BD D4 C5       JSR    $5C4D
48A0: 7E 7F E1       JMP    $5D63
48A3: 7E 7D 54       JMP    $5F76
48A6: 0F E7          CLR    $65
48A8: BD 74 C5       JSR    $5C4D
48AB: 7E 75 D7       JMP    $5DFF
48AE: 86 89          LDA    #$01
48B0: 97 47          STA    $65
48B2: BD DC 71       JSR    $5E53
48B5: 7E DC 81       JMP    $5E03
48B8: 0F 4D          CLR    $65
48BA: BD D6 7B       JSR    $5E53
48BD: 7E D6 8B       JMP    $5E03
48C0: 39             RTS

48C1: BD DC D1       JSR    $5E53
48C4: 7E 7F 27       JMP    $5DA5
48C7: 96 41          LDA    current_event_69
48C9: 81 8B          CMPA   #$03
48CB: 27 08          BEQ    $48ED
48CD: BD E8 EA       JSR    $6062
48D0: 86 20          LDA    #$02
48D2: D6 9B          LDB    $19
48D4: BD 6C 18       JSR    queue_event_4e9a
48D7: CE 0A 7B       LDU    #$2253
48DA: BD DB 56       JSR    $537E
48DD: CC 8A 8F       LDD    #$0207
48E0: BD 6C 18       JSR    queue_event_4e9a
48E3: BD 76 A9       JSR    $548B
48E6: 86 22          LDA    #$A0
48E8: 97 01          STA    $29
48EA: 0C A0          INC    event_sub_state_28
48EC: 39             RTS

48ED: BD E8 F7       JSR    $607F
48F0: 96 38          LDA    $1A
48F2: 27 8D          BEQ    $4903
48F4: 4F             CLRA
48F5: D6 99          LDB    $1B
48F7: 27 2A          BEQ    $48FB
48F9: 86 8A          LDA    #$02
48FB: 97 31          STA    $19
48FD: 97 FF          STA    $77
48FF: 86 20          LDA    #$02
4901: 20 84          BRA    $4909
4903: 0F 3B          CLR    $19
4905: 0F F5          CLR    $77
4907: 86 2C          LDA    #$04
4909: 97 ED          STA    $65
490B: 97 4E          STA    $66
490D: BD DC 03       JSR    $548B
4910: 0C 3B          INC    $19
4912: 0A E7          DEC    $65
4914: 26 D5          BNE    $490D
4916: 96 F5          LDA    $77
4918: 97 31          STA    $19
491A: 0C A0          INC    event_sub_state_28
491C: 0C 00          INC    event_sub_state_28
491E: 39             RTS

491F: BD 76 F2       JSR    $54D0
4922: BD 07 DD       JSR    $85FF
4925: B6 B6 71       LDA    $34F3
4928: 26 26          BNE    $4938
492A: BD C6 E2       JSR    $4ECA
492D: BD C7 02       JSR    $4F8A
4930: 84 27          ANDA   #$05
4932: 27 86          BEQ    $4938
4934: 86 23          LDA    #$01
4936: 97 AB          STA    $29
4938: 0A 01          DEC    $29
493A: 26 A3          BNE    $4967
493C: 7F 1C 7B       CLR    $34F3
493F: BD 7C 71       JSR    $5E53
4942: 96 EB          LDA    current_event_69
4944: 81 26          CMPA   #$04
4946: 26 99          BNE    $4963
4948: 8E 0A A8       LDX    #$2220
494B: 86 2E          LDA    #$06
494D: 97 C0          STA    $48
494F: 86 32          LDA    #$10
4951: C6 A2          LDB    #$20
4953: 6F AB 2A 82    CLR    $0800,X					;  [video_address]
4957: A7 A8          STA    ,X+					;  [video_address]
4959: 5A             DECB
495A: 26 7F          BNE    $4953
495C: 30 A0 A8       LEAX   $20,X
495F: 0A 6A          DEC    $48
4961: 26 6C          BNE    $4951
4963: 86 25          LDA    #$07
4965: 97 AA          STA    event_sub_state_28
4967: 39             RTS

4968: 8E 1D 88       LDX    #$3500
496B: 96 31          LDA    $19
496D: C6 A8          LDB    #$20
496F: 3D             MUL
4970: 30 A9          LEAX   D,X
4972: A6 06          LDA    ,X
4974: 27 02          BEQ    $4996
4976: A6 86          LDA    $4,X
4978: 26 34          BNE    $4996
497A: 86 8A          LDA    #$02
497C: D6 31          LDB    $19
497E: CB A1          ADDB   #$29
4980: BD 6C 18       JSR    queue_event_4e9a
4983: CE 01 E6       LDU    #$23C4
4986: BD D1 56       JSR    $537E
4989: CC 8A A5       LDD    #$022D
498C: BD 66 12       JSR    queue_event_4e9a
498F: BD 76 8C       JSR    $54AE
4992: 86 02          LDA    #$80
4994: 20 20          BRA    $4998
4996: 86 83          LDA    #$01
4998: 97 01          STA    $29
499A: 0C A0          INC    event_sub_state_28
499C: 39             RTS

499D: BD DD 8E       JSR    $5506
49A0: BD A7 7D       JSR    $85FF
49A3: 0A 0B          DEC    $29
49A5: 26 8A          BNE    $49AF
49A7: 0C 31          INC    $19
49A9: 0A EE          DEC    $66
49AB: 27 2B          BEQ    $49B0
49AD: 0A A0          DEC    event_sub_state_28
49AF: 39             RTS

49B0: 0C 0A          INC    event_sub_state_28
49B2: 39             RTS

49B3: 96 4B          LDA    current_event_69
49B5: 81 81          CMPA   #$03
49B7: 26 0E          BNE    $49DF
49B9: 8E B8 28       LDX    #$30A0
49BC: 6F AC          CLR    ,X
49BE: 30 00 42       LEAX   $60,X
49C1: 8C B0 A2       CMPX   #$3220
49C4: 26 D4          BNE    $49BC
49C6: 6F 06          CLR    ,X
49C8: 30 A0 A8       LEAX   $20,X
49CB: 8C 1B 28       CMPX   #$3300
49CE: 26 7E          BNE    $49C6
49D0: BD 71 BA       JSR    $5338
49D3: BD 6D C5       JSR    $4FE7
49D6: BD D7 9C       JSR    $55B4
49D9: BD D7 FE       JSR    $5F76
49DC: BD 51 6A       JSR    $79E2
49DF: BD 76 E1       JSR    $54C3
49E2: 4F             CLRA
49E3: 5F             CLRB
49E4: 8E 16 82       LDX    #$3400
49E7: ED A9          STD    ,X++
49E9: 8C BC 08       CMPX   #$3480
49EC: 26 D1          BNE    $49E7
49EE: 0C AE          INC    $26
49F0: 0F 0A          CLR    event_sub_state_28
49F2: 39             RTS

49F3: BD 6C E8       JSR    $4ECA
49F6: BD DA 04       JSR    $582C
49F9: BD DA 44       JSR    $52CC
49FC: BD 7E 54       JSR    $56DC
49FF: 96 4B          LDA    current_event_69
4A01: 48             ASLA
4A02: 8E 51 95       LDX   #event_table_d3b7
4A05: 6E 14          JMP    [A,X]		; [jump_table]

4A07: BD 70 04       JSR    $582C
4A0A: BD DA E4       JSR    $52CC
4A0D: BD DE 54       JSR    $56DC
4A10: 8E F1 47       LDX   #table_d3c5
4A13: 96 0A          LDA    event_sub_state_28
4A15: 48             ASLA
4A16: 6E 14          JMP    [A,X]		; [jump_table]
4A18: 86 18          LDA    #$30
4A1A: 97 A1          STA    $29
4A1C: 0C 00          INC    event_sub_state_28
4A1E: 39             RTS

4A1F: 96 3B          LDA    $19
4A21: 97 F5          STA    $77
4A23: 96 49          LDA    $6B
4A25: 10 26 83 21    LBNE   $4B32
4A29: BD DB 14       JSR    $539C
4A2C: BD 7A 30       JSR    $52B8
4A2F: BD 73 53       JSR    $5171
4A32: 86 84          LDA    #$06
4A34: BD 6C 18       JSR    queue_event_4e9a
4A37: BD 70 7D       JSR    $5855
4A3A: BD DF D4       JSR    $57FC
4A3D: 96 E1          LDA    current_event_69
4A3F: 81 20          CMPA   #$02
4A41: 26 8B          BNE    $4A4C
4A43: BD 91 B8       JSR    $B39A
4A46: 96 49          LDA    $CB
4A48: 26 14          BNE    $4A86
4A4A: 20 8F          BRA    $4A53
4A4C: BD 7A 29       JSR    $52A1
4A4F: 96 4E          LDA    $6C
4A51: 27 B1          BEQ    $4A86
4A53: 8E 12 82       LDX    #$30A0
4A56: CE 58 17       LDU    #$DA3F
4A59: 96 E1          LDA    current_event_69
4A5B: 81 29          CMPA   #$01
4A5D: 26 8B          BNE    $4A62
4A5F: CE FE FA       LDU    #$DCD8
4A62: EF 89          STU    $B,X
4A64: 7F 16 76       CLR    $34F4
4A67: BD 63 23       JSR    $4B0B
4A6A: 86 89          LDA    #$01
4A6C: 97 5C          STA    $74
4A6E: 86 77          LDA    #$FF
4A70: B7 16 75       STA    $34F7
4A73: BD 8D 01       JSR    $AF23
4A76: B6 B1 DC       LDA    $33F4
4A79: 26 D1          BNE    $4AD4
4A7B: 4F             CLRA
4A7C: BD 66 3B       JSR    force_queue_sound_event_4eb3
4A7F: 86 63          LDA    #$41
4A81: BD CC 31       JSR    force_queue_sound_event_4eb3
4A84: 20 6C          BRA    $4AD4
4A86: 8E B2 88       LDX    #$30A0
4A89: BD C3 83       JSR    $4B0B
4A8C: CE FB 59       LDU    #$D3D1
4A8F: 8D 50          BSR    $4B03
4A91: 96 E8          LDA    $6A
4A93: 81 20          CMPA   #$02
4A95: 26 8D          BNE    $4AA6
4A97: CE FB F0       LDU    #$D3D8
4A9A: 8D EF          BSR    $4B03
4A9C: BD 7A 30       JSR    $52B8
4A9F: BD 70 81       JSR    $52A3
4AA2: 96 EE          LDA    $6C
4AA4: 27 3A          BEQ    $4ABE
4AA6: 8E B2 88       LDX    #$30A0
4AA9: CE 52 D3       LDU    #$DA5B
4AAC: 96 41          LDA    current_event_69
4AAE: 81 89          CMPA   #$01
4AB0: 26 21          BNE    $4AB5
4AB2: CE 5E FD       LDU    #$DCDF
4AB5: EF 89          STU    $B,X
4AB7: 86 29          LDA    #$01
4AB9: B7 BC 7C       STA    $34F4
4ABC: 20 3E          BRA    $4AD4
4ABE: 8E B8 82       LDX    #$30A0
4AC1: CE 58 EE       LDU    #$DA6C
4AC4: 96 4B          LDA    current_event_69
4AC6: 81 83          CMPA   #$01
4AC8: 26 2B          BNE    $4ACD
4ACA: CE 54 CE       LDU    #$DCE6
4ACD: EF 83          STU    $B,X
4ACF: 86 20          LDA    #$02
4AD1: B7 B6 76       STA    $34F4
4AD4: B6 11 76       LDA    $33F4
4AD7: 27 3D          BEQ    $4AEE
4AD9: 7F BC 6F       CLR    $34E7
4ADC: BD 54 B9       JSR    $7C31
4ADF: BD 5E 72       JSR    $7C50
4AE2: BD 2D 8D       JSR    $AFAF
4AE5: 86 BE          LDA    #$3C
4AE7: BD 66 9B       JSR    force_queue_sound_event_4eb3
4AEA: 86 77          LDA    #$FF
4AEC: 20 22          BRA    $4AF8
4AEE: B6 BC D5       LDA    $34F7
4AF1: F6 B6 72       LDB    $34F0
4AF4: 27 20          BEQ    $4AF8
4AF6: 86 E2          LDA    #$60
4AF8: 97 01          STA    $29
4AFA: BD 08 28       JSR    $8000
4AFD: BD 09 92       JSR    $811A
4B00: 0C 0A          INC    event_sub_state_28
4B02: 39             RTS

4B03: 96 4B          LDA    current_event_69
4B05: A6 44          LDA    A,U
4B07: B7 1C DF       STA    $34F7
4B0A: 39             RTS

4B0B: CE F0 CE       LDU    #$D8E6
4B0E: 96 E1          LDA    current_event_69
4B10: C6 2E          LDB    #$0C
4B12: 3D             MUL
4B13: A6 E9          LDA    D,U
4B15: D6 EB          LDB    current_event_69
4B17: C1 2E          CMPB   #$06
4B19: 27 87          BEQ    $4B2A
4B1B: C1 2A          CMPB   #$02
4B1D: 26 80          BNE    $4B27
4B1F: D6 E9          LDB    $CB
4B21: C1 80          CMPB   #$02
4B23: 27 20          BEQ    $4B27
4B25: 80 8A          SUBA   #$08
4B27: A7 29          STA    $1,X
4B29: 39             RTS

4B2A: 0D 77          TST    $FF
4B2C: 27 D1          BEQ    $4B27
4B2E: 86 D8          LDA    #$50
4B30: 20 D7          BRA    $4B27
4B32: 8E B1 F2       LDX    #$33D0
4B35: 86 86          LDA    #$04
4B37: 97 60          STA    $48
4B39: A6 0C          LDA    ,X
4B3B: 27 01          BEQ    $4B66
4B3D: 85 98          BITA   #$10
4B3F: 26 07          BNE    $4B66
4B41: 84 8D          ANDA   #$0F
4B43: 4A             DECA
4B44: D6 38          LDB    $1A
4B46: 27 97          BEQ    $4B5D
4B48: D6 33          LDB    $1B
4B4A: 26 82          BNE    $4B56
4B4C: 81 2A          CMPA   #$02
4B4E: 27 9E          BEQ    $4B66
4B50: 81 21          CMPA   #$03
4B52: 27 90          BEQ    $4B66
4B54: 20 25          BRA    $4B5D
4B56: 4D             TSTA
4B57: 27 25          BEQ    $4B66
4B59: 81 89          CMPA   #$01
4B5B: 27 21          BEQ    $4B66
4B5D: 97 91          STA    $19
4B5F: 34 32          PSHS   X
4B61: BD 2D A1       JSR    $AF23
4B64: 35 32          PULS   X
4B66: 30 84          LEAX   $6,X
4B68: 0A 60          DEC    $48
4B6A: 26 45          BNE    $4B39
4B6C: B6 1B 7C       LDA    $33F4
4B6F: 27 2D          BEQ    $4B80
4B71: CC B1 76       LDD    #$33F4
4B74: DD DC          STD    $FE
4B76: BD 2D 87       JSR    $AFAF
4B79: 86 78          LDA    #$F0
4B7B: 97 01          STA    $29
4B7D: 0C A0          INC    event_sub_state_28
4B7F: 39             RTS

4B80: 0F 6B          CLR    $49
4B82: 96 98          LDA    $1A
4B84: 27 52          BEQ    $4BF6
4B86: CC 5E 71       LDD    #$DC59
4B89: DD 23          STD    $AB
4B8B: FD 19 E3       STD    $31CB
4B8E: 4F             CLRA
4B8F: D6 39          LDB    $1B
4B91: 27 80          BEQ    $4B95
4B93: 86 20          LDA    #$02
4B95: 97 9B          STA    $19
4B97: 86 2A          LDA    #$02
4B99: 97 ED          STA    $65
4B9B: CE 19 28       LDU    #$3100
4B9E: A6 4C          LDA    ,U
4BA0: 26 24          BNE    $4BA8
4BA2: 86 92          LDA    #$10
4BA4: A7 E6          STA    ,U
4BA6: 20 C1          BRA    $4BEB
4BA8: A6 65          LDA    $D,U
4BAA: 26 9E          BNE    $4BC2
4BAC: BD 7A 29       JSR    $52A1
4BAF: 96 4E          LDA    $6C
4BB1: 27 B1          BEQ    $4BE6
4BB3: 0D 6B          TST    $49
4BB5: 26 89          BNE    $4BC2
4BB7: 0C 61          INC    $49
4BB9: 4F             CLRA
4BBA: BD C6 9B       JSR    force_queue_sound_event_4eb3
4BBD: 86 C9          LDA    #$41
4BBF: BD 6C 91       JSR    force_queue_sound_event_4eb3
4BC2: 96 5B          LDA    $D9
4BC4: 4A             DECA
4BC5: D6 98          LDB    $1A
4BC7: 27 2F          BEQ    $4BD0
4BC9: 4A             DECA
4BCA: D6 93          LDB    $1B
4BCC: 27 2A          BEQ    $4BD0
4BCE: 8B 8A          ADDA   #$02
4BD0: 91 3B          CMPA   $19
4BD2: 26 89          BNE    $4BDF
4BD4: CC FE ED       LDD    #$DC6F
4BD7: ED 63          STD    $B,U
4BD9: 86 89          LDA    #$01
4BDB: 97 5C          STA    $74
4BDD: 20 84          BRA    $4BEB
4BDF: CC FE 7B       LDD    #$DC59
4BE2: ED C9          STD    $B,U
4BE4: 20 27          BRA    $4BEB
4BE6: CC 5E 4C       LDD    #$DC64
4BE9: ED C3          STD    $B,U
4BEB: 33 E0 48       LEAU   $60,U
4BEE: 0C 91          INC    $19
4BF0: 0A 47          DEC    $65
4BF2: 26 28          BNE    $4B9E
4BF4: 20 A1          BRA    $4B79
4BF6: 0F 9B          CLR    $19
4BF8: CE 18 28       LDU    #$30A0
4BFB: 86 2C          LDA    #$04
4BFD: 97 ED          STA    $65
4BFF: 20 BF          BRA    $4B9E
4C01: B6 B1 76       LDA    $33F4
4C04: 27 25          BEQ    $4C0D
4C06: 96 E9          LDA    $6B
4C08: 27 63          BEQ    $4C55
4C0A: 0C A0          INC    event_sub_state_28
4C0C: 39             RTS

4C0D: 8E B8 28       LDX    #$30A0
4C10: 96 49          LDA    $6B
4C12: 26 A4          BNE    $4C3A
4C14: 96 4B          LDA    current_event_69
4C16: 81 86          CMPA   #$04
4C18: 27 39          BEQ    $4C2B
4C1A: 81 89          CMPA   #$01
4C1C: 27 3A          BEQ    $4C30
4C1E: 7D BC D6       TST    $34F4
4C21: 27 90          BEQ    $4C35
4C23: BD A1 4F       JSR    $836D
4C26: BD 00 D5       JSR    $82FD
4C29: 20 A9          BRA    $4C4C
4C2B: BD 97 A7       JSR    $BF8F
4C2E: 20 94          BRA    $4C4C
4C30: BD A7 64       JSR    $85E6
4C33: 20 35          BRA    $4C4C
4C35: BD 32 BB       JSR    $B039
4C38: 20 3A          BRA    $4C4C
4C3A: 86 8C          LDA    #$04
4C3C: 97 4D          STA    $65
4C3E: 0F 91          CLR    $19
4C40: BD A7 8F       JSR    $850D
4C43: 30 AA 42       LEAX   $60,X
4C46: 0C 9B          INC    $19
4C48: 0A 4D          DEC    $65
4C4A: 26 7C          BNE    $4C40
4C4C: 96 5C          LDA    $74
4C4E: 27 82          BEQ    $4C5A
4C50: BD 75 32       JSR    $57B0
4C53: 20 27          BRA    $4C5A
4C55: BD FE 19       JSR    $7C9B
4C58: 20 2E          BRA    $4C60
4C5A: BD 08 32       JSR    $801A
4C5D: BD 09 B5       JSR    $813D
4C60: 0A 0B          DEC    $29
4C62: 26 89          BNE    $4C6F
4C64: BD 75 81       JSR    $5703
4C67: 96 43          LDA    $6B
4C69: 26 A8          BNE    $4C8B
4C6B: 0C 0E          INC    $26
4C6D: 0F A0          CLR    event_sub_state_28
4C6F: 39             RTS

4C70: B6 11 76       LDA    $33F4
4C73: 27 34          BEQ    $4C8B
4C75: BD FE B3       JSR    $7C31
4C78: BD 54 D8       JSR    $7C50
4C7B: 4F             CLRA
4C7C: BD 66 3B       JSR    force_queue_sound_event_4eb3
4C7F: 86 1E          LDA    #$3C
4C81: BD CC 31       JSR    force_queue_sound_event_4eb3
4C84: 86 D2          LDA    #$F0
4C86: 97 AB          STA    $29
4C88: 0C 00          INC    event_sub_state_28
4C8A: 39             RTS

4C8B: BD 7F 2B       JSR    $5703
4C8E: 86 8D          LDA    #$05
4C90: 97 04          STA    $26
4C92: 86 81          LDA    #$03
4C94: 97 0A          STA    event_sub_state_28
4C96: 39             RTS

4C97: BD 54 B3       JSR    $7C9B
4C9A: 0A A1          DEC    $29
4C9C: 26 39          BNE    $4CAF
4C9E: 0C 77          INC    $FF
4CA0: 96 DD          LDA    $FF
4CA2: 81 75          CMPA   #$F7
4CA4: 27 C7          BEQ    $4C8B
4CA6: A6 1D 18 D6    LDA    [$30FE]
4CAA: B7 BB DC       STA    $33F4
4CAD: 0A A0          DEC    event_sub_state_28
4CAF: 39             RTS

4CB0: BD 72 A5       JSR    $5027
4CB3: 96 22          LDA    game_playing_00
4CB5: 26 8B          BNE    $4CC0
4CB7: 0C 0C          INC    $24
4CB9: 0F AE          CLR    $26
4CBB: 0F 00          CLR    event_sub_state_28
4CBD: 0F A2          CLR    event_sub_state_2a
4CBF: 39             RTS

4CC0: 96 55          LDA    $77
4CC2: 97 9B          STA    $19
4CC4: 8E 17 82       LDX    #$3500
4CC7: C6 08          LDB    #$20
4CC9: 3D             MUL
4CCA: 30 03          LEAX   D,X
4CCC: 96 41          LDA    current_event_69
4CCE: 81 8A          CMPA   #$02
4CD0: 26 26          BNE    $4CD6
4CD2: 96 49          LDA    $CB
4CD4: 27 2A          BEQ    $4CDE
4CD6: 6C 80          INC    $2,X
4CD8: A6 2A          LDA    $2,X
4CDA: 91 F1          CMPA   $79
4CDC: 27 0D          BEQ    $4D03
4CDE: 0C 91          INC    $19
4CE0: 96 3B          LDA    $19
4CE2: 81 86          CMPA   #$04
4CE4: 27 34          BEQ    $4CFC
4CE6: 30 0A 08       LEAX   $20,X
4CE9: A6 0C          LDA    ,X
4CEB: 27 D9          BEQ    $4CDE
4CED: A6 8A          LDA    $2,X
4CEF: 91 5B          CMPA   $79
4CF1: 24 69          BCC    $4CDE
4CF3: 86 23          LDA    #$01
4CF5: 97 A4          STA    $26
4CF7: 0F 00          CLR    event_sub_state_28
4CF9: 0F A2          CLR    event_sub_state_2a
4CFB: 39             RTS

4CFC: 0F 31          CLR    $19
4CFE: 8E BD 22       LDX    #$3500
4D01: 20 64          BRA    $4CE9
4D03: 0C 04          INC    $26
4D05: 0F AA          CLR    event_sub_state_28
4D07: 39             RTS

4D08: 8E FB 57       LDX   #table_d3df
4D0B: 96 00          LDA    event_sub_state_28
4D0D: 48             ASLA
4D0E: 6E 1E          JMP    [A,X]		; [jump_table]
4D10: BD 70 C6       JSR    $5244
4D13: 8E 11 A2       LDX    #$3380
4D16: 96 9B          LDA    $19
4D18: C6 27          LDB    #$0F
4D1A: 3D             MUL
4D1B: 30 A3          LEAX   D,X
4D1D: 96 E7          LDA    $6F
4D1F: C6 27          LDB    #$05
4D21: 3D             MUL
4D22: 30 09          LEAX   D,X
4D24: BD 70 21       JSR    $52A3
4D27: 96 44          LDA    $6C
4D29: 26 86          BNE    $4D39
4D2B: 8E 1D 28       LDX    #$3500
4D2E: 96 91          LDA    $19
4D30: C6 02          LDB    #$20
4D32: 3D             MUL
4D33: 30 A9          LEAX   D,X
4D35: 6A 83          DEC    $1,X
4D37: 27 2D          BEQ    $4D3E
4D39: 86 8A          LDA    #$02
4D3B: 97 00          STA    event_sub_state_28
4D3D: 39             RTS

4D3E: 6F 0C          CLR    ,X
4D40: 0C 0A          INC    event_sub_state_28
4D42: 39             RTS

4D43: 8E F1 CF       LDX   #table_d3ed
4D46: 96 A8          LDA    event_sub_state_2a
4D48: 48             ASLA
4D49: 6E 1E          JMP    [A,X]		; [jump_table]
4D4B: BD 7F 65       JSR    $574D
4D4E: 0D E3          TST    $6B
4D50: 26 0F          BNE    $4D7F
4D52: C6 88          LDB    #$0A
4D54: 4F             CLRA
4D55: 8E B4 52       LDX    #$36D0
4D58: A7 A8          STA    ,X+
4D5A: 5A             DECB
4D5B: 26 D3          BNE    $4D58
4D5D: BD E8 EA       JSR    $6062
4D60: 86 20          LDA    #$02
4D62: D6 9B          LDB    $19
4D64: BD 6C 18       JSR    queue_event_4e9a
4D67: CE 0A 7B       LDU    #$2253
4D6A: BD DB 56       JSR    $537E
4D6D: CC 8A 8D       LDD    #$0205
4D70: BD 6C 18       JSR    queue_event_4e9a
4D73: 86 19          LDA    #$3B
4D75: BD CC 31       JSR    force_queue_sound_event_4eb3
4D78: 86 B6          LDA    #$9E
4D7A: 97 A3          STA    $2B
4D7C: 0C 02          INC    event_sub_state_2a
4D7E: 39             RTS

4D7F: 8E 14 F2       LDX    #$36D0
4D82: C6 A2          LDB    #$20
4D84: 6D A2          TST    ,X+
4D86: 26 87          BNE    $4D8D
4D88: 5A             DECB
4D89: 26 71          BNE    $4D84
4D8B: 20 F8          BRA    $4D5D
4D8D: BD 27 49       JSR    $AFC1
4D90: BD 8D 2D       JSR    $AFAF
4D93: BD 7D 54       JSR    $5F76
4D96: 20 47          BRA    $4D5D
4D98: BD 7C 58       JSR    $54D0
4D9B: 0A 03          DEC    $2B
4D9D: 26 8C          BNE    $4DA3
4D9F: 0C 0A          INC    event_sub_state_28
4DA1: 0F A8          CLR    event_sub_state_2a
4DA3: 39             RTS

4DA4: 86 26          LDA    #$04
4DA6: 97 E7          STA    $65
4DA8: 96 31          LDA    $19
4DAA: 4C             INCA
4DAB: 84 2B          ANDA   #$03
4DAD: 97 91          STA    $19
4DAF: 8E 17 22       LDX    #$3500
4DB2: C6 A2          LDB    #$20
4DB4: 3D             MUL
4DB5: 30 09          LEAX   D,X
4DB7: A6 AC          LDA    ,X
4DB9: 27 8E          BEQ    $4DC1
4DBB: A6 2A          LDA    $2,X
4DBD: 91 F1          CMPA   $79
4DBF: 25 2B          BCS    $4DCA
4DC1: 0A E7          DEC    $65
4DC3: 26 C1          BNE    $4DA8
4DC5: 0C A4          INC    $26
4DC7: 0F 00          CLR    event_sub_state_28
4DC9: 39             RTS

4DCA: 86 89          LDA    #$01
4DCC: 97 0E          STA    $26
4DCE: 0F A0          CLR    event_sub_state_28
4DD0: 39             RTS

4DD1: 0F 9B          CLR    $19
4DD3: 86 26          LDA    #$04
4DD5: D6 98          LDB    $1A
4DD7: 27 20          BEQ    $4DE1
4DD9: 86 8A          LDA    #$02
4DDB: D6 33          LDB    $1B
4DDD: 27 8A          BEQ    $4DE1
4DDF: 97 3B          STA    $19
4DE1: 97 A1          STA    $23
4DE3: 0C 0A          INC    event_sub_state_28
4DE5: 39             RTS

4DE6: BD D0 89       JSR    $52A1
4DE9: 96 E4          LDA    $6C
4DEB: 26 3A          BNE    $4DFF
4DED: 8E BD 88       LDX    #$3500
4DF0: 96 3B          LDA    $19
4DF2: C6 A2          LDB    #$20
4DF4: 3D             MUL
4DF5: 30 09          LEAX   D,X
4DF7: A6 2C          LDA    $4,X
4DF9: 26 8C          BNE    $4DFF
4DFB: 6A 29          DEC    $1,X
4DFD: 27 8D          BEQ    $4E04
4DFF: 86 24          LDA    #$06
4E01: 97 AA          STA    event_sub_state_28
4E03: 39             RTS

4E04: 6F A6          CLR    ,X
4E06: 0C AA          INC    event_sub_state_28
4E08: 39             RTS

4E09: 0A AB          DEC    $23
4E0B: 27 2F          BEQ    $4E14
4E0D: 0C 91          INC    $19
4E0F: 86 26          LDA    #$04
4E11: 97 AA          STA    event_sub_state_28
4E13: 39             RTS

4E14: 96 38          LDA    $1A
4E16: 27 9B          BEQ    $4E31
4E18: 96 33          LDA    $1B
4E1A: 26 9D          BNE    $4E31
4E1C: 8E 1D C8       LDX    #$3540
4E1F: A6 A6          LDA    ,X
4E21: 26 87          BNE    $4E28
4E23: A6 AA 02       LDA    $20,X
4E26: 27 8B          BEQ    $4E31
4E28: 0C 33          INC    $1B
4E2A: 86 89          LDA    #$01
4E2C: 97 0E          STA    $26
4E2E: 0F A0          CLR    event_sub_state_28
4E30: 39             RTS

4E31: 0C A4          INC    $26
4E33: 0F 0A          CLR    event_sub_state_28
4E35: 39             RTS

4E36: 8E 51 D9       LDX   #table_d3f1
4E39: 96 A0          LDA    event_sub_state_28
4E3B: 48             ASLA
4E3C: 6E BE          JMP    [A,X]		; [jump_table]
4E3E: 8E BD 20       LDX    #$3502
4E41: 86 86          LDA    #$04
4E43: C6 2C          LDB    #$0E
4E45: 6F 02          CLR    ,X+
4E47: 5A             DECB
4E48: 26 D3          BNE    $4E45
4E4A: 30 00 3A       LEAX   $12,X
4E4D: 4A             DECA
4E4E: 26 7B          BNE    $4E43
4E50: 0C 0A          INC    event_sub_state_28
4E52: 39             RTS

4E53: 8E 17 22       LDX    #$3500
4E56: C6 86          LDB    #$04
4E58: 0F 60          CLR    $48
4E5A: A6 0C          LDA    ,X
4E5C: 26 3D          BNE    $4E73
4E5E: 30 00 02       LEAX   $20,X
4E61: 0C CA          INC    $48
4E63: 5A             DECB
4E64: 26 D6          BNE    $4E5A
4E66: 0C A2          INC    $20
4E68: 0F 0A          CLR    $22
4E6A: 0F AC          CLR    $24
4E6C: 0F 0E          CLR    $26
4E6E: 0F A0          CLR    event_sub_state_28
4E70: 0F 08          CLR    event_sub_state_2a
4E72: 39             RTS

4E73: 96 6A          LDA    $48
4E75: 97 9B          STA    $19
4E77: 0C 40          INC    current_level_68
4E79: 96 E0          LDA    current_level_68
4E7B: 81 2F          CMPA   #$07
4E7D: 27 8F          BEQ    $4E86
4E7F: 0F 04          CLR    $26
4E81: 0F AA          CLR    event_sub_state_28
4E83: 0F 08          CLR    event_sub_state_2a
4E85: 39             RTS

4E86: 96 8F          LDA    dsw2_copy_0d
4E88: 84 29          ANDA   #$01
4E8A: 26 7B          BNE    $4E7F
4E8C: 8E 1D 88       LDX    #$3500
4E8F: 4F             CLRA
4E90: 5F             CLRB
4E91: ED 03          STD    ,X++
4E93: 8C 17 A2       CMPX   #$3580
4E96: 26 7B          BNE    $4E91
4E98: 20 E4          BRA    $4E66


queue_event_4e9a:
4E9A: 10 9E 34       LDY    event_pointer_1c
4E9D: ED 29          STD    ,Y++
4E9F: 10 8C 11 C2    CMPY   #sound_queue_3340
4EA3: 26 26          BNE    $4EA9
4EA5: 10 8E B1 28    LDY    #$3300
4EA9: 10 9F 94       STY    event_pointer_1c
4EAC: 39             RTS


queue_sound_event_4ead:
4EAD: D6 85          LDB    dsw2_copy_0d
4EAF: C4 26          ANDB   #$04
4EB1: 26 86          BNE    $4EB7
force_queue_sound_event_4eb3:
4EB3: D6 22          LDB    game_playing_00
4EB5: 27 90          BEQ    $4EC9
4EB7: 10 9E 14       LDY    $3C
4EBA: A7 28          STA    ,Y+
4EBC: 10 8C BB E8    CMPY   #$3360
4EC0: 26 26          BNE    $4EC6
4EC2: 10 8E 11 62    LDY    #sound_queue_3340
4EC6: 10 9F 14       STY    $3C
4EC9: 39             RTS


4ECA: 8E B8 3B       LDX    #$3013
4ECD: CE B8 B8       LDU    #$3030
4ED0: 86 20          LDA    #$02
4ED2: 97 CA          STA    $48
4ED4: 96 4B          LDA    current_event_69
4ED6: 81 81          CMPA   #$03
4ED8: 26 20          BNE    $4EE2
4EDA: 96 92          LDA    $1A
4EDC: 27 2C          BEQ    $4EE2
4EDE: 33 CB          LEAU   $3,U
4EE0: 0A 6A          DEC    $48
4EE2: EC 06          LDD    ,X
4EE4: 84 25          ANDA   #$07
4EE6: C4 85          ANDB   #$07
4EE8: ED EC          STD    ,U
4EEA: EC 09          LDD    ,X++
4EEC: 44             LSRA
4EED: 44             LSRA
4EEE: 44             LSRA
4EEF: 44             LSRA
4EF0: 54             LSRB
4EF1: 54             LSRB
4EF2: 54             LSRB
4EF3: 54             LSRB
4EF4: ED 61          STD    $3,U
4EF6: A6 06          LDA    ,X
4EF8: 84 2F          ANDA   #$07
4EFA: A7 CA          STA    $2,U
4EFC: A6 A8          LDA    ,X+
4EFE: 44             LSRA
4EFF: 44             LSRA
4F00: 44             LSRA
4F01: 44             LSRA
4F02: A7 C7          STA    $5,U
4F04: 33 64          LEAU   $6,U
4F06: 0A CA          DEC    $48
4F08: 26 F0          BNE    $4EE2
4F0A: 96 E3          LDA    $6B
4F0C: 27 69          BEQ    $4F4F
4F0E: 86 8C          LDA    #$04
4F10: 97 6A          STA    $48
4F12: 8E B2 82       LDX    #$30A0
4F15: 10 8E B2 18    LDY    #$3030
4F19: CE 56 1B       LDU    #$DE93
4F1C: 96 27          LDA    $0F
4F1E: 84 97          ANDA   #$1F
4F20: 33 E4          LEAU   A,U
4F22: A6 8F          LDA    $D,X
4F24: 27 3E          BEQ    $4F42
4F26: EC 46          LDD    ,U
4F28: ED 8C          STD    ,Y
4F2A: A6 CA          LDA    $2,U
4F2C: A7 0A          STA    $2,Y
4F2E: 6D 00 7A       TST    $58,X
4F31: 27 8D          BEQ    $4F42
4F33: 6D AA 77       TST    $55,X
4F36: 26 88          BNE    $4F42
4F38: 96 27          LDA    $0F
4F3A: 84 B8          ANDA   #$30
4F3C: 26 2C          BNE    $4F42
4F3E: 86 8A          LDA    #$02
4F40: A7 86          STA    ,Y
4F42: 31 A1          LEAY   $3,Y
4F44: 33 EA 92       LEAU   $10,U
4F47: 30 A0 48       LEAX   $60,X
4F4A: 0A C0          DEC    $48
4F4C: 26 FC          BNE    $4F22
4F4E: 39             RTS

4F4F: 96 22          LDA    game_playing_00
4F51: 26 98          BNE    $4F6D
4F53: 96 4B          LDA    current_event_69
4F55: 81 83          CMPA   #$01
4F57: 27 3D          BEQ    $4F6E
4F59: 8E B8 B8       LDX    #$3030
4F5C: CE F6 6F       LDU    #$DEE7
4F5F: 96 2D          LDA    $0F
4F61: 84 8D          ANDA   #$0F
4F63: 33 E4          LEAU   A,U
4F65: EC 46          LDD    ,U
4F67: ED AC          STD    ,X
4F69: A6 CA          LDA    $2,U
4F6B: A7 2A          STA    $2,X
4F6D: 39             RTS

4F6E: 8E BB 4E       LDX    #$336C
4F71: 0F B2          CLR    $30
4F73: 6A 23          DEC    $1,X
4F75: 26 8C          BNE    $4F85
4F77: CE F6 D2       LDU    #$DEFA
4F7A: A6 0C          LDA    ,X
4F7C: 48             ASLA
4F7D: EC 4E          LDD    A,U
4F7F: 97 12          STA    $30
4F81: E7 83          STB    $1,X
4F83: 6C A6          INC    ,X
4F85: 0F B3          CLR    $31
4F87: 0F 1A          CLR    $32
4F89: 39             RTS

4F8A: CE B8 18       LDU    #$3030
4F8D: 96 91          LDA    $19
4F8F: D6 49          LDB    $6B
4F91: 26 84          BNE    $4F99
4F93: D6 38          LDB    $1A
4F95: 27 80          BEQ    $4F99
4F97: 84 29          ANDA   #$01
4F99: C6 8B          LDB    #$03
4F9B: 3D             MUL
4F9C: 33 E3          LEAU   D,U
4F9E: A6 4C          LDA    ,U
4FA0: 39             RTS

4FA1: CE B2 B2       LDU    #$3030
4FA4: 96 3B          LDA    $19
4FA6: D6 E9          LDB    $6B
4FA8: 26 2E          BNE    $4FB0
4FAA: D6 92          LDB    $1A
4FAC: 27 2A          BEQ    $4FB0
4FAE: 84 89          ANDA   #$01
4FB0: C6 21          LDB    #$03
4FB2: 3D             MUL
4FB3: 33 E9          LEAU   D,U
4FB5: A6 C0          LDA    $2,U
4FB7: AA 69          ORA    $1,U
4FB9: 43             COMA
4FBA: A4 4C          ANDA   ,U
4FBC: 39             RTS

4FBD: 8E BE 88       LDX    #$3600
4FC0: CE 32 82       LDU    #$1000
4FC3: EC A3          LDD    ,X++
4FC5: ED 43          STD    ,U++
4FC7: EC A9          LDD    ,X++
4FC9: ED 49          STD    ,U++
4FCB: 11 83 38 18    CMPU   #$1090
4FCF: 26 D0          BNE    $4FC3
4FD1: 39             RTS

4FD2: 8E B4 E2       LDX    #$36C0
4FD5: CE 92 42       LDU    #scroll_registers_10c0
4FD8: EC A9          LDD    ,X++
4FDA: ED 49          STD    ,U++
4FDC: EC A9          LDD    ,X++
4FDE: ED 49          STD    ,U++
4FE0: 11 83 93 82    CMPU   #$1100
4FE4: 26 D0          BNE    $4FD8
4FE6: 39             RTS

4FE7: 8E F0 CE       LDX    #$D8E6
4FEA: 96 E1          LDA    current_event_69
4FEC: C6 24          LDB    #$0C
4FEE: 3D             MUL
4FEF: 30 A9          LEAX   D,X
4FF1: CE B2 23       LDU    #$30A1
4FF4: 86 26          LDA    #$04
4FF6: 97 CA          STA    $48
4FF8: EC A9          LDD    ,X++
4FFA: ED 4C          STD    ,U
4FFC: A7 E0 94       STA    $1c,U
4FFF: 33 EA 42       LEAU   $60,U
5002: 0A CA          DEC    $48
5004: 26 D0          BNE    $4FF8
5006: EC 03          LDD    ,X++
5008: FD 1A A9       STD    $3221
500B: EC A9          LDD    ,X++
500D: FD BA C9       STD    $3241
5010: 39             RTS

5011: 8E 5B B8       LDX    #$D93A
5014: 96 4B          LDA    current_event_69
5016: 48             ASLA
5017: 48             ASLA
5018: 30 AE          LEAX   A,X
501A: CE B8 50       LDU    #$3078
501D: C6 8C          LDB    #$04
501F: A6 A2          LDA    ,X+
5021: A7 42          STA    ,U+
5023: 5A             DECB
5024: 26 DB          BNE    $501F
5026: 39             RTS

5027: 0F 94          CLR    $BC
5029: 4F             CLRA
502A: 5F             CLRB
502B: FD 1B 52       STD    $337A
502E: FD BB 5E       STD    $337C
5031: FD B1 FC       STD    $337E
5034: 39             RTS

5035: CE B2 36       LDU    #$30B4
5038: EE EC          LDU    ,U
503A: CC 8A 68       LDD    #$0240
503D: 33 43          LEAU   D,U
503F: A6 20          LDA    $2,X
5041: 84 7A          ANDA   #$F8
5043: 44             LSRA
5044: 44             LSRA
5045: 44             LSRA
5046: 27 8C          BEQ    $5056
5048: 33 69          LEAU   $1,U
504A: 11 83 00 28    CMPU   #$2800
504E: 26 8B          BNE    $5053
5050: CE 05 42       LDU    #$27C0
5053: 4A             DECA
5054: 26 D0          BNE    $5048
5056: 10 8E FB D1    LDY    #$D3F9
505A: 96 42          LDA    $CA
505C: A6 8E          LDA    A,Y
505E: A6 0E          LDA    A,X
5060: 84 DA          ANDA   #$F8
5062: 44             LSRA
5063: 44             LSRA
5064: 44             LSRA
5065: 27 84          BEQ    $506D
5067: 33 E0 E8       LEAU   -$40,U
506A: 4A             DECA
506B: 26 D2          BNE    $5067
506D: A6 8A          LDA    $2,X
506F: 84 25          ANDA   #$07
5071: 97 D2          STA    $50
5073: 10 8E 12 38    LDY    #$30BA
5077: A6 8C          LDA    ,Y
5079: 84 8F          ANDA   #$07
507B: 9B 78          ADDA   $50
507D: A7 00 93       STA    $1B,X
5080: 80 2A          SUBA   #$08
5082: 25 92          BCS    $5094
5084: A7 AA 99       STA    $1B,X
5087: 33 69          LEAU   $1,U
5089: 1F B8          TFR    U,D
508B: C5 17          BITB   #$3F
508D: 26 8B          BNE    $5092
508F: 83 22 62       SUBD   #$0040
5092: 1F 81          TFR    D,U
5094: 10 8E 51 79    LDY    #$D3FB
5098: 96 E2          LDA    $CA
509A: A6 2E          LDA    A,Y
509C: EF AE          STU    A,X
509E: 39             RTS

509F: A6 61          LDA    $3,U
50A1: 9B CA          ADDA   $48
50A3: 19             DAA
50A4: 97 68          STA    $4A
50A6: 84 8D          ANDA   #$0F
50A8: A7 6B          STA    $3,U
50AA: 96 C2          LDA    $4A
50AC: 44             LSRA
50AD: 44             LSRA
50AE: 44             LSRA
50AF: 44             LSRA
50B0: AB 60          ADDA   $2,U
50B2: 19             DAA
50B3: 97 68          STA    $4A
50B5: 84 8D          ANDA   #$0F
50B7: A7 6A          STA    $2,U
50B9: 96 C2          LDA    $4A
50BB: 44             LSRA
50BC: 44             LSRA
50BD: 44             LSRA
50BE: 44             LSRA
50BF: AB 63          ADDA   $1,U
50C1: 19             DAA
50C2: 97 C8          STA    $4A
50C4: 84 2D          ANDA   #$0F
50C6: A7 C3          STA    $1,U
50C8: 96 62          LDA    $4A
50CA: 84 98          ANDA   #$10
50CC: 27 2A          BEQ    $50D0
50CE: 6C 4C          INC    ,U
50D0: 39             RTS

50D1: A6 C0          LDA    $2,U
50D3: 9B 6A          ADDA   $48
50D5: 20 59          BRA    $50B2
50D7: A6 69          LDA    $1,U
50D9: 9B C0          ADDA   $48
50DB: 20 CC          BRA    l_50C1

50DD: A6 CB          LDA    $3,U
50DF: 90 6A          SUBA   $48
50E1: 25 81          BCS    $50E6
50E3: A7 61          STA    $3,U
50E5: 39             RTS

50E6: 8B 88          ADDA   #$0A
50E8: A7 6B          STA    $3,U
50EA: C6 81          LDB    #$09
50EC: 6A 6A          DEC    $2,U
50EE: A6 CA          LDA    $2,U
50F0: 81 DD          CMPA   #$FF
50F2: 26 98          BNE    $510E
50F4: E7 60          STB    $2,U
50F6: 6A C3          DEC    $1,U
50F8: A6 69          LDA    $1,U
50FA: 81 77          CMPA   #$FF
50FC: 26 38          BNE    $510E
50FE: E7 C9          STB    $1,U
5100: 6A E6          DEC    ,U
5102: A6 46          LDA    ,U
5104: 81 DD          CMPA   #$FF
5106: 26 84          BNE    $510E
5108: 4F             CLRA
5109: 5F             CLRB
510A: ED 4C          STD    ,U
510C: ED 6A          STD    $2,U
510E: 39             RTS

510F: A6 60          LDA    $2,U
5111: 90 CA          SUBA   $48
5113: 25 21          BCS    $5118
5115: A7 C0          STA    $2,U
5117: 39             RTS

5118: 8B 22          ADDA   #$0A
511A: A7 CA          STA    $2,U
511C: C6 21          LDB    #$09
511E: 20 5E          BRA    $50F6
5120: A6 63          LDA    $1,U
5122: 90 CA          SUBA   $48
5124: 25 21          BCS    $5129
5126: A7 C3          STA    $1,U
5128: 39             RTS

5129: 8B 82          ADDA   #$0A
512B: A7 69          STA    $1,U
512D: C6 81          LDB    #$09
512F: 20 ED          BRA    $5100
5131: A6 46          LDA    ,U
5133: 90 6A          SUBA   $48
5135: 25 53          BCS    $5108
5137: A7 EC          STA    ,U
5139: 39             RTS

513A: 5F             CLRB
513B: 81 22          CMPA   #$0A
513D: 25 8D          BCS    $5144
513F: 80 28          SUBA   #$0A
5141: 5C             INCB
5142: 20 75          BRA    $513B
5144: 39             RTS

5145: EC 81          LDD    $3,X
5147: C3 28 29       ADDD   #$0001
514A: C5 B7          BITB   #$3F
514C: 26 2B          BNE    $5151
514E: 83 88 62       SUBD   #$0040
5151: 1F 81          TFR    D,U
5153: 39             RTS

5154: 8E FB D4       LDX    #$D956
5157: 96 41          LDA    current_event_69
5159: 48             ASLA
515A: AE 0E          LDX    A,X
515C: CE 1A A6       LDU    #$322E
515F: EC A3          LDD    ,X++
5161: 81 7D          CMPA   #$FF
5163: 27 29          BEQ    $5170
5165: ED 46          STD    ,U
5167: A6 A8          LDA    ,X+
5169: A7 CA          STA    $2,U
516B: 33 E0 08       LEAU   $20,U
516E: 20 67          BRA    $515F
5170: 39             RTS

5171: 10 8E B1 F3    LDY    #$33D1
5175: A6 06          LDA    ,X
5177: 81 3E          CMPA   #$16
5179: 26 8B          BNE    $517E
517B: 8E 1B 58       LDX    #$3370
517E: 86 8C          LDA    #$04
5180: 97 6A          STA    $48
5182: BD D0 29       JSR    $520B
5185: 5D             TSTB
5186: 26 9C          BNE    $51A6
5188: A6 17          LDA    -$1,Y
518A: 84 87          ANDA   #$0F
518C: 4A             DECA
518D: 91 91          CMPA   $19
518F: 27 25          BEQ    $5198
5191: 31 A4          LEAY   $6,Y
5193: 0A 6A          DEC    $48
5195: 26 69          BNE    $5182
5197: 39             RTS

5198: A6 17          LDA    -$1,Y
519A: 84 A8          ANDA   #$20
519C: 27 2F          BEQ    $51A5
519E: 96 91          LDA    $19
51A0: 4C             INCA
51A1: 8A 92          ORA    #$10
51A3: A7 1D          STA    -$1,Y
51A5: 39             RTS

51A6: 1F A1          TFR    Y,U
51A8: 33 77          LEAU   -$1,U
51AA: 96 C0          LDA    $48
51AC: 97 61          STA    $49
51AE: A6 B7          LDA    -$1,Y
51B0: 84 2D          ANDA   #$0F
51B2: 4A             DECA
51B3: 91 3B          CMPA   $19
51B5: 27 84          BEQ    $51BD
51B7: 31 0E          LEAY   $6,Y
51B9: 0A C1          DEC    $49
51BB: 26 D9          BNE    $51AE
51BD: 96 C0          LDA    $48
51BF: 90 6B          SUBA   $49
51C1: 97 CA          STA    $48
51C3: 27 38          BEQ    $51DF
51C5: 4A             DECA
51C6: C6 84          LDB    #$06
51C8: 3D             MUL
51C9: 33 43          LEAU   D,U
51CB: 20 2A          BRA    $51CF
51CD: 33 D2          LEAU   -$6,U
51CF: EC E6          LDD    ,U
51D1: ED C4          STD    $6,U
51D3: EC 60          LDD    $2,U
51D5: ED CA          STD    $8,U
51D7: EC 6C          LDD    $4,U
51D9: ED C2          STD    $A,U
51DB: 0A 60          DEC    $48
51DD: 26 66          BNE    $51CD
51DF: 96 4B          LDA    current_event_69
51E1: 81 81          CMPA   #$03
51E3: 26 36          BNE    $51F9
51E5: 10 8E B7 2C    LDY    #$3504
51E9: 96 91          LDA    $19
51EB: C6 08          LDB    #$20
51ED: 3D             MUL
51EE: A6 23          LDA    D,Y
51F0: 27 25          BEQ    $51F9
51F2: 96 9B          LDA    $19
51F4: 4C             INCA
51F5: 8A 92          ORA    #$10
51F7: 20 2B          BRA    $51FC
51F9: 96 91          LDA    $19
51FB: 4C             INCA
51FC: A7 E8          STA    ,U+
51FE: EC 09          LDD    ,X++
5200: ED E3          STD    ,U++
5202: EC 03          LDD    ,X++
5204: ED E3          STD    ,U++
5206: A6 06          LDA    ,X
5208: A7 EC          STA    ,U
520A: 39             RTS

520B: 0F 45          CLR    $6D
520D: 5F             CLRB
520E: A6 2C          LDA    ,Y
5210: A1 A6          CMPA   ,X
5212: 25 A4          BCS    $523A
5214: 22 0B          BHI    $523F
5216: A6 A3          LDA    $1,Y
5218: A1 29          CMPA   $1,X
521A: 25 96          BCS    $523A
521C: 22 09          BHI    $523F
521E: A6 AA          LDA    $2,Y
5220: A1 20          CMPA   $2,X
5222: 25 94          BCS    $523A
5224: 22 3B          BHI    $523F
5226: A6 A1          LDA    $3,Y
5228: A1 2B          CMPA   $3,X
522A: 25 86          BCS    $523A
522C: 22 39          BHI    $523F
522E: A6 AC          LDA    $4,Y
5230: A1 26          CMPA   $4,X
5232: 25 84          BCS    $523A
5234: 22 2B          BHI    $523F
5236: 0C EF          INC    $6D
5238: 5C             INCB
5239: 39             RTS

523A: 96 F0          LDA    $78
523C: 27 D2          BEQ    $5238
523E: 39             RTS

523F: 96 5A          LDA    $78
5241: 26 77          BNE    $5238
5243: 39             RTS

5244: 0F 4D          CLR    $6F
5246: 8E B1 A8       LDX    #$3380
5249: 96 91          LDA    $19
524B: C6 27          LDB    #$0F
524D: 3D             MUL
524E: 30 03          LEAX   D,X
5250: 31 27          LEAY   $5,X
5252: 34 B2          PSHS   Y,X
5254: A6 A6          LDA    ,X
5256: 81 94          CMPA   #$16
5258: 27 27          BEQ    $5269
525A: E6 2C          LDB    ,Y
525C: C1 3E          CMPB   #$16
525E: 27 99          BEQ    $5271
5260: 86 27          LDA    #$05
5262: BD 24 E3       JSR    $A6C1
5265: 85 02          BITA   #$80
5267: 27 20          BEQ    $5271
5269: 35 B8          PULS   X,Y
526B: 30 2D          LEAX   $5,X
526D: 0C E7          INC    $6F
526F: 20 20          BRA    $5273
5271: 35 B2          PULS   X,Y
5273: 31 07          LEAY   $5,Y
5275: A6 06          LDA    ,X
5277: 81 3E          CMPA   #$16
5279: 27 87          BEQ    $528A
527B: E6 8C          LDB    ,Y
527D: C1 9E          CMPB   #$16
527F: 27 2F          BEQ    $528E
5281: 86 87          LDA    #$05
5283: BD 84 E3       JSR    $A6C1
5286: 85 02          BITA   #$80
5288: 27 2C          BEQ    $528E
528A: 86 8A          LDA    #$02
528C: 97 47          STA    $6F
528E: 39             RTS

528F: 8E 11 A2       LDX    #$3380
5292: 96 9B          LDA    $19
5294: C6 2D          LDB    #$0F
5296: 3D             MUL
5297: 30 A3          LEAX   D,X
5299: 96 E2          LDA    $6A
529B: C6 2D          LDB    #$05
529D: 3D             MUL
529E: 30 03          LEAX   D,X
52A0: 39             RTS

52A1: 8D 6E          BSR    $528F
52A3: 0F 4E          CLR    $6C
52A5: A6 06          LDA    ,X
52A7: 81 3E          CMPA   #$16
52A9: 27 84          BEQ    $52B7
52AB: 10 8E 18 E8    LDY    #$3060
52AF: BD 70 29       JSR    $520B
52B2: 5D             TSTB
52B3: 27 20          BEQ    $52B7
52B5: 0C EE          INC    $6C
52B7: 39             RTS

52B8: 8D A2          BSR    $5244
52BA: 8E BB A8       LDX    #$3380
52BD: 96 91          LDA    $19
52BF: C6 2D          LDB    #$0F
52C1: 3D             MUL
52C2: 30 09          LEAX   D,X
52C4: 96 4D          LDA    $6F
52C6: C6 87          LDB    #$05
52C8: 3D             MUL
52C9: 30 03          LEAX   D,X
52CB: 39             RTS

52CC: 96 28          LDA    game_playing_00
52CE: 27 89          BEQ    $52D1
52D0: 39             RTS

52D1: 96 8D          LDA    $0F
52D3: 84 32          ANDA   #$10
52D5: 27 90          BEQ    $52E9
52D7: CC 29 2B       LDD    #$0103
52DA: BD C6 B2       JSR    queue_event_4e9a
52DD: CC 8A 82       LDD    #$020A
52E0: BD 6C 18       JSR    queue_event_4e9a
52E3: CC 20 29       LDD    #$020B
52E6: 7E CC B2       JMP    queue_event_4e9a
52E9: CE A9 83       LDU    #$210B
52EC: C6 2C          LDB    #$04
52EE: 8D 8D          BSR    $52F5
52F0: CE 03 09       LDU    #$218B
52F3: C6 26          LDB    #$04
52F5: 86 92          LDA    #$10
52F7: 6F E1 20 88    CLR    $0800,U					;  [video_address]
52FB: A7 E8          STA    ,U+					;  [video_address]
52FD: 5A             DECB
52FE: 26 7F          BNE    $52F7
5300: 39             RTS

5301: 0F 2F          CLR    $AD
5303: 7F 13 2F       CLR    $310D
5306: 7F B3 45       CLR    $316D
5309: 7F B9 45       CLR    $31CD
530C: 0D 28          TST    game_playing_00
530E: 26 84          BNE    $531C
5310: 0C 8F          INC    $AD
5312: 7C B3 2F       INC    $310D
5315: 7C B3 EF       INC    $316D
5318: 7C 19 45       INC    $31CD
531B: 39             RTS

531C: 8E 1D 88       LDX    #$3500
531F: 96 3B          LDA    $19
5321: C6 A2          LDB    #$20
5323: 3D             MUL
5324: 30 A9          LEAX   D,X
5326: CE B2 A8       LDU    #$3080
5329: A6 8A          LDA    $2,X
532B: 97 42          STA    $6A
532D: EC 09          LDD    ,X++
532F: ED E3          STD    ,U++
5331: 11 83 B2 B2    CMPU   #$3090
5335: 26 74          BNE    $532D
5337: 39             RTS

5338: 8E 1D 88       LDX    #$3500
533B: CE 18 88       LDU    #$30A0
533E: 96 92          LDA    $1A
5340: 27 31          BEQ    $5355
5342: 0C 2F          INC    $AD
5344: 7C 13 4F       INC    $31CD
5347: 33 E0 48       LEAU   $60,U
534A: 96 93          LDA    $1B
534C: 27 2B          BEQ    $5351
534E: 30 00 62       LEAX   $40,X
5351: 86 80          LDA    #$02
5353: 20 20          BRA    $5357
5355: 86 86          LDA    #$04
5357: 97 60          STA    $48
5359: A6 0C          LDA    ,X
535B: 27 2C          BEQ    $5361
535D: A6 8C          LDA    $4,X
535F: 27 24          BEQ    $5367
5361: 86 83          LDA    #$01
5363: A7 6F          STA    $D,U
5365: A7 86          STA    $4,X
5367: 30 A0 08       LEAX   $20,X
536A: 33 40 48       LEAU   $60,U
536D: 0A C0          DEC    $48
536F: 26 CA          BNE    $5359
5371: 39             RTS

5372: 10 8E ED C7    LDY    #$CFE5
5376: 96 9B          LDA    $19
5378: A6 8E          LDA    A,Y
537A: 97 D8          STA    $50
537C: 20 2A          BRA    $5380
537E: 0F D8          CLR    $50
5380: 10 8E B1 E2    LDY    #$3360
5384: 96 3B          LDA    $19
5386: C6 81          LDB    #$03
5388: 3D             MUL
5389: 31 23          LEAY   D,Y
538B: D6 78          LDB    $50
538D: A6 28          LDA    ,Y+
538F: BD 60 0F       JSR    $422D
5392: A6 22          LDA    ,Y+
5394: BD 60 AF       JSR    $422D
5397: A6 88          LDA    ,Y+
5399: 7E CA A5       JMP    $422D
539C: 96 28          LDA    game_playing_00
539E: 27 9B          BEQ    $53B3
53A0: 8E 11 02       LDX    #$3380
53A3: 0F 6A          CLR    $48
53A5: 96 EB          LDA    current_event_69
53A7: 81 2D          CMPA   #$05
53A9: 27 81          BEQ    $53B4
53AB: 81 2E          CMPA   #$06
53AD: 27 8D          BEQ    $53B4
53AF: 81 22          CMPA   #$00
53B1: 27 83          BEQ    $53B4
53B3: 39             RTS

53B4: CE 04 18       LDU    #$269A
53B7: 96 42          LDA    $6A
53B9: C6 C8          LDB    #$40
53BB: 3D             MUL
53BC: 33 E3          LEAU   D,U
53BE: BD DC 5E       JSR    $547C
53C1: 0F C8          CLR    $4A
53C3: A6 A6          LDA    ,X
53C5: 81 94          CMPA   #$16
53C7: 26 2F          BNE    $53D0
53C9: 0C C0          INC    $48
53CB: 8E FD 35       LDX    #$D51D
53CE: 20 9A          BRA    $53E2
53D0: 96 4B          LDA    current_event_69
53D2: 81 82          CMPA   #$00
53D4: 27 28          BEQ    $53E0
53D6: 81 84          CMPA   #$06
53D8: 27 2E          BEQ    $53E0
53DA: 81 8C          CMPA   #$04
53DC: 26 2C          BNE    $53E2
53DE: 0C C2          INC    $4A
53E0: 30 23          LEAX   $1,X
53E2: 0F CB          CLR    $49
53E4: A6 A2          LDA    ,X+
53E6: 26 86          BNE    $53EC
53E8: 0C 61          INC    $49
53EA: 86 98          LDA    #$10
53EC: BD 6A A4       JSR    write_char_and_move_cursor_422c
53EF: A6 A2          LDA    ,X+
53F1: 26 88          BNE    $53FD
53F3: 0D 68          TST    $4A
53F5: 26 84          BNE    $53FD
53F7: 0D 61          TST    $49
53F9: 27 8A          BEQ    $53FD
53FB: 86 38          LDA    #$10
53FD: BD CA A4       JSR    write_char_and_move_cursor_422c
5400: 96 6A          LDA    $48
5402: 26 88          BNE    $540E
5404: 96 4B          LDA    current_event_69
5406: 81 82          CMPA   #$00
5408: 27 20          BEQ    $5412
540A: 81 8E          CMPA   #$06
540C: 27 20          BEQ    $5416
540E: A6 08          LDA    ,X+
5410: 20 24          BRA    $5418
5412: 86 08          LDA    #$8A
5414: 20 20          BRA    $5418
5416: 86 A9          LDA    #$2B
5418: BD 6A A4       JSR    write_char_and_move_cursor_422c
541B: 86 A4          LDA    #$8C
541D: 0D C0          TST    $48
541F: 26 24          BNE    $5427
5421: D6 EB          LDB    current_event_69
5423: C1 26          CMPB   #$04
5425: 27 80          BEQ    $5429
5427: A6 A8          LDA    ,X+
5429: BD CA A4       JSR    write_char_and_move_cursor_422c
542C: A6 A8          LDA    ,X+
542E: 7E CA 0E       JMP    write_char_and_move_cursor_422c
5431: 96 EB          LDA    current_event_69
5433: 81 20          CMPA   #$02
5435: 27 86          BEQ    $543B
5437: 81 2B          CMPA   #$03
5439: 26 89          BNE    $543C
543B: 39             RTS

543C: 8E 1B 08       LDX    #$3380
543F: 96 3B          LDA    $19
5441: C6 8D          LDB    #$0F
5443: 3D             MUL
5444: 30 A9          LEAX   D,X
5446: CE A4 B2       LDU    #$269A
5449: 96 E2          LDA    $6A
544B: 97 63          STA    $4B
544D: 27 9A          BEQ    $5461
544F: 34 32          PSHS   X
5451: 0F CA          CLR    $48
5453: BD 71 E3       JSR    $53C1
5456: 35 92          PULS   X
5458: 30 2D          LEAX   $5,X
545A: 33 40 13       LEAU   $3B,U
545D: 0A C3          DEC    $4B
545F: 26 CC          BNE    $544F
5461: C6 87          LDB    #$05
5463: 7E 70 D7       JMP    $52F5

5466: 8E B1 A8       LDX    #$3380
5469: CE B8 13       LDU    #$309B
546C: BD 7C F4       JSR    $547C
546F: EC E6          LDD    ,U
5471: ED 06          STD    ,X
5473: EC 60          LDD    $2,U
5475: ED 80          STD    $2,X
5477: A6 6C          LDA    $4,U
5479: A7 8C          STA    $4,X
547B: 39             RTS

547C: 96 31          LDA    $19
547E: C6 87          LDB    #$0F
5480: 3D             MUL
5481: 30 09          LEAX   D,X
5483: 96 48          LDA    $6A
5485: C6 87          LDB    #$05
5487: 3D             MUL
5488: 30 A3          LEAX   D,X
548A: 39             RTS

548B: CE 1D 28       LDU    #$3500
548E: 96 91          LDA    $19
5490: C6 02          LDB    #$20
5492: 3D             MUL
5493: 33 E9          LEAU   D,U
5495: A6 46          LDA    ,U
5497: 27 3C          BEQ    $54AD
5499: 96 E1          LDA    current_event_69
549B: 81 2B          CMPA   #$03
549D: 26 8C          BNE    $54A3
549F: A6 66          LDA    $4,U
54A1: 26 88          BNE    $54AD
54A3: 8E 16 02       LDX    #$3420
54A6: 96 9B          LDA    $19
54A8: C6 38          LDB    #$10
54AA: 3D             MUL
54AB: 6C A3          INC    D,X
54AD: 39             RTS

54AE: 8E BC 22       LDX    #$3400
54B1: CE 51 7F       LDU    #$D3FD
54B4: 96 3B          LDA    $19
54B6: D6 98          LDB    $1A
54B8: 27 2B          BEQ    $54BD
54BA: 84 89          ANDA   #$01
54BC: 4C             INCA
54BD: 48             ASLA
54BE: EC 4E          LDD    A,U
54C0: ED 23          STD    $1,X
54C2: 39             RTS

54C3: 8E 14 22       LDX    #$3600
54C6: 4F             CLRA
54C7: 5F             CLRB
54C8: ED A9          STD    ,X++
54CA: 8C BE 34       CMPX   #$361C
54CD: 26 71          BNE    $54C8
54CF: 39             RTS

54D0: CE 08 C8       LDU    #$2A4A
54D3: 86 23          LDA    #$01
54D5: D6 8D          LDB    $0F
54D7: C4 38          ANDB   #$10
54D9: 27 89          BEQ    $54DC
54DB: 4F             CLRA
54DC: C6 2B          LDB    #$03
54DE: D7 C0          STB    $48
54E0: C6 2E          LDB    #$0C
54E2: A7 42          STA    ,U+		; [video_address]
54E4: 5A             DECB
54E5: 26 79          BNE    $54E2
54E7: 33 E0 1C       LEAU   $34,U
54EA: 0A C0          DEC    $48
54EC: 26 DA          BNE    $54E0
54EE: 96 87          LDA    $0F
54F0: 84 32          ANDA   #$10
54F2: 26 93          BNE    $5505
54F4: 10 8E 4D 67    LDY    #$CFE5
54F8: 96 31          LDA    $19
54FA: A6 2E          LDA    A,Y
54FC: CE 02 DB       LDU    #$2A53
54FF: A7 E2          STA    ,U+		; [video_address]
5501: A7 42          STA    ,U+		; [video_address]
5503: A7 E2          STA    ,U+		; [video_address]
5505: 39             RTS

5506: CE A9 6A       LDU    #$2B42
5509: 86 89          LDA    #$01
550B: D6 27          LDB    $0F
550D: C4 98          ANDB   #$10
550F: 27 23          BEQ    $5512
5511: 4F             CLRA
5512: C6 87          LDB    #$05
5514: D7 6A          STB    $48
5516: C6 8A          LDB    #$08
5518: A7 E8          STA    ,U+		; [video_address]
551A: 5A             DECB
551B: 26 D3          BNE    $5518
551D: 33 40 B0       LEAU   $38,U
5520: 0A 6A          DEC    $48
5522: 26 70          BNE    $5516
5524: 96 2D          LDA    $0F
5526: 84 92          ANDA   #$10
5528: 26 39          BNE    $553B
552A: 10 8E E7 CD    LDY    #$CFE5
552E: 96 91          LDA    $19
5530: A6 84          LDA    A,Y
5532: CE A9 E6       LDU    #$2BC4
5535: A7 42          STA    ,U+   ; [video_address]
5537: A7 E8          STA    ,U+   ; [video_address]
5539: A7 48          STA    ,U+   ; [video_address]
553B: 39             RTS

553C: 8E 1C 10       LDX    #$3498
553F: 4F             CLRA
5540: 5F             CLRB
5541: ED 03          STD    ,X++
5543: 8C 16 8A       CMPX   #$34A8
5546: 26 7B          BNE    $5541
5548: 86 29          LDA    #$01
554A: 97 C0          STA    $48
554C: 8E 1C 08       LDX    #$3480
554F: CE 16 BA       LDU    #$3498
5552: A7 46          STA    ,U
5554: EC A6          LDD    ,X
5556: ED C3          STD    $1,U
5558: A6 2A          LDA    $2,X
555A: A7 CB          STA    $3,U
555C: 96 29          LDA    $01
555E: 97 C5          STA    $4D
5560: 27 73          BEQ    $55B3
5562: 96 CA          LDA    $48
5564: 97 6B          STA    $49
5566: 0F C8          CLR    $4A
5568: 10 8E BC 11    LDY    #$3499
556C: 30 2B          LEAX   $3,X
556E: 34 B8          PSHS   Y,X
5570: 86 21          LDA    #$03
5572: BD 24 E3       JSR    $A6C1
5575: 35 B2          PULS   X,Y
5577: 81 29          CMPA   #$01
5579: 27 86          BEQ    $5589
557B: 0C 62          INC    $4A
557D: 31 AC          LEAY   $4,Y
557F: 0A 6B          DEC    $49
5581: 26 69          BNE    $556E
5583: 31 1D          LEAY   -$1,Y
5585: 1F A1          TFR    Y,U
5587: 20 3F          BRA    $55A0
5589: 86 8B          LDA    #$03
558B: 90 62          SUBA   $4A
558D: 97 C4          STA    $4C
558F: CE 16 86       LDU    #$34A4
5592: 33 DE          LEAU   -$4,U
5594: EC E6          LDD    ,U
5596: ED C6          STD    $4,U
5598: EC 6A          LDD    $2,U
559A: ED CE          STD    $6,U
559C: 0A 64          DEC    $4C
559E: 26 7A          BNE    $5592
55A0: 96 6A          LDA    $48
55A2: 4C             INCA
55A3: A7 E6          STA    ,U
55A5: A6 06          LDA    ,X
55A7: A7 69          STA    $1,U
55A9: EC 89          LDD    $1,X
55AB: ED 6A          STD    $2,U
55AD: 0C C0          INC    $48
55AF: 0A 6F          DEC    $4D
55B1: 26 2D          BNE    $5562
55B3: 39             RTS

55B4: 8E 12 22       LDX    #$30A0
55B7: CE FC 2D       LDU   #table_d405
55BA: 96 E1          LDA    current_event_69
55BC: 48             ASLA
55BD: 6E 5E          JMP    [A,U]		; [jump_table]
55BF: 7E A0 85       JMP    $82A7
55C2: 86 86          LDA    #$04
55C4: 97 6A          STA    $48
55C6: 0F 9B          CLR    $19
55C8: BD AC 5E       JSR    $84D6
55CB: 0C 31          INC    $19
55CD: 30 00 E8       LEAX   $60,X
55D0: 0A 6A          DEC    $48
55D2: 26 76          BNE    $55C8
55D4: 39             RTS

55D5: BD 00 25       JSR    $82A7
55D8: 86 2C          LDA    #$04
55DA: 97 C0          STA    $48
55DC: CC 88 A8       LDD    #$A020
55DF: 8E 10 42       LDX    #$3260
55E2: 34 84          PSHS   D
55E4: 6C A6          INC    ,X
55E6: ED 83          STD    $1,X
55E8: 35 2E          PULS   D
55EA: CB C8          ADDB   #$40
55EC: 30 A0 A8       LEAX   $20,X
55EF: 0A 6A          DEC    $48
55F1: 26 6D          BNE    $55E2
55F3: 8E 10 42       LDX    #$3260
55F6: BD 07 88       JSR    $85A0
55F9: 8E BA 48       LDX    #$32C0
55FC: BD AD 28       JSR    $85A0
55FF: 39             RTS

5600: 96 3B          LDA    $19
5602: 97 F5          STA    $77
5604: 0F 3B          CLR    $19
5606: CE A4 6C       LDU    #$2644
5609: 8E BD 88       LDX    #$3500
560C: 86 2C          LDA    #$04
560E: D6 92          LDB    $1A
5610: 27 34          BEQ    $5628
5612: 86 80          LDA    #$02
5614: D6 39          LDB    $1B
5616: 27 92          BEQ    $5628
5618: 30 A0 C8       LEAX   $40,X
561B: 97 31          STA    $19
561D: F6 BB 59       LDB    $33D1
5620: C1 32          CMPB   #$10
5622: 27 86          BEQ    $5628
5624: 33 EB 82 02    LEAU   $0080,U
5628: 97 60          STA    $48
562A: B7 B9 15       STA    $313D
562D: FF B9 B6       STU    $313E
5630: 10 8E 4D 67    LDY    #$CFE5
5634: 96 3B          LDA    $19
5636: A6 24          LDA    A,Y
5638: 97 61          STA    $49
563A: 10 8E 1B 48    LDY    #$3360
563E: 96 91          LDA    $19
5640: C6 21          LDB    #$03
5642: 3D             MUL
5643: 31 89          LEAY   D,Y
5645: A6 86          LDA    $4,X
5647: 27 2E          BEQ    $564F
5649: 0F C1          CLR    $49
564B: 10 8E E7 5E    LDY    #$CFD6
564F: D6 6B          LDB    $49
5651: 96 9B          LDA    $19
5653: 4C             INCA
5654: BD 60 AF       JSR    $422D
5657: 86 08          LDA    #$20
5659: BD CA A5       JSR    $422D
565C: 33 69          LEAU   $1,U
565E: A6 28          LDA    ,Y+
5660: BD 60 AF       JSR    $422D
5663: A6 82          LDA    ,Y+
5665: BD C0 AF       JSR    $422D
5668: A6 88          LDA    ,Y+
566A: BD CA 05       JSR    $422D
566D: 33 C9          LEAU   $1,U
566F: 0F 68          CLR    $4A
5671: A6 81          LDA    $3,X
5673: 27 2C          BEQ    $5683
5675: 97 C9          STA    $4B
5677: CC CA AB       LDD    #$E283
567A: BD CA 05       JSR    $422D
567D: 0C C2          INC    $4A
567F: 0A 69          DEC    $4B
5681: 26 75          BNE    $567A
5683: 86 20          LDA    #$02
5685: 90 C8          SUBA   $4A
5687: 27 24          BEQ    $5695
5689: 97 C3          STA    $4B
568B: CC CA A8       LDD    #$E280
568E: BD CA 0F       JSR    $422D
5691: 0A C9          DEC    $4B
5693: 26 DB          BNE    $568E
5695: 0C 9B          INC    $19
5697: 33 E0 1F       LEAU   $37,U
569A: 30 00 08       LEAX   $20,X
569D: 0A C0          DEC    $48
569F: 26 AD          BNE    $5630
56A1: 96 F5          LDA    $77
56A3: 97 3B          STA    $19
56A5: 39             RTS

56A6: 96 EB          LDA    current_event_69
56A8: 81 2A          CMPA   #$02
56AA: 27 A7          BEQ    $56DB
56AC: 81 2B          CMPA   #$03
56AE: 27 A3          BEQ    $56DB
56B0: 96 22          LDA    game_playing_00
56B2: 27 A5          BEQ    $56DB
56B4: CE 04 17       LDU    #$2695
56B7: 8E FC 3B       LDX    #$D413
56BA: 86 8B          LDA    #$03
56BC: D6 41          LDB    current_event_69
56BE: C1 8C          CMPB   #$04
56C0: 26 23          BNE    $56C3
56C2: 4A             DECA
56C3: 97 6B          STA    $49
56C5: 86 87          LDA    #$05
56C7: 97 60          STA    $48
56C9: C6 08          LDB    #$80
56CB: A6 A8          LDA    ,X+
56CD: BD CA A5       JSR    $422D
56D0: 0A 6A          DEC    $48
56D2: 26 75          BNE    $56CB
56D4: 33 EA B9       LEAU   $3B,U
56D7: 0A 61          DEC    $49
56D9: 26 62          BNE    $56C5
56DB: 39             RTS

56DC: CE 0E DB       LDU    #$2653
56DF: 96 49          LDA    $6B
56E1: 26 80          BNE    $56E5
56E3: 33 60          LEAU   $2,U
56E5: 96 8D          LDA    $0F
56E7: 84 38          ANDA   #$10
56E9: 27 9B          BEQ    $56FE
56EB: 8E FC 0A       LDX    #$D422
56EE: 86 8D          LDA    #$05
56F0: 97 6A          STA    $48
56F2: C6 02          LDB    #$80
56F4: A6 A2          LDA    ,X+
56F6: BD C0 05       JSR    $422D
56F9: 0A C0          DEC    $48
56FB: 26 DF          BNE    $56F4
56FD: 39             RTS

56FE: C6 8D          LDB    #$05
5700: 7E 70 77       JMP    $52F5
5703: 8E 1A 22       LDX    #$3800
5706: 96 EB          LDA    current_event_69
5708: C6 08          LDB    #$20
570A: 3D             MUL
570B: 30 A3          LEAX   D,X
570D: 86 82          LDA    #$0A
570F: 97 57          STA    $75
5711: 0F CA          CLR    $48
5713: CE 03 36       LDU    #$2114
5716: 8D A8          BSR    $5742
5718: 34 68          PSHS   U
571A: 96 C0          LDA    $48
571C: C6 68          LDB    #$40
571E: 3D             MUL
571F: 33 E9          LEAU   D,U
5721: BD C1 5A       JSR    $43D8
5724: 33 63          LEAU   $1,U
5726: A6 87          LDA    $5,X
5728: BD 6A A5       JSR    $422D
572B: A6 2E          LDA    $6,X
572D: BD CA A5       JSR    $422D
5730: A6 25          LDA    $7,X
5732: BD C0 0F       JSR    $422D
5735: 35 C2          PULS   U
5737: 30 20          LEAX   $8,X
5739: 0C C0          INC    $48
573B: 96 60          LDA    $48
573D: 81 8B          CMPA   #$03
573F: 26 F5          BNE    $5718
5741: 39             RTS

5742: 10 8E F6 05    LDY    #$D427
5746: 96 EB          LDA    current_event_69
5748: A6 8E          LDA    A,Y
574A: 33 4E          LEAU   A,U
574C: 39             RTS

574D: 8E 5C A6       LDX    #$D42E
5750: 96 4B          LDA    current_event_69
5752: 81 84          CMPA   #$06
5754: 27 3D          BEQ    $5775
5756: 81 80          CMPA   #$02
5758: 27 2F          BEQ    $5761
575A: 8E 5C 1D       LDX    #$D435
575D: 81 8B          CMPA   #$03
575F: 26 31          BNE    $5774
5761: A6 02          LDA    ,X+
5763: 81 DD          CMPA   #$FF
5765: 27 8F          BEQ    $5774
5767: CE 1E 28       LDU    #$3600
576A: C6 8C          LDB    #$04
576C: 3D             MUL
576D: 33 43          LEAU   D,U
576F: BD AB EB       JSR    $89C9
5772: 20 6F          BRA    $5761
5774: 39             RTS

5775: 86 86          LDA    #$04
5777: 97 60          STA    $48
5779: 0F C1          CLR    $49
577B: 8E 1A 48       LDX    #$3260
577E: A6 8A          LDA    $2,X
5780: 81 1B          CMPA   #$39
5782: 25 93          BCS    $5795
5784: 81 9A          CMPA   #$B8
5786: 24 8F          BCC    $5795
5788: CE 1E B0       LDU    #$3638
578B: 96 61          LDA    $49
578D: 48             ASLA
578E: 48             ASLA
578F: 48             ASLA
5790: 33 E4          LEAU   A,U
5792: BD 0B E0       JSR    $89C2
5795: 0C CB          INC    $49
5797: 30 A0 08       LEAX   $20,X
579A: 0A C0          DEC    $48
579C: 26 C8          BNE    $577E
579E: 39             RTS

579F: 7C 16 D3       INC    $34F1
57A2: B6 B6 D3       LDA    $34F1
57A5: 81 9D          CMPA   #$1F
57A7: 26 2E          BNE    $57AF
57A9: 7F BC 79       CLR    $34F1
57AC: 7C 1C 7A       INC    $34F2
57AF: 39             RTS

57B0: 96 4B          LDA    current_event_69
57B2: 81 81          CMPA   #$03
57B4: 27 1B          BEQ    $57EF
57B6: 81 87          CMPA   #$05
57B8: 27 1D          BEQ    $57EF
57BA: 81 89          CMPA   #$01
57BC: 27 19          BEQ    $57EF
57BE: 86 86          LDA    #$0E
57C0: D6 2D          LDB    $0F
57C2: C4 8A          ANDB   #$08
57C4: 26 20          BNE    $57C8
57C6: 86 8D          LDA    #$0F
57C8: D6 41          LDB    current_event_69
57CA: C1 8E          CMPB   #$06
57CC: 27 0A          BEQ    $57F0
57CE: C1 8C          CMPB   #$04
57D0: 27 3C          BEQ    $57F0
57D2: CE A9 62       LDU    #$2B40
57D5: A7 42          STA    ,U+		; [video_address]
57D7: 11 83 04 C8    CMPU   #$2C40
57DB: 26 D0          BNE    $57D5
57DD: CE A3 20       LDU    #$2BA8
57E0: 86 21          LDA    #$03
57E2: C6 85          LDB    #$07
57E4: 6F E2          CLR    ,U+		; [video_address]
57E6: 5A             DECB
57E7: 26 D3          BNE    $57E4
57E9: 33 40 B1       LEAU   $39,U
57EC: 4A             DECA
57ED: 26 7B          BNE    $57E2
57EF: 39             RTS

57F0: CE 09 82       LDU    #$2B00
57F3: A7 E2          STA    ,U+
57F5: 11 83 A9 E8    CMPU   #$2BC0
57F9: 26 70          BNE    $57F3
57FB: 39             RTS

57FC: 96 28          LDA    game_playing_00
57FE: 27 9E          BEQ    $5816
5800: 0F B2          CLR    $90
5802: 8E B1 F2       LDX    #$33D0
5805: 96 9B          LDA    $19
5807: 4C             INCA
5808: A1 AC          CMPA   ,X
580A: 27 82          BEQ    $5816
580C: 6D AC          TST    ,X
580E: 27 8F          BEQ    $5817
5810: 0C B2          INC    $90
5812: 30 84          LEAX   $6,X
5814: 20 D0          BRA    $5808
5816: 39             RTS

5817: BD 70 04       JSR    $582C
581A: 33 CB          LEAU   $3,U
581C: BD 7B FA       JSR    $5372
581F: 33 78          LEAU   -$6,U
5821: 96 9B          LDA    $19
5823: 4C             INCA
5824: BD 60 AF       JSR    $422D
5827: 86 08          LDA    #$20
5829: 7E CA A5       JMP    $422D
582C: 96 28          LDA    game_playing_00
582E: 27 AC          BEQ    $5854
5830: 96 4B          LDA    current_event_69
5832: 81 81          CMPA   #$03
5834: 27 3C          BEQ    $5854
5836: CE A4 6B       LDU    #$2643
5839: 96 18          LDA    $90
583B: C6 68          LDB    #$40
583D: 3D             MUL
583E: 33 43          LEAU   D,U
5840: 96 2D          LDA    $0F
5842: 84 92          ANDA   #$10
5844: 27 27          BEQ    $584B
5846: CC 9A AB       LDD    #$1883
5849: 20 8B          BRA    $584E
584B: CC 38 28       LDD    #$1000
584E: E7 41 2A 22    STB    $0800,U					;  [video_address]
5852: A7 42          STA    ,U+					;  [video_address]
5854: 39             RTS

5855: CE A4 C1       LDU    #$2643
5858: 86 38          LDA    #$10
585A: C6 8C          LDB    #$04
585C: 6F E1 80 88    CLR    $0800,U					;  [video_address]
5860: A7 E6          STA    ,U					;  [video_address]
5862: 33 4A 62       LEAU   $40,U
5865: 5A             DECB
5866: 26 76          BNE    $585C
5868: 39             RTS

5869: BD D0 08       JSR    $5880
586C: 4D             TSTA
586D: 27 98          BEQ    $587F
586F: 86 23          LDA    #$01
5871: 97 A2          STA    $20
5873: 97 00          STA    $22
5875: 0F A6          CLR    $24
5877: 0F 0E          CLR    $26
5879: 0F A0          CLR    event_sub_state_28
587B: 0F 02          CLR    event_sub_state_2a
587D: 86 89          LDA    #$01
587F: 39             RTS

5880: D6 21          LDB    $03
5882: 86 83          LDA    #$01
5884: 97 6A          STA    $48
5886: 96 92          LDA    $10
5888: 85 20          BITA   #$08
588A: 26 90          BNE    $58A4
588C: 0C 60          INC    $48
588E: 85 98          BITA   #$10
5890: 26 30          BNE    $58A4
5892: 0C CA          INC    $48
5894: 96 31          LDA    $13
5896: 84 8A          ANDA   #$08
5898: 26 22          BNE    $58A4
589A: 0C C0          INC    $48
589C: 96 3E          LDA    $16
589E: 84 80          ANDA   #$08
58A0: 26 20          BNE    $58A4
58A2: 4F             CLRA
58A3: 39             RTS

58A4: D0 6A          SUBB   $48
58A6: 25 78          BCS    $58A2
58A8: D7 2B          STB    $03
58AA: 96 C0          LDA    $48
58AC: 4A             DECA
58AD: 97 89          STA    $01
58AF: 4F             CLRA
58B0: BD 6C 35       JSR    $4EB7
58B3: 86 62          LDA    #$40
58B5: BD CC 35       JSR    $4EB7
58B8: 86 29          LDA    #$01
58BA: 39             RTS

58BB: A6 A0 08       LDA    $20,X
58BE: 27 BB          BEQ    $58F3
58C0: AB 2D          ADDA   $F,X
58C2: 24 80          BCC    $58C6
58C4: 6C 2C          INC    $E,X
58C6: A7 8D          STA    $F,X
58C8: 96 ED          LDA    $C5
58CA: 26 A0          BNE    $58F4
58CC: A6 2A          LDA    $2,X
58CE: AB 00 02       ADDA   $20,X
58D1: 81 02          CMPA   #$80
58D3: 25 2C          BCS    $58E3
58D5: 80 02          SUBA   #$80
58D7: A7 A0 0F       STA    $27,X
58DA: 0C 4D          INC    $C5
58DC: 86 A8          LDA    #$80
58DE: A7 8A          STA    $2,X
58E0: 7E 7B 8C       JMP    $590E
58E3: A6 AA 02       LDA    $20,X
58E6: 97 CE          STA    $4C
58E8: AB 2A          ADDA   $2,X
58EA: A7 8A          STA    $2,X
58EC: BD AA 3F       JSR    $82B7
58EF: 0A 6E          DEC    $4C
58F1: 26 7B          BNE    $58EC
58F3: 39             RTS

58F4: A6 20          LDA    $2,X
58F6: 91 F8          CMPA   $7A
58F8: 27 23          BEQ    $5905
58FA: 6A 8A          DEC    $2,X
58FC: A6 A0 A8       LDA    $20,X
58FF: 4C             INCA
5900: 6C AA A4       INC    $26,X
5903: 20 24          BRA    $590B
5905: A6 0A A2       LDA    $20,X
5908: 6F A0 AE       CLR    $26,X
590B: A7 A0 0F       STA    $27,X
590E: 96 4F          LDA    $C7
5910: 27 4D          BEQ    $5981
5912: 97 CA          STA    $48
5914: 97 6B          STA    $49
5916: 97 C9          STA    $4B
5918: CE FC B1       LDU    #$D439
591B: 96 41          LDA    current_event_69
591D: 81 8E          CMPA   #$06
591F: 26 20          BNE    $5923
5921: 0F C9          CLR    $4B
5923: 48             ASLA
5924: 10 AE 44       LDY    A,U
5927: 34 08          PSHS   Y
5929: CE BE 50       LDU    #$36D8
592C: 96 92          LDA    $BA
592E: E6 28          LDB    ,Y+
5930: C1 DD          CMPB   #$FF
5932: 27 A4          BEQ    $595A
5934: A4 1D          ANDA   -$1,Y
5936: 26 A0          BNE    $595A
5938: D6 41          LDB    current_event_69
593A: C1 8E          CMPB   #$06
593C: 26 20          BNE    $5946
593E: 11 83 14 FA    CMPU   #$36D8
5942: 26 80          BNE    $5946
5944: 0C 69          INC    $4B
5946: 0D 80          TST    $02
5948: 26 20          BNE    $5952
594A: 6C 4C          INC    ,U
594C: 26 24          BNE    $595A
594E: 6C C9          INC    $1,U
5950: 20 2A          BRA    $595A
5952: 6D 46          TST    ,U
5954: 26 20          BNE    $5958
5956: 6A C3          DEC    $1,U
5958: 6A EC          DEC    ,U
595A: 33 CA          LEAU   $2,U
595C: 11 83 BE 66    CMPU   #$36EE
5960: 26 E8          BNE    $592C
5962: 0C 38          INC    $BA
5964: BD 7C 1E       JSR    $5E9C
5967: 35 08          PULS   Y
5969: 0A C0          DEC    $48
596B: 26 92          BNE    $5927
596D: 96 4E          LDA    $C6
596F: 26 2B          BNE    $597A
5971: A6 06          LDA    ,X
5973: 81 20          CMPA   #$02
5975: 24 85          BCC    $597E
5977: BD AA 9F       JSR    $82B7
597A: 0A C1          DEC    $49
597C: 26 DB          BNE    $5971
597E: BD D2 98       JSR    $5ABA
5981: 39             RTS

5982: 33 0A 32       LEAU   $10,X
5985: 86 81          LDA    #$03
5987: 97 60          STA    $48
5989: BD D8 55       JSR    $50DD
598C: BD 73 48       JSR    $5BC0
598F: 5D             TSTB
5990: 27 3D          BEQ    $59B1
5992: 10 8E F6 7F    LDY    #$D45D
5996: 33 0A 38       LEAU   $10,X
5999: A6 4C          LDA    ,U
599B: C6 22          LDB    #$0A
599D: 3D             MUL
599E: EB C9          ADDB   $1,U
59A0: 58             ASLB
59A1: EC 27          LDD    B,Y
59A3: 97 6B          STA    $49
59A5: D7 CA          STB    $48
59A7: BD 78 B7       JSR    $509F
59AA: 96 C1          LDA    $49
59AC: 97 60          STA    $48
59AE: BD D8 F3       JSR    $50D1
59B1: 39             RTS

59B2: 31 0A 32       LEAY   $10,X
59B5: CE B2 CE       LDU    #$304C
59B8: 86 2B          LDA    #$03
59BA: 97 C0          STA    $48
59BC: A6 88          LDA    ,Y+
59BE: 5F             CLRB
59BF: 80 24          SUBA   #$06
59C1: 25 81          BCS    $59C6
59C3: 5C             INCB
59C4: 20 DB          BRA    $59BF
59C6: 8B 84          ADDA   #$06
59C8: E7 E8          STB    ,U+
59CA: C6 82          LDB    #$0A
59CC: 3D             MUL
59CD: 1F 10          TFR    B,A
59CF: AB 82          ADDA   ,Y+
59D1: 0A CA          DEC    $48
59D3: 26 CB          BNE    $59BE
59D5: 5F             CLRB
59D6: 80 84          SUBA   #$06
59D8: 25 2B          BCS    $59DD
59DA: 5C             INCB
59DB: 20 D1          BRA    $59D6
59DD: 8B 8E          ADDA   #$06
59DF: E7 E6          STB    ,U
59E1: 6F 0A A2       CLR    $20,X
59E4: 96 6F          LDA    $4D
59E6: 48             ASLA
59E7: 48             ASLA
59E8: 48             ASLA
59E9: 48             ASLA
59EA: 9A C6          ORA    $4E
59EC: 97 65          STA    $4D
59EE: 96 C7          LDA    $4F
59F0: 48             ASLA
59F1: 48             ASLA
59F2: 48             ASLA
59F3: 48             ASLA
59F4: 97 6C          STA    $4E
59F6: 96 CC          LDA    $4E
59F8: AB A0 AB       ADDA   $23,X
59FB: 19             DAA
59FC: 97 66          STA    $4E
59FE: 96 C5          LDA    $4D
5A00: A9 AA A0       ADCA   $22,X
5A03: 19             DAA
5A04: 97 6F          STA    $4D
5A06: 96 CE          LDA    $4C
5A08: A9 A0 A9       ADCA   $21,X
5A0B: 19             DAA
5A0C: 97 64          STA    $4C
5A0E: 0F D8          CLR    $50
5A10: 0F 73          CLR    $51
5A12: 0F D0          CLR    $52
5A14: CE F6 07       LDU    #$D485
5A17: 96 41          LDA    current_event_69
5A19: 48             ASLA
5A1A: EE 4E          LDU    A,U
5A1C: 10 8E B8 D8    LDY    #$3050
5A20: A6 00          LDA    $2,Y
5A22: 97 D4          STA    $56
5A24: AB 60          ADDA   $2,U
5A26: 19             DAA
5A27: A7 0A          STA    $2,Y
5A29: A6 A9          LDA    $1,Y
5A2B: 97 7D          STA    $55
5A2D: A9 C9          ADCA   $1,U
5A2F: 19             DAA
5A30: A7 03          STA    $1,Y
5A32: A6 26          LDA    ,Y
5A34: 97 76          STA    $54
5A36: A9 46          ADCA   ,U
5A38: 19             DAA
5A39: A7 2C          STA    ,Y
5A3B: 6C A0 08       INC    $20,X
5A3E: 96 C4          LDA    $4C
5A40: 91 72          CMPA   $50
5A42: 25 92          BCS    $5A54
5A44: 22 EC          BHI    $5A14
5A46: 96 CF          LDA    $4D
5A48: 91 79          CMPA   $51
5A4A: 25 80          BCS    $5A54
5A4C: 22 EE          BHI    $5A14
5A4E: 96 C6          LDA    $4E
5A50: 91 70          CMPA   $52
5A52: 22 42          BHI    $5A14
5A54: 6A AA A2       DEC    $20,X
5A57: 27 03          BEQ    $5A84
5A59: CE B8 C4       LDU    #$304C
5A5C: 8D 6D          BSR    $5AA3
5A5E: CE B8 76       LDU    #$3054
5A61: 8D C2          BSR    $5AA3
5A63: CE 12 6E       LDU    #$304C
5A66: 96 D5          LDA    $57
5A68: 97 60          STA    $48
5A6A: BD D8 F5       JSR    $50DD
5A6D: 96 DE          LDA    $56
5A6F: 97 6A          STA    $48
5A71: BD D3 8D       JSR    $510F
5A74: 96 77          LDA    $55
5A76: 97 CA          STA    $48
5A78: BD 79 A8       JSR    $5120
5A7B: 96 7C          LDA    $54
5A7D: 97 C0          STA    $48
5A7F: BD 73 13       JSR    $5131
5A82: 20 87          BRA    $5A89
5A84: CE 12 CE       LDU    #$304C
5A87: 8D 32          BSR    $5AA3
5A89: A6 4C          LDA    ,U
5A8B: A7 A0 09       STA    $21,X
5A8E: A6 C9          LDA    $1,U
5A90: 48             ASLA
5A91: 48             ASLA
5A92: 48             ASLA
5A93: 48             ASLA
5A94: AA 60          ORA    $2,U
5A96: A7 0A 0A       STA    $22,X
5A99: A6 CB          LDA    $3,U
5A9B: 48             ASLA
5A9C: 48             ASLA
5A9D: 48             ASLA
5A9E: 48             ASLA
5A9F: A7 AA 01       STA    $23,X
5AA2: 39             RTS

5AA3: A6 60          LDA    $2,U
5AA5: 44             LSRA
5AA6: 44             LSRA
5AA7: 44             LSRA
5AA8: 44             LSRA
5AA9: A7 CB          STA    $3,U
5AAB: A6 69          LDA    $1,U
5AAD: 84 87          ANDA   #$0F
5AAF: A7 60          STA    $2,U
5AB1: 64 C3          LSR    $1,U
5AB3: 64 63          LSR    $1,U
5AB5: 64 C3          LSR    $1,U
5AB7: 64 69          LSR    $1,U
5AB9: 39             RTS

5ABA: 34 F8          PSHS   U,Y,X
5ABC: 86 2E          LDA    #$06
5ABE: 97 C0          STA    $48
5AC0: 8E 10 A2       LDX    #$3220
5AC3: A6 A6          LDA    ,X
5AC5: 81 83          CMPA   #$01
5AC7: 26 0C          BNE    $5AED
5AC9: A6 8A          LDA    $2,X
5ACB: 90 63          SUBA   $4B
5ACD: A7 8A          STA    $2,X
5ACF: D6 4B          LDB    current_event_69
5AD1: C1 80          CMPB   #$02
5AD3: 27 2D          BEQ    $5AE4
5AD5: C1 84          CMPB   #$06
5AD7: 27 39          BEQ    $5AEA
5AD9: A1 00 98       CMPA   $10,X
5ADC: 23 31          BLS    $5AF7
5ADE: 84 70          ANDA   #$F8
5AE0: 81 DA          CMPA   #$F8
5AE2: 27 91          BEQ    $5AF7
5AE4: A6 2F          LDA    $D,X
5AE6: 84 92          ANDA   #$10
5AE8: 26 2B          BNE    $5AED
5AEA: AD 10 26       JSR    [$0E,X]
5AED: 30 00 A8       LEAX   $20,X
5AF0: 0A 6A          DEC    $48
5AF2: 26 4D          BNE    $5AC3
5AF4: 35 52          PULS   X,Y,U
5AF6: 39             RTS

5AF7: E6 25          LDB    $D,X
5AF9: C4 A8          ANDB   #$20
5AFB: 26 20          BNE    $5B05
5AFD: 6F 0C          CLR    ,X
5AFF: 6F 23          CLR    $1,X
5B01: 6F 80          CLR    $2,X
5B03: 20 FD          BRA    $5AE4
5B05: 97 CD          STA    $4F
5B07: 6F 29          CLR    $1,X
5B09: 6F 8A          CLR    $2,X
5B0B: A6 25          LDA    $D,X
5B0D: 84 98          ANDA   #$10
5B0F: 26 21          BNE    $5B14
5B11: AD 1A 8C       JSR    [$0E,X]
5B14: 86 79          LDA    #$5B
5B16: D6 CD          LDB    $4F
5B18: ED 29          STD    $1,X
5B1A: A6 85          LDA    $D,X
5B1C: 8A 18          ORA    #$30
5B1E: A7 85          STA    $D,X
5B20: 20 E9          BRA    $5AED
5B22: 34 F2          PSHS   U,Y,X
5B24: 86 25          LDA    #$07
5B26: 97 CA          STA    $48
5B28: 8E 1A A8       LDX    #$3220
5B2B: A6 AC          LDA    ,X
5B2D: 81 89          CMPA   #$01
5B2F: 26 37          BNE    $5B46
5B31: A6 80          LDA    $2,X
5B33: 9B E5          ADDA   $C7
5B35: 25 AB          BCS    $5B60
5B37: 81 D8          CMPA   #$F0
5B39: 24 9D          BCC    $5B50
5B3B: A7 2A          STA    $2,X
5B3D: A6 85          LDA    $D,X
5B3F: 85 32          BITA   #$10
5B41: 26 81          BNE    $5B46
5B43: AD BA 2C       JSR    [$0E,X]
5B46: 30 0A 08       LEAX   $20,X
5B49: 0A C0          DEC    $48
5B4B: 26 F6          BNE    $5B2B
5B4D: 35 F8          PULS   X,Y,U
5B4F: 39             RTS

5B50: A7 20          STA    $2,X
5B52: A6 8F          LDA    $D,X
5B54: 84 32          ANDA   #$10
5B56: 26 6C          BNE    $5B46
5B58: 6F AC          CLR    ,X
5B5A: 6F 89          CLR    $1,X
5B5C: 6F 2A          CLR    $2,X
5B5E: 20 6B          BRA    $5B43
5B60: A7 20          STA    $2,X
5B62: A6 8F          LDA    $D,X
5B64: 84 12          ANDA   #$30
5B66: 81 B2          CMPA   #$30
5B68: 26 F4          BNE    $5B46
5B6A: A6 85          LDA    $D,X
5B6C: 84 27          ANDA   #$0F
5B6E: A7 85          STA    $D,X
5B70: 20 F3          BRA    $5B43
5B72: 5F             CLRB
5B73: A6 BA 21       LDA    [$03,X]	; [video_address]
5B76: 81 C7          CMPA   #$45
5B78: 26 2C          BNE    $5B7E
5B7A: 8D 8B          BSR    $5B7F
5B7C: C6 29          LDB    #$01
5B7E: 39             RTS

5B7F: 4F             CLRA
5B80: BD 6C 2F       JSR    queue_sound_event_4ead
5B83: CC 23 21       LDD    #$0103
5B86: DD E7          STD    $65
5B88: 0F 94          CLR    $BC
5B8A: 86 D4          LDA    #$5C
5B8C: 97 89          STA    $A1
5B8E: 39             RTS

5B8F: A6 A6          LDA    ,X
5B91: 26 93          BNE    $5BA4
5B93: CE F6 B1       LDU    #$D493
5B96: 96 EB          LDA    current_event_69
5B98: A6 EE          LDA    A,U
5B9A: A1 10 2B       CMPA   [$03,X]		; [video_address]
5B9D: 26 8D          BNE    $5BA4
5B9F: 6C A6          INC    ,X
5BA1: BD 01 05       JSR    $8387
5BA4: 39             RTS

5BA5: A6 06          LDA    ,X
5BA7: 26 3E          BNE    $5BBF
5BA9: A6 10 8B       LDA    [$03,X]
5BAC: 81 77          CMPA   #$5F
5BAE: 26 87          BNE    $5BBF
5BB0: 6C A6          INC    ,X
5BB2: A6 80          LDA    $2,X
5BB4: A0 AA 99       SUBA   $1B,X
5BB7: 8B 20          ADDA   #$08
5BB9: A7 8A          STA    $2,X
5BBB: 86 38          LDA    #$10
5BBD: A7 85          STA    $D,X
5BBF: 39             RTS

5BC0: BD 6D 08       JSR    $4F8A
5BC3: D6 49          LDB    $6B
5BC5: 27 8B          BEQ    $5BD0
5BC7: 6D 25          TST    $D,X
5BC9: 26 8D          BNE    $5BD0
5BCB: 6D A0 70       TST    $58,X
5BCE: 26 DE          BNE    $5C26
5BD0: A6 E6          LDA    ,U
5BD2: 85 80          BITA   #$02
5BD4: 26 72          BNE    $5C26
5BD6: 84 83          ANDA   #$01
5BD8: 27 38          BEQ    $5BEA
5BDA: A6 C9          LDA    $1,U
5BDC: 84 29          ANDA   #$01
5BDE: 27 96          BEQ    $5BFE
5BE0: A6 60          LDA    $2,U
5BE2: 84 83          ANDA   #$01
5BE4: 26 3A          BNE    $5BFE
5BE6: 8D C1          BSR    $5C2B
5BE8: 20 16          BRA    $5C28
5BEA: A6 C9          LDA    $1,U
5BEC: 84 29          ANDA   #$01
5BEE: 27 86          BEQ    $5BFE
5BF0: A6 60          LDA    $2,U
5BF2: 84 8B          ANDA   #$09		; original ANDA   #$01
5BF4: 26 2A          BNE    $5BFE
5BF6: 8D C1          BSR    $5C3B
5BF8: 0D 60          TST    $48
5BFA: 27 8A          BEQ    $5BFE
5BFC: 20 02          BRA    $5C28
5BFE: A6 4C          LDA    ,U
5C00: 84 26          ANDA   #$04
5C02: 27 92          BEQ    $5C14
5C04: A6 63          LDA    $1,U
5C06: 84 86          ANDA   #$04
5C08: 27 34          BEQ    $5C26
5C0A: A6 CA          LDA    $2,U
5C0C: 84 2C          ANDA   #$04
5C0E: 26 9E          BNE    $5C26
5C10: 8D 3B          BSR    $5C2B
5C12: 20 96          BRA    $5C28
5C14: A6 63          LDA    $1,U
5C16: 84 86          ANDA   #$04
5C18: 27 24          BEQ    $5C26
5C1A: A6 CA          LDA    $2,U
5C1C: 84 2C          ANDA   #$04
5C1E: 26 8E          BNE    $5C26
5C20: 8D 3B          BSR    $5C3B
5C22: 0D CA          TST    $48
5C24: 26 20          BNE    $5C28
5C26: 5F             CLRB
5C27: 39             RTS

5C28: C6 29          LDB    #$01
5C2A: 39             RTS

5C2B: CE 1C D0       LDU    #$34F8
5C2E: 96 91          LDA    $19
5C30: 6C E4          INC    A,U
5C32: E6 44          LDB    A,U
5C34: C1 24          CMPB   #$06
5C36: 26 80          BNE    $5C3A
5C38: 6A EE          DEC    A,U
5C3A: 39             RTS

5C3B: CE 1C D0       LDU    #$34F8
5C3E: 0F C0          CLR    $48
5C40: 96 3B          LDA    $19
5C42: E6 44          LDB    A,U
5C44: 27 24          BEQ    $5C4C
5C46: 6A 44          DEC    A,U
5C48: 27 2A          BEQ    $5C4C
5C4A: 0C C0          INC    $48
5C4C: 39             RTS

5C4D: 10 8E 5C BB    LDY    #$D499
5C51: 96 EB          LDA    current_event_69
5C53: 48             ASLA
5C54: 10 AE 24       LDY    A,Y
5C57: CE 0D 97       LDU    #$25BF
5C5A: DF 59          STU    $D1
5C5C: CE 0D 08       LDU    #$2580
5C5F: DF 96          STU    $B4
5C61: EC 23          LDD    ,Y++
5C63: DD 9A          STD    $B8
5C65: D7 4C          STB    $CE
5C67: 96 38          LDA    $10
5C69: 84 A8          ANDA   #$20
5C6B: 26 24          BNE    $5C79
5C6D: 96 30          LDA    $B8
5C6F: 85 02          BITA   #$20
5C71: 27 84          BEQ    $5C79
5C73: 84 FD          ANDA   #$DF
5C75: 8A C2          ORA    #$40
5C77: 97 90          STA    $B8
5C79: 8D 82          BSR    $5C85
5C7B: 11 83 0D 37    CMPU   #$25BF
5C7F: 26 DA          BNE    $5C79
5C81: 10 9F 34       STY    $B6
5C84: 39             RTS

5C85: 96 EB          LDA    current_event_69
5C87: 81 28          CMPA   #$00
5C89: 27 BA          BEQ    $5CBD
5C8B: 81 2A          CMPA   #$02
5C8D: 27 A6          BEQ    $5CBD
5C8F: 81 24          CMPA   #$06
5C91: 27 D2          BEQ    $5CE3
5C93: 81 26          CMPA   #$04
5C95: 27 CE          BEQ    $5CE3
5C97: 86 2F          LDA    #$07
5C99: 97 C2          STA    $4A
5C9B: A6 88          LDA    ,Y+
5C9D: A7 4C          STA    ,U					;  [video_address]
5C9F: 96 9A          LDA    $B8
5CA1: A7 4B 8A 22    STA    $0800,U					;  [video_address]
5CA5: 33 4A 42       LEAU   -$40,U
5CA8: 0A 62          DEC    $4A
5CAA: 26 67          BNE    $5C9B
5CAC: 31 11          LEAY   -$7,Y
5CAE: 0A 31          DEC    $B9
5CB0: 26 24          BNE    $5CB8
5CB2: 31 A5          LEAY   $7,Y
5CB4: E6 82          LDB    ,Y+
5CB6: D7 3B          STB    $B9
5CB8: 33 E1 89 49    LEAU   $01C1,U
5CBC: 39             RTS

5CBD: 86 8D          LDA    #$05
5CBF: 97 68          STA    $4A
5CC1: A6 22          LDA    ,Y+
5CC3: A7 E6          STA    ,U					;  [video_address]
5CC5: 96 3A          LDA    $B8
5CC7: A7 E1 20 88    STA    $0800,U					;  [video_address]
5CCB: 33 E0 E8       LEAU   -$40,U
5CCE: 0A C2          DEC    $4A
5CD0: 26 CD          BNE    $5CC1
5CD2: 31 B9          LEAY   -$5,Y
5CD4: 0A 9B          DEC    $B9
5CD6: 26 84          BNE    $5CDE
5CD8: 31 0D          LEAY   $5,Y
5CDA: E6 28          LDB    ,Y+
5CDC: D7 91          STB    $B9
5CDE: 33 41 23 63    LEAU   $0141,U
5CE2: 39             RTS

5CE3: 86 2A          LDA    #$08
5CE5: 97 C8          STA    $4A
5CE7: A6 88          LDA    ,Y+
5CE9: A7 4C          STA    ,U					;  [video_address]
5CEB: 96 90          LDA    $B8
5CED: A7 41 80 22    STA    $0800,U					;  [video_address]
5CF1: 33 4A 42       LEAU   -$40,U
5CF4: 0A 68          DEC    $4A
5CF6: 26 6D          BNE    $5CE7
5CF8: 31 10          LEAY   -$8,Y
5CFA: 0A 31          DEC    $B9
5CFC: 26 2E          BNE    $5D04
5CFE: 31 A0          LEAY   $8,Y
5D00: E6 82          LDB    ,Y+
5D02: D7 3B          STB    $B9
5D04: 33 EB 80 83    LEAU   $0201,U
5D08: 39             RTS

5D09: 86 88          LDA    #$00
5D0B: 97 41          STA    current_event_69
5D0D: 86 89          LDA    #$01
5D0F: 97 47          STA    $65
5D11: 86 80          LDA    #$02
5D13: 97 68          STA    $4A
5D15: 8E 63 32       LDX    #$E1B0
5D18: 0D 4D          TST    $65
5D1A: 27 8B          BEQ    $5D1F
5D1C: 8E CA E9       LDX    #$E261
5D1F: CE 03 E2       LDU    #$21C0
5D22: 86 A2          LDA    #$20
5D24: 97 69          STA    $4B
5D26: EC 03          LDD    ,X++
5D28: D7 61          STB    $49
5D2A: C6 8E          LDB    #$06
5D2C: D7 60          STB    $48
5D2E: E6 08          LDB    ,X+
5D30: E7 E6          STB    ,U					;  [video_address]
5D32: A7 4B 2A 22    STA    $0800,U					;  [video_address]
5D36: 33 4A E8       LEAU   -$40,U
5D39: 0A C0          DEC    $48
5D3B: 26 D9          BNE    $5D2E
5D3D: 30 92          LEAX   -$6,X
5D3F: 0A 6B          DEC    $49
5D41: 26 84          BNE    $5D49
5D43: 30 24          LEAX   $6,X
5D45: E6 02          LDB    ,X+
5D47: D7 61          STB    $49
5D49: 33 41 89 A9    LEAU   $0181,U
5D4D: 0A C3          DEC    $4B
5D4F: 26 FB          BNE    $5D2A
5D51: 8E 60 BF       LDX    #$E23D
5D54: 0D 47          TST    $65
5D56: 27 81          BEQ    $5D5B
5D58: 8E CA E1       LDX    #$E269
5D5B: CE 0F 68       LDU    #$2740
5D5E: 0A C2          DEC    $4A
5D60: 26 E2          BNE    $5D22
5D62: 39             RTS

5D63: 8E C2 4D       LDX    #$E06F
5D66: CE A6 28       LDU    #$2400
5D69: EC 09          LDD    ,X++
5D6B: D7 61          STB    $49
5D6D: D6 98          LDB    $10
5D6F: C4 02          ANDB   #$20
5D71: 26 8A          BNE    $5D7B
5D73: 85 02          BITA   #$20
5D75: 27 86          BEQ    $5D7B
5D77: 84 F7          ANDA   #$DF
5D79: 8A C8          ORA    #$40
5D7B: C6 2C          LDB    #$04
5D7D: D7 C0          STB    $48
5D7F: E6 A2          LDB    ,X+
5D81: E7 46          STB    ,U					;  [video_address]
5D83: A7 EB 2A 82    STA    $0800,U					;  [video_address]
5D87: 33 E0 E8       LEAU   -$40,U
5D8A: 0A C0          DEC    $48
5D8C: 26 D9          BNE    $5D7F
5D8E: 30 94          LEAX   -$4,X
5D90: 0A 6B          DEC    $49
5D92: 26 84          BNE    $5D9A
5D94: 30 26          LEAX   $4,X
5D96: E6 02          LDB    ,X+
5D98: D7 61          STB    $49
5D9A: 33 41 29 29    LEAU   $0101,U
5D9E: 11 83 06 62    CMPU   #$2440
5DA2: 26 55          BNE    $5D7B
5DA4: 39             RTS

5DA5: 8E 56 41       LDX    #$D4C3
5DA8: 96 41          LDA    current_event_69
5DAA: 48             ASLA
5DAB: 31 AE          LEAY   A,X
5DAD: AE 2C          LDX    ,Y
5DAF: 96 4B          LDA    current_event_69
5DB1: 81 84          CMPA   #$06
5DB3: 27 29          BEQ    $5DC0
5DB5: 81 86          CMPA   #$04
5DB7: 27 2F          BEQ    $5DC0
5DB9: CE AB 48       LDU    #$23C0
5DBC: 8D 40          BSR    $5E26
5DBE: AE A6          LDX    $E,Y
5DC0: CE 01 02       LDU    #$2380
5DC3: EC A3          LDD    ,X++
5DC5: D7 CB          STB    $49
5DC7: D6 38          LDB    $10
5DC9: C4 A8          ANDB   #$20
5DCB: 26 20          BNE    $5DD5
5DCD: 85 A8          BITA   #$20
5DCF: 27 26          BEQ    $5DD5
5DD1: 84 5D          ANDA   #$DF
5DD3: 8A 62          ORA    #$40
5DD5: C6 80          LDB    #$02
5DD7: D7 60          STB    $48
5DD9: E6 08          LDB    ,X+
5DDB: E7 EC          STB    ,U					;  [video_address]
5DDD: A7 41 80 22    STA    $0800,U					;  [video_address]
5DE1: 33 4A 42       LEAU   -$40,U
5DE4: 0A 6A          DEC    $48
5DE6: 26 73          BNE    $5DD9
5DE8: 30 36          LEAX   -$2,X
5DEA: 0A C1          DEC    $49
5DEC: 26 2E          BNE    $5DF4
5DEE: 30 8A          LEAX   $2,X
5DF0: E6 A2          LDB    ,X+
5DF2: D7 CB          STB    $49
5DF4: 33 EB 82 03    LEAU   $0081,U
5DF8: 11 83 AB 48    CMPU   #$23C0
5DFC: 26 FF          BNE    $5DD5
5DFE: 39             RTS

5DFF: 86 23          LDA    #$01
5E01: 20 80          BRA    $5E05
5E03: 86 20          LDA    #$02
5E05: 97 C8          STA    $4A
5E07: 8E FC 9D       LDX    #$D4B5
5E0A: 96 E1          LDA    current_event_69
5E0C: 48             ASLA
5E0D: AE 0E          LDX    A,X
5E0F: CE 07 E2       LDU    #$25C0
5E12: 0D E7          TST    $65
5E14: 27 21          BEQ    $5E19
5E16: 8E 61 1A       LDX    #$E332
5E19: 8D 83          BSR    $5E26
5E1B: 8E C8 44       LDX    #$E06C
5E1E: CE AC 62       LDU    #$2440
5E21: 0A C8          DEC    $4A
5E23: 26 D6          BNE    $5E19
5E25: 39             RTS

5E26: 86 C2          LDA    #$40
5E28: 97 63          STA    $4B
5E2A: EC 09          LDD    ,X++
5E2C: D7 61          STB    $49
5E2E: D6 98          LDB    $10
5E30: C4 02          ANDB   #$20
5E32: 26 8A          BNE    $5E3C
5E34: 85 02          BITA   #$20
5E36: 27 86          BEQ    $5E3C
5E38: 84 F7          ANDA   #$DF
5E3A: 8A C8          ORA    #$40
5E3C: A7 E1 80 88    STA    $0800,U					;  [video_address]
5E40: E6 A6          LDB    ,X
5E42: E7 42          STB    ,U+					;  [video_address]
5E44: 0A 6B          DEC    $49
5E46: 26 84          BNE    $5E4E
5E48: 30 29          LEAX   $1,X
5E4A: E6 08          LDB    ,X+
5E4C: D7 61          STB    $49
5E4E: 0A C3          DEC    $4B
5E50: 26 C8          BNE    $5E3C
5E52: 39             RTS

5E53: 8E F6 85       LDX    #$D4A7
5E56: 96 EB          LDA    current_event_69
5E58: 48             ASLA
5E59: AE 0E          LDX    A,X
5E5B: CE 0B 28       LDU    #$2300
5E5E: E6 08          LDB    ,X+
5E60: 96 32          LDA    $10
5E62: 84 A2          ANDA   #$20
5E64: 26 2A          BNE    $5E6E
5E66: C5 A2          BITB   #$20
5E68: 27 2C          BEQ    $5E6E
5E6A: C4 57          ANDB   #$DF
5E6C: CA 68          ORB    #$40
5E6E: 86 8D          LDA    #$05
5E70: 97 6A          STA    $48
5E72: A6 02          LDA    ,X+
5E74: A7 E6          STA    ,U					;  [video_address]
5E76: E7 4B 20 28    STB    $0800,U					;  [video_address]
5E7A: 33 40 E8       LEAU   -$40,U
5E7D: 0A C0          DEC    $48
5E7F: 26 D3          BNE    $5E72
5E81: 33 4B 83 63    LEAU   $0141,U
5E85: 96 EB          LDA    current_event_69
5E87: 81 2E          CMPA   #$06
5E89: 27 8C          BEQ    $5E8F
5E8B: 81 2C          CMPA   #$04
5E8D: 26 8E          BNE    $5E95
5E8F: 86 2C          LDA    #$0E
5E91: A7 4B 85 DD    STA    $07FF,U	; [video_address]
5E95: 11 83 A1 68    CMPU   #$2340
5E99: 26 5B          BNE    $5E6E
5E9B: 39             RTS

5E9C: 96 92          LDA    $BA
5E9E: 84 8F          ANDA   #$07
5EA0: 26 1F          BNE    $5EDF
5EA2: DE 53          LDU    $D1
5EA4: 10 9E 34       LDY    $B6
5EA7: BD 74 AD       JSR    $5C85
5EAA: 11 83 0D E8    CMPU   #$25C0
5EAE: 26 8B          BNE    $5EB3
5EB0: CE 07 02       LDU    #$2580
5EB3: DF F3          STU    $D1
5EB5: 10 9F 34       STY    $B6
5EB8: 33 69          LEAU   $1,U
5EBA: 11 83 0D E8    CMPU   #$25C0
5EBE: 26 8B          BNE    $5EC3
5EC0: CE 07 02       LDU    #$2580
5EC3: DF 96          STU    $B4
5EC5: 96 EB          LDA    current_event_69
5EC7: 81 28          CMPA   #$00
5EC9: 26 9C          BNE    $5EDF
5ECB: 0C E7          INC    $CF
5ECD: 96 47          LDA    $CF
5ECF: 91 EC          CMPA   $CE
5ED1: 26 8E          BNE    $5EDF
5ED3: DE EE          LDU    $CC
5ED5: 33 C4          LEAU   $6,U
5ED7: A6 77          LDA    -$1,U
5ED9: 97 46          STA    $CE
5EDB: 0F E7          CLR    $CF
5EDD: DF 44          STU    $CC
5EDF: 39             RTS

5EE0: 96 E5          LDA    $C7
5EE2: 97 CA          STA    $48
5EE4: CE F6 BB       LDU    #$D439
5EE7: 96 41          LDA    current_event_69
5EE9: 48             ASLA
5EEA: 10 AE EE       LDY    A,U
5EED: 34 A8          PSHS   Y
5EEF: CE 14 FA       LDU    #$36D8
5EF2: 96 38          LDA    $BA
5EF4: E6 82          LDB    ,Y+
5EF6: C1 7D          CMPB   #$FF
5EF8: 27 30          BEQ    $5F12
5EFA: A4 B7          ANDA   -$1,Y
5EFC: 26 3C          BNE    $5F12
5EFE: 96 8A          LDA    $02
5F00: 26 28          BNE    $5F0C
5F02: A6 46          LDA    ,U
5F04: 26 20          BNE    $5F08
5F06: 6A C3          DEC    $1,U
5F08: 6A EC          DEC    ,U
5F0A: 20 8E          BRA    $5F12
5F0C: 6C EC          INC    ,U
5F0E: 26 8A          BNE    $5F12
5F10: 6C 63          INC    $1,U
5F12: 33 C0          LEAU   $2,U
5F14: 11 83 B4 6C    CMPU   #$36EE
5F18: 26 F0          BNE    $5EF2
5F1A: 0A 32          DEC    $BA
5F1C: 8D 25          BSR    $5F2B
5F1E: 35 A8          PULS   Y
5F20: 96 98          LDA    $BA
5F22: 81 05          CMPA   #$87
5F24: 27 26          BEQ    $5F2A
5F26: 0A CA          DEC    $48
5F28: 26 EB          BNE    $5EED
5F2A: 39             RTS

5F2B: 96 92          LDA    $BA
5F2D: 84 8F          ANDA   #$07
5F2F: 26 1E          BNE    $5F6D
5F31: DE 53          LDU    $D1
5F33: 10 9E EE       LDY    $CC
5F36: 96 4D          LDA    $CF
5F38: 27 1C          BEQ    $5F6E
5F3A: 86 8D          LDA    #$05
5F3C: 97 62          STA    $4A
5F3E: A6 28          LDA    ,Y+
5F40: A7 E6          STA    ,U					;  [video_address]
5F42: 96 3A          LDA    $B8
5F44: A7 EB 8A 82    STA    $0800,U					;  [video_address]
5F48: 33 E0 48       LEAU   -$40,U
5F4B: 0A 62          DEC    $4A
5F4D: 26 67          BNE    $5F3E
5F4F: 31 19          LEAY   -$5,Y
5F51: 0A 4D          DEC    $CF
5F53: 26 24          BNE    $5F5B
5F55: 31 B8          LEAY   -$6,Y
5F57: A6 17          LDA    -$1,Y
5F59: 97 47          STA    $CF
5F5B: 33 E1 29 B7    LEAU   $013F,U
5F5F: 11 83 07 FD    CMPU   #$257F
5F63: 26 21          BNE    $5F68
5F65: CE A7 3D       LDU    #$25BF
5F68: DF F9          STU    $D1
5F6A: 10 9F E4       STY    $CC
5F6D: 39             RTS

5F6E: 31 B2          LEAY   -$6,Y
5F70: 86 23          LDA    #$01
5F72: 97 4D          STA    $CF
5F74: 20 CB          BRA    $5F5F
5F76: 8E B2 88       LDX    #$30A0
5F79: CC AD 77       LDD    #$25FF
5F7C: DD F9          STD    $D1
5F7E: CE AD E2       LDU    #$25C0
5F81: DF 36          STU    $B4
5F83: 86 26          LDA    #$04
5F85: 97 D2          STA    $50
5F87: 10 8E CB BD    LDY    #$E335
5F8B: EC 89          LDD    ,Y++
5F8D: ED 00 90       STD    $18,X
5F90: 8D 0A          BSR    $5FBA
5F92: 11 A3 AA 13    CMPU   $31,X
5F96: 26 7A          BNE    $5F90
5F98: 10 AF 00 9E    STY    $16,X
5F9C: 0A 78          DEC    $50
5F9E: 26 89          BNE    $5FA1
5FA0: 39             RTS

5FA1: 30 0A E2       LEAX   $60,X
5FA4: EE AA 53       LDU    -$2F,X
5FA7: 33 E1 D7 88    LEAU   -$0100,U
5FAB: EF A0 19       STU    $31,X
5FAE: EE 00 96       LDU    -$4C,X
5FB1: 33 4B 7D 22    LEAU   -$0100,U
5FB5: EF 0A 96       STU    $14,X
5FB8: 20 E5          BRA    $5F87
5FBA: 86 8C          LDA    #$04
5FBC: 97 62          STA    $4A
5FBE: A6 28          LDA    ,Y+
5FC0: A7 E6          STA    ,U					;  [video_address]
5FC2: A6 0A 3A       LDA    $18,X
5FC5: A7 4B 8A 28    STA    $0800,U					;  [video_address]
5FC9: 33 40 48       LEAU   -$40,U
5FCC: 0A 62          DEC    $4A
5FCE: 26 66          BNE    $5FBE
5FD0: 31 1E          LEAY   -$4,Y
5FD2: 6A 0A 3B       DEC    $19,X
5FD5: 26 85          BNE    $5FDE
5FD7: 31 0C          LEAY   $4,Y
5FD9: A6 28          LDA    ,Y+
5FDB: A7 A0 31       STA    $19,X
5FDE: 33 41 23 23    LEAU   $0101,U
5FE2: 39             RTS

5FE3: A6 AA 38       LDA    $1A,X
5FE6: 84 85          ANDA   #$07
5FE8: 26 0E          BNE    $6010
5FEA: EE 00 19       LDU    $31,X
5FED: 10 AE 00 34    LDY    $16,X
5FF1: 8D 45          BSR    $5FBA
5FF3: 10 AF AA 94    STY    $16,X
5FF7: 1F 18          TFR    U,D
5FF9: C5 B7          BITB   #$3F
5FFB: 26 2B          BNE    $6000
5FFD: 83 88 C8       SUBD   #$0040
6000: ED AA B3       STD    $31,X
6003: C3 22 23       ADDD   #$0001
6006: C5 BD          BITB   #$3F
6008: 26 2B          BNE    $600D
600A: 83 88 68       SUBD   #$0040
600D: ED 00 9C       STD    $14,X
6010: 39             RTS

6011: A6 0A 98       LDA    $1A,X
6014: 84 25          ANDA   #$07
6016: 26 CB          BNE    $6061
6018: EE A0 B9       LDU    $31,X
601B: 10 AE A0 A4    LDY    $2C,X
601F: 86 26          LDA    #$04
6021: 97 C8          STA    $4A
6023: A6 82          LDA    ,Y+
6025: A7 46          STA    ,U					;  [video_address]
6027: A6 A0 30       LDA    $18,X
602A: A7 41 20 28    STA    $0800,U					;  [video_address]
602E: 33 40 E2       LEAU   -$40,U
6031: 0A C8          DEC    $4A
6033: 26 CC          BNE    $6023
6035: 31 BE          LEAY   -$4,Y
6037: 6A A0 07       DEC    $2F,X
603A: 26 8F          BNE    $6043
603C: 31 13          LEAY   -$5,Y
603E: A6 B7          LDA    -$1,Y
6040: A7 AA AD       STA    $2F,X
6043: 33 EB 22 7D    LEAU   $00FF,U
6047: 1F 18          TFR    U,D
6049: D7 DC          STB    $54
604B: C4 17          ANDB   #$3F
604D: C1 B7          CMPB   #$3F
604F: 26 25          BNE    $6058
6051: D6 D6          LDB    $54
6053: C3 22 62       ADDD   #$0040
6056: 20 80          BRA    $605A
6058: D6 7C          LDB    $54
605A: ED 00 19       STD    $31,X
605D: 10 AF 00 0E    STY    $2C,X
6061: 39             RTS

6062: 10 8E CA 6A    LDY    #$E848
6066: CE A1 21       LDU    #$2309
6069: DC 30          LDD    $B8
606B: DD 4D          STD    $65
606D: EC 29          LDD    ,Y++
606F: DD 9A          STD    $B8
6071: BD DE 3F       JSR    $5CBD
6074: 11 83 A1 95    CMPU   #$2317
6078: 26 DF          BNE    $6071
607A: DC ED          LDD    $65
607C: DD 90          STD    $B8
607E: 39             RTS

607F: 10 8E CA D9    LDY    #$E85B
6083: CE 06 A3       LDU    #$2481
6086: DC 3A          LDD    $B8
6088: DD 4D          STD    $65
608A: EC 29          LDD    ,Y++
608C: DD 90          STD    $B8
608E: BD D4 B5       JSR    $5C97
6091: 11 83 A6 A9    CMPU   #$248B
6095: 26 75          BNE    $608E
6097: DC 4D          LDD    $65
6099: DD 30          STD    $B8
609B: 39             RTS

triple_jump_609c:
609C: 8E FC 57       LDX   #table_d4df
609F: 96 0A          LDA    event_sub_state_28
60A1: 48             ASLA
60A2: 6E 14          JMP    [A,X]		; [jump_table]

60A4: 8E F6 71       LDX   #table_d4f3
60A7: 96 02          LDA    event_sub_state_2a
60A9: 48             ASLA
60AA: 6E 1E          JMP    [A,X]		; [jump_table]

60AC: 8E 18 28       LDX    #$30A0
60AF: BD A0 85       JSR    $82A7
60B2: CC A7 B9       LDD    #$259B
60B5: DD 61          STD    $E3
60B7: CC F7 3E       LDD    #$DF16
60BA: DD 44          STD    $CC
60BC: 86 29          LDA    #$01
60BE: 97 46          STA    $CE
60C0: CC 2E 88       LDD    #$0C0A
60C3: FD 11 57       STD    $3375
60C6: 86 87          LDA    #$05
60C8: 97 C0          STA    $E8
60CA: 86 96          LDA    #$1E
60CC: 97 03          STA    $2B
60CE: 0C A2          INC    event_sub_state_2a
60D0: 39             RTS

60D1: 0A A9          DEC    $2B
60D3: 26 36          BNE    $60E9
60D5: 86 A5          LDA    #$27
60D7: BD 66 85       JSR    queue_sound_event_4ead
60DA: 86 81          LDA    #$09
60DC: 97 EC          STA    $C4
60DE: CC 98 44       LDD    #$1066
60E1: DD 76          STD    $F4
60E3: 0F D4          CLR    $F6
60E5: 0C AA          INC    event_sub_state_28
60E7: 0F 02          CLR    event_sub_state_2a
60E9: 39             RTS

60EA: BD C7 89       JSR    $4FA1
60ED: 84 8D          ANDA   #$05
60EF: 26 06          BNE    $6115
60F1: BD D5 1D       JSR    $579F
60F4: CE 16 73       LDU    #$34F1
60F7: A6 69          LDA    $1,U
60F9: 81 87          CMPA   #$0F
60FB: 27 08          BEQ    $611D
60FD: A6 4C          LDA    ,U
60FF: 26 31          BNE    $6114
6101: A6 C3          LDA    $1,U
6103: 81 2C          CMPA   #$0E
6105: 27 8A          BEQ    $610F
6107: 81 23          CMPA   #$0B
6109: 27 8C          BEQ    $610F
610B: 81 20          CMPA   #$08
610D: 26 8D          BNE    $6114
610F: 86 1A          LDA    #$38
6111: BD CC 31       JSR    force_queue_sound_event_4eb3
6114: 39             RTS

6115: CC 5B 1D       LDD    #$D99F
6118: DD 83          STD    $AB
611A: 0C A0          INC    event_sub_state_28
611C: 39             RTS

611D: 86 80          LDA    #$08
611F: 97 0A          STA    event_sub_state_28
6121: 86 81          LDA    #$03
6123: 97 08          STA    event_sub_state_2a
6125: 39             RTS

6126: 8E B2 88       LDX    #$30A0
6129: BD D1 0A       JSR    $5982
612C: BD 71 3A       JSR    $59B2
612F: BD 7A 99       JSR    $58BB
6132: 86 81          LDA    #$03
6134: BD 6C 18       JSR    queue_event_4e9a
6137: 0F E2          CLR    $CA
6139: BD D8 BD       JSR    $5035
613C: 8D 34          BSR    $615A
613E: 8E BA 02       LDX    #$3220
6141: 0F 48          CLR    $CA
6143: BD 72 17       JSR    $5035
6146: BD D9 A7       JSR    $5B8F
6149: 0D 28          TST    $A0
614B: 27 2B          BEQ    $6150
614D: 0C A0          INC    event_sub_state_28
614F: 39             RTS

6150: BD E2 82       JSR    $C000
6153: 96 52          LDA    $70
6155: 81 83          CMPA   #$01
6157: 27 EC          BEQ    $611D
6159: 39             RTS

615A: 96 68          LDA    $E0
615C: 26 3D          BNE    $6173
615E: A6 10 21       LDA    [$03,X]		; [video_address]
6161: D6 EB          LDB    current_event_69
6163: C1 24          CMPB   #$06
6165: 27 84          BEQ    $616D
6167: 81 63          CMPA   #$4B
6169: 26 94          BNE    $6187
616B: 20 2C          BRA    $6171
616D: 81 22          CMPA   #$AA
616F: 26 34          BNE    $6187
6171: 0C 62          INC    $E0
6173: A6 25          LDA    $7,X
6175: D6 EB          LDB    current_event_69
6177: C1 2E          CMPB   #$06
6179: 27 8E          BEQ    $6181
617B: 81 27          CMPA   #$0F
617D: 26 80          BNE    $6187
617F: 20 26          BRA    $6185
6181: 81 89          CMPA   #$0B
6183: 26 20          BNE    $6187
6185: 6C 06          INC    ,X
6187: 39             RTS

6188: BD E8 88       JSR    $C000
618B: 8E 18 88       LDX    #$30A0
618E: BD D1 90       JSR    $59B2
6191: BD DA 39       JSR    $58BB
6194: 0F E8          CLR    $CA
6196: BD D2 1D       JSR    $5035
6199: BD FB 1B       JSR    $7393
619C: BD 73 FA       JSR    $5B72
619F: 5D             TSTB
61A0: 10 26 82 10    LBNE   $6236
61A4: 8E 10 A2       LDX    #$3220
61A7: 0F E2          CLR    $CA
61A9: BD D8 BD       JSR    $5035
61AC: BD 73 07       JSR    $5B8F
61AF: 8E 12 82       LDX    #$30A0
61B2: BD CD 83       JSR    $4FA1
61B5: 84 80          ANDA   #$02
61B7: 27 54          BEQ    $6235
61B9: 86 86          LDA    #$0E
61BB: BD 66 85       JSR    queue_sound_event_4ead
61BE: 86 91          LDA    #$19
61C0: BD 6C 2F       JSR    queue_sound_event_4ead
61C3: 86 38          LDA    #$1A
61C5: BD CC 2F       JSR    queue_sound_event_4ead
61C8: 0C D3          INC    $FB
61CA: BD D9 6D       JSR    $5145
61CD: DF 64          STU    $EC
61CF: 96 99          LDA    $BB
61D1: 97 6C          STA    $EE
61D3: BD 51 45       JSR    $7367
61D6: BD F1 F7       JSR    $73DF
61D9: 96 60          LDA    $E8
61DB: 81 2D          CMPA   #$05
61DD: 24 8B          BCC    $61E2
61DF: 7C 16 C5       INC    $34E7
61E2: DC 32          LDD    speed_msb_b0
61E4: 83 23 81       SUBD   #$0103
61E7: 25 08          BCS    $6209
61E9: C1 8A          CMPB   #$02
61EB: 25 2A          BCS    $61EF
61ED: C6 8A          LDB    #$02
61EF: D7 6A          STB    $48
61F1: 96 30          LDA    $B2
61F3: 97 6B          STA    $49
61F5: CC 83 81       LDD    #$0103
61F8: DD 98          STD    speed_msb_b0
61FA: 96 C0          LDA    $48
61FC: 48             ASLA
61FD: 48             ASLA
61FE: D6 C1          LDB    $49
6200: C1 27          CMPB   #$05
6202: 25 83          BCS    $6205
6204: 4C             INCA
6205: 97 30          STA    $B2
6207: 0F 9B          CLR    $B3
6209: DC 38          LDD    speed_msb_b0
620B: DD D8          STD    $F0
620D: DC 3A          LDD    $B2
620F: DD D0          STD    $F2
6211: DC 32          LDD    speed_msb_b0
6213: 10 83 23 80    CMPD   #$0102
6217: 25 23          BCS    $6224
6219: CC 89 8A       LDD    #$0102
621C: DD 98          STD    speed_msb_b0
621E: 96 3A          LDA    $B2
6220: 97 91          STA    $B3
6222: 0F 30          CLR    $B2
6224: DC 92          LDD    speed_msb_b0
6226: DD 5E          STD    $DC
6228: DC 9A          LDD    $B2
622A: DD 56          STD    $DE
622C: 0F ED          CLR    $C5
622E: 6C 0C          INC    ,X
6230: BD 56 A5       JSR    $7427
6233: 0C 0A          INC    event_sub_state_28
6235: 39             RTS

6236: 86 8B          LDA    #$09
6238: 97 00          STA    event_sub_state_28
623A: 0F A2          CLR    event_sub_state_2a
623C: 39             RTS

623D: 8E B8 28       LDX    #$30A0
6240: CE F6 75       LDU   #table_d4f7
6243: 96 08          LDA    event_sub_state_2a
6245: 48             ASLA
6246: 6E 54          JMP    [A,U]		; [jump_table]
6248: 96 94          LDA    $BC
624A: 27 B5          BEQ    $6289
624C: 81 30          CMPA   #$18
624E: 27 A5          BEQ    $627D
6250: 84 25          ANDA   #$07
6252: 26 8B          BNE    $625D
6254: A6 20          LDA    $2,X
6256: 8B 88          ADDA   #$0A
6258: A7 2A          STA    $2,X
625A: BD 0A BD       JSR    $8295
625D: 0C 34          INC    $BC
625F: BD 6D 83       JSR    $4FA1
6262: 84 80          ANDA   #$02
6264: 27 00          BEQ    $6288
6266: 0C 7E          INC    $FC
6268: 4F             CLRA
6269: BD C6 25       JSR    queue_sound_event_4ead
626C: 86 26          LDA    #$0E
626E: BD C6 8F       JSR    queue_sound_event_4ead
6271: 86 98          LDA    #$1A
6273: BD 6C 8F       JSR    queue_sound_event_4ead
6276: 86 9E          LDA    #$1C
6278: BD 66 25       JSR    queue_sound_event_4ead
627B: 8D 39          BSR    $628E
627D: 0F 34          CLR    $BC
627F: 6C A6          INC    ,X
6281: BD F6 A5       JSR    $7427
6284: 0C 0A          INC    event_sub_state_28
6286: 0F A8          CLR    event_sub_state_2a
6288: 39             RTS

6289: BD FB EF       JSR    $7367
628C: 20 E4          BRA    $625A
628E: 96 34          LDA    $BC
6290: C6 24          LDB    #$06
6292: BD 24 24       JSR    $A606
6295: CE 56 79       LDU    #$D4FB
6298: 58             ASLB
6299: EC 4D          LDD    B,U
629B: DD 60          STD    $48
629D: CE B8 38       LDU    #$30B0
62A0: BD 73 A2       JSR    $5120
62A3: 96 6B          LDA    $49
62A5: 97 CA          STA    $48
62A7: 7E 79 27       JMP    $510F
62AA: 39             RTS

62AB: 8E 18 88       LDX    #$30A0
62AE: CE 5D 25       LDU   #table_d507
62B1: 96 A8          LDA    event_sub_state_2a
62B3: 48             ASLA
62B4: 6E F4          JMP    [A,U]		; [jump_table]
62B6: 96 3E          LDA    $BC
62B8: 27 68          BEQ    $62FA
62BA: 81 90          CMPA   #$18
62BC: 27 05          BEQ    $62EB
62BE: 84 8F          ANDA   #$07
62C0: 26 2B          BNE    $62CB
62C2: A6 80          LDA    $2,X
62C4: 8B 28          ADDA   #$0A
62C6: A7 80          STA    $2,X
62C8: BD AA 1D       JSR    $8295
62CB: 0C 94          INC    $BC
62CD: BD C7 29       JSR    $4FA1
62D0: 84 20          ANDA   #$02
62D2: 27 A7          BEQ    $62F9
62D4: 0C DF          INC    $FD
62D6: 4F             CLRA
62D7: BD 66 85       JSR    queue_sound_event_4ead
62DA: 86 86          LDA    #$0E
62DC: BD 66 25       JSR    queue_sound_event_4ead
62DF: 86 39          LDA    #$1B
62E1: BD CC 2F       JSR    queue_sound_event_4ead
62E4: 86 3E          LDA    #$1C
62E6: BD CC 85       JSR    queue_sound_event_4ead
62E9: 8D 2B          BSR    $628E
62EB: 0F 94          CLR    $BC
62ED: 6C 0C          INC    ,X
62EF: BD 51 FD       JSR    $73DF
62F2: BD F6 05       JSR    $7427
62F5: 0C AA          INC    event_sub_state_28
62F7: 0F 02          CLR    event_sub_state_2a
62F9: 39             RTS

62FA: BD FB 4F       JSR    $7367
62FD: 0F 42          CLR    $CA
62FF: BD 72 17       JSR    $5035
6302: BD D3 67       JSR    $5145
6305: A6 46          LDA    ,U
6307: 81 76          CMPA   #$5E
6309: 27 8C          BEQ    $630F
630B: 81 05          CMPA   #$2D
630D: 26 31          BNE    $62C8
630F: BD 79 5D       JSR    $5B7F
6312: 86 8B          LDA    #$09
6314: 97 0A          STA    event_sub_state_28
6316: 86 80          LDA    #$02
6318: 97 02          STA    event_sub_state_2a
631A: 39             RTS

631B: 8E 18 88       LDX    #$30A0
631E: CE 5D 29       LDU   #table_d50b
6321: 96 A8          LDA    event_sub_state_2a
6323: 48             ASLA
6324: 6E F4          JMP    [A,U]		; [jump_table]
6326: 4F             CLRA
6327: BD 66 85       JSR    queue_sound_event_4ead
632A: 86 87          LDA    #$0F
632C: BD 66 25       JSR    queue_sound_event_4ead
632F: 6C A6          INC    ,X
6331: A6 80          LDA    $2,X
6333: 8B 24          ADDA   #$06
6335: A7 80          STA    $2,X
6337: BD AA DF       JSR    $82F7
633A: 86 96          LDA    #$1E
633C: 97 01          STA    $29
633E: 0F A2          CLR    event_sub_state_2a
6340: 0F E8          CLR    $CA
6342: BD D2 17       JSR    $5035
6345: BD D3 C7       JSR    $5145
6348: A6 EC          LDA    ,U
634A: 81 D6          CMPA   #$5E
634C: 27 2C          BEQ    $6352
634E: 81 A5          CMPA   #$2D
6350: 26 39          BNE    $636D
6352: E6 80          LDB    $2,X
6354: CB 26          ADDB   #$04
6356: D7 69          STB    $EB
6358: 8E 1A 48       LDX    #$32C0
635B: 6C AC          INC    ,X
635D: 86 D2          LDA    #$5A
635F: ED 23          STD    $1,X
6361: BD 01 BF       JSR    $833D
6364: 96 E9          LDA    $CB
6366: 26 81          BNE    $636B
6368: 0C 00          INC    event_sub_state_28
636A: 39             RTS

636B: 0C C7          INC    nb_long_horse_turns_ef
636D: 86 89          LDA    #$01
636F: 97 E9          STA    $CB
6371: 86 8A          LDA    #$08
6373: 97 0A          STA    event_sub_state_28
6375: 39             RTS

6376: 8E B2 88       LDX    #$30A0
6379: CE 5D 87       LDU   #table_d50f
637C: 96 02          LDA    event_sub_state_2a
637E: 48             ASLA
637F: 6E F4          JMP    [A,U]		; [jump_table]
6381: 0A AB          DEC    $29
6383: 26 00          BNE    $63A7
6385: CC 58 86       LDD    #$DA04
6388: DD 83          STD    $AB
638A: BD 0B 49       JSR    $8361
638D: 96 43          LDA    $CB
638F: 26 36          BNE    $63A5
6391: 8E B0 C2       LDX    #$3240
6394: CC FC 9D       LDD    #$DE1F
6397: ED 23          STD    $B,X
6399: BD 0B 10       JSR    $8398
639C: 4F             CLRA
639D: BD C6 3B       JSR    force_queue_sound_event_4eb3
63A0: 86 06          LDA    #$24
63A2: BD CC 91       JSR    force_queue_sound_event_4eb3
63A5: 0C A8          INC    event_sub_state_2a
63A7: 39             RTS

63A8: A6 AC          LDA    ,X
63AA: 81 8E          CMPA   #$06
63AC: 27 3C          BEQ    $63C2
63AE: 6C 8A          INC    $2,X
63B0: A6 20          LDA    $2,X
63B2: 81 72          CMPA   #$F0
63B4: 24 27          BCC    $63BB
63B6: BD 01 49       JSR    $8361
63B9: 20 8F          BRA    $63C2
63BB: BD AA 87       JSR    $82AF
63BE: 86 8E          LDA    #$06
63C0: A7 A6          STA    ,X
63C2: 8E B0 62       LDX    #$3240
63C5: A6 06          LDA    ,X
63C7: 81 2A          CMPA   #$02
63C9: 27 9A          BEQ    $63DD
63CB: 6C 2A          INC    $2,X
63CD: BD 0B 10       JSR    $8398
63D0: A6 20          LDA    $2,X
63D2: 91 69          CMPA   $EB
63D4: 25 32          BCS    $63E6
63D6: 6C 06          INC    ,X
63D8: 86 0C          LDA    #$24
63DA: BD C6 9B       JSR    force_queue_sound_event_4eb3
63DD: 96 28          LDA    $A0
63DF: 81 24          CMPA   #$06
63E1: 26 80          BNE    $63E5
63E3: 0C 08          INC    event_sub_state_2a
63E5: 39             RTS

63E6: 0F 48          CLR    $CA
63E8: BD 78 BD       JSR    $5035
63EB: EE 2B          LDU    $3,X
63ED: A6 4C          LDA    ,U
63EF: 81 7C          CMPA   #$5E
63F1: 27 88          BEQ    $63FD
63F3: 81 0F          CMPA   #$2D
63F5: 27 84          BEQ    $63FD
63F7: 81 1F          CMPA   #$37
63F9: 27 8E          BEQ    $6401
63FB: 20 20          BRA    $6405
63FD: 86 A7          LDA    #$2F
63FF: 20 20          BRA    $6403
6401: 86 AC          LDA    #$2E
6403: A7 E6          STA    ,U
6405: 8E B2 76       LDX    #$30F4
6408: CE F0 68       LDU    #$D8E0
640B: A6 2A          LDA    $2,X
640D: AB CA          ADDA   $2,U
640F: 19             DAA
6410: A7 20          STA    $2,X
6412: A6 83          LDA    $1,X
6414: A9 63          ADCA   $1,U
6416: 19             DAA
6417: A7 29          STA    $1,X
6419: A6 0C          LDA    ,X
641B: A9 EC          ADCA   ,U
641D: 19             DAA
641E: A7 0C          STA    ,X
6420: CE 01 6B       LDU    #$23E9
6423: 10 8E 12 1E    LDY    #$309C
6427: 86 2A          LDA    #$02
6429: 97 C0          STA    $48
642B: A6 AC          LDA    ,X
642D: 44             LSRA
642E: 44             LSRA
642F: 44             LSRA
6430: 44             LSRA
6431: A7 22          STA    ,Y+
6433: BD 60 0E       JSR    write_char_and_move_cursor_422c
6436: A6 02          LDA    ,X+
6438: 84 27          ANDA   #$0F
643A: A7 28          STA    ,Y+
643C: BD 6A A4       JSR    write_char_and_move_cursor_422c
643F: 0A 6A          DEC    $48
6441: 26 83          BNE    $6444
6443: 39             RTS

6444: 33 63          LEAU   $1,U
6446: 20 61          BRA    $642B
6448: BD 56 A1       JSR    $7E29
644B: BD 7C 4E       JSR    $5466
644E: 0F A0          CLR    event_sub_state_28
6450: 0F 08          CLR    event_sub_state_2a
6452: 0C A4          INC    $26
6454: 39             RTS

6455: 8E B2 22       LDX    #$30A0
6458: CE FD 9D       LDU   #table_d515
645B: 96 02          LDA    event_sub_state_2a
645D: 48             ASLA
645E: 6E 5E          JMP    [A,U]		; [jump_table]
6460: 86 24          LDA    #$06
6462: A7 06          STA    ,X
6464: 96 CD          LDA    nb_long_horse_turns_ef
6466: 27 D3          BEQ    $64B9
6468: 7F 1A E8       CLR    $3260
646B: CC 78 78       LDD    #$5050
646E: DE 50          LDU    $D8
6470: ED E3          STD    ,U++
6472: A7 46          STA    ,U
6474: DE F8          LDU    $DA
6476: ED 43          STD    ,U++
6478: A7 EC          STA    ,U
647A: 86 98          LDA    #$10
647C: A7 AC          STA    ,X
647E: EC 89          LDD    $1,X
6480: CB 26          ADDB   #$04
6482: FD B0 C3       STD    $32E1
6485: 7C B0 62       INC    $32E0
6488: 6F 29          CLR    $1,X
648A: 6F 8A          CLR    $2,X
648C: 8E 1A 68       LDX    #$32E0
648F: BD A0 8D       JSR    $82AF
6492: 86 86          LDA    #$04
6494: 97 E5          STA    $C7
6496: DE 53          LDU    $D1
6498: 33 77          LEAU   -$1,U
649A: 11 83 0D 57    CMPU   #$257F
649E: 26 8B          BNE    $64A3
64A0: CE 07 3D       LDU    #$25BF
64A3: DF F3          STU    $D1
64A5: B6 B0 A2       LDA    $3220
64A8: 26 24          BNE    $64B6
64AA: CC EC 28       LDD    #$6400
64AD: FD BA A9       STD    $3221
64B0: CC 06 55       LDD    #$24D7
64B3: FD 10 01       STD    $3223
64B6: 0C A8          INC    event_sub_state_2a
64B8: 39             RTS

64B9: A6 8A          LDA    $2,X
64BB: 8B 21          ADDA   #$09
64BD: A7 8A          STA    $2,X
64BF: BD A0 85       JSR    $82A7
64C2: 20 70          BRA    $64B6
64C4: 96 CD          LDA    nb_long_horse_turns_ef
64C6: 27 B6          BEQ    $64FC
64C8: 96 92          LDA    $BA
64CA: 81 0F          CMPA   #$87
64CC: 27 27          BEQ    $64DD
64CE: BD D6 C2       JSR    $5EE0
64D1: BD D9 A0       JSR    $5B22
64D4: 8E 10 A2       LDX    #$3220
64D7: 0F E2          CLR    $CA
64D9: BD D3 07       JSR    $5B8F
64DC: 39             RTS

64DD: 8E BA E8       LDX    #$3260
64E0: DC CE          LDD    $EC
64E2: 93 64          SUBD   $E6
64E4: 86 2A          LDA    #$08
64E6: 3D             MUL
64E7: DB C6          ADDB   $EE
64E9: CB 89          ADDB   #$01
64EB: C0 20          SUBB   #$08
64ED: CB A0          ADDB   #$28
64EF: C1 0A          CMPB   #$28
64F1: 24 80          BCC    $64F5
64F3: C6 0A          LDB    #$28
64F5: 86 D9          LDA    #$5B
64F7: ED 29          STD    $1,X
64F9: BD 0B 21       JSR    $83A9
64FC: 8E 1A A8       LDX    #$3220
64FF: A6 A6          LDA    ,X
6501: 27 85          BEQ    $650A
6503: 86 23          LDA    #$01
6505: A7 8F          STA    $D,X
6507: BD AB AF       JSR    $8387
650A: 0C A2          INC    event_sub_state_2a
650C: 39             RTS

650D: CE AB 61       LDU    #$23E9
6510: 8D 2F          BSR    $651F
6512: BD D6 44       JSR    $5466
6515: 7F B6 65       CLR    $34E7
6518: 0F 00          CLR    event_sub_state_28
651A: 0F A2          CLR    event_sub_state_2a
651C: 0C 0E          INC    $26
651E: 39             RTS

651F: 8E F7 3F       LDX    #$D51D
6522: 10 8E 12 B8    LDY    #$309A
6526: 86 87          LDA    #$05
6528: 97 60          STA    $48
652A: A6 08          LDA    ,X+
652C: A7 88          STA    ,Y+
652E: BD CA 0E       JSR    write_char_and_move_cursor_422c
6531: 0A CA          DEC    $48
6533: 26 D7          BNE    $652A
6535: 39             RTS

6536: 8E B2 88       LDX    #$30A0
6539: CE 5D AB       LDU   #table_d523
653C: 96 02          LDA    event_sub_state_2a
653E: 48             ASLA
653F: 6E F4          JMP    [A,U]		; [jump_table]
6541: A6 80          LDA    $2,X
6543: 8B 2A          ADDA   #$08
6545: A7 80          STA    $2,X
6547: BD AB 6F       JSR    $8347
654A: 8D B4          BSR    $6588
654C: 0F 94          CLR    $BC
654E: 86 8B          LDA    #$03
6550: 97 47          STA    $65
6552: 0C A8          INC    event_sub_state_2a
6554: 39             RTS

6555: CE 57 70       LDU    #$D5F2
6558: D6 94          LDB    $BC
655A: C1 9B          CMPB   #$13
655C: 27 3C          BEQ    $6572
655E: A6 4D          LDA    B,U
6560: 44             LSRA
6561: 8B DE          ADDA   #$5C
6563: A7 23          STA    $1,X
6565: 96 8D          LDA    $0F
6567: 44             LSRA
6568: 25 2A          BCS    $656C
656A: 6C 8A          INC    $2,X
656C: BD AB CF       JSR    $8347
656F: 0C 9E          INC    $BC
6571: 39             RTS

6572: 8D 96          BSR    $6588
6574: 0A 47          DEC    $65
6576: 26 8F          BNE    $6585
6578: A6 2A          LDA    $2,X
657A: 80 80          SUBA   #$08
657C: A7 2A          STA    $2,X
657E: CC 89 21       LDD    #$0103
6581: DD E7          STD    $65
6583: 0C 08          INC    event_sub_state_2a
6585: 0F 3E          CLR    $BC
6587: 39             RTS

6588: 86 36          LDA    #$1E
658A: BD C6 9B       JSR    force_queue_sound_event_4eb3
658D: 86 97          LDA    #$1F
658F: 7E 6C 91       JMP    force_queue_sound_event_4eb3
6592: 0A E7          DEC    $65
6594: 26 3C          BNE    $65B4
6596: 0A E4          DEC    $66
6598: 27 33          BEQ    $65B5
659A: A6 8A          LDA    $2,X
659C: 8B 20          ADDA   #$08
659E: A7 8A          STA    $2,X
65A0: BD A1 CF       JSR    $834D
65A3: 0C 9E          INC    $BC
65A5: 96 3E          LDA    $BC
65A7: 81 2A          CMPA   #$02
65A9: 26 8D          BNE    $65B0
65AB: 86 17          LDA    #$3F
65AD: BD C6 3B       JSR    force_queue_sound_event_4eb3
65B0: 86 2E          LDA    #$0C
65B2: 97 E7          STA    $65
65B4: 39             RTS

65B5: 7E E6 7E       JMP    $64FC

free_style_65b8:
65B8: 8E FD A3       LDX   #table_d52b
65BB: 96 00          LDA    event_sub_state_28
65BD: 48             ASLA
65BE: 6E 1E          JMP    [A,X]		; [jump_table]

65C0: 8E F7 B7       LDX   #table_d535
65C3: 96 08          LDA    event_sub_state_2a
65C5: 48             ASLA
65C6: 6E 14          JMP    [A,X]		; [jump_table]

65C8: 86 29          LDA    #$01
65CA: 97 FB          STA    $73
65CC: 86 2D          LDA    #$05
65CE: BD C6 B8       JSR    queue_event_4e9a
65D1: 8E B2 22       LDX    #$30A0
65D4: CE 17 8A       LDU    #$3508
65D7: 86 2C          LDA    #$04
65D9: 97 ED          STA    $65
65DB: 0F 31          CLR    $19
65DD: CC 53 41       LDD    #$DBC9
65E0: ED 29          STD    $B,X
65E2: CC 82 26       LDD    #$0004
65E5: ED 0A 92       STD    $10,X
65E8: 86 2E          LDA    #$06
65EA: A7 8D          STA    $5,X
65EC: CC CB 0F       LDD    #$E387
65EF: ED AA 0E       STD    $2C,X
65F2: 86 95          LDA    #$17
65F4: A7 AA AD       STA    $2F,X
65F7: 6F EC          CLR    ,U
65F9: 30 00 E8       LEAX   $60,X
65FC: 33 E0 A8       LEAU   $20,U
65FF: 0C 3B          INC    $19
6601: 0A E7          DEC    $65
6603: 26 FA          BNE    $65DD
6605: BD D4 82       JSR    $5600
6608: 8E 1A A8       LDX    #$3220
660B: 6C AC          INC    ,X
660D: BD 0D BD       JSR    $8535
6610: 86 3C          LDA    #$1E
6612: 97 A9          STA    $2B
6614: 0C 08          INC    event_sub_state_2a
6616: 39             RTS

6617: 0A 03          DEC    $2B
6619: 26 8C          BNE    $661F
661B: 0C 00          INC    event_sub_state_28
661D: 0F A2          CLR    event_sub_state_2a
661F: 39             RTS

6620: 8E 12 22       LDX    #$30A0
6623: 0F 3B          CLR    $19
6625: CE 57 BB       LDU   #table_d539
6628: 96 02          LDA    event_sub_state_2a
662A: 48             ASLA
662B: 6E FE          JMP    [A,U]		; [jump_table]
662D: 86 08          LDA    #$80
662F: BD 6C 8F       JSR    queue_sound_event_4ead
6632: 86 7D          LDA    #$FF
6634: BD 6C 2F       JSR    queue_sound_event_4ead
6637: 86 88          LDA    #$A0
6639: 97 A3          STA    $2B
663B: 0C 02          INC    event_sub_state_2a
663D: 39             RTS

663E: 0A A3          DEC    $2B
6640: 26 32          BNE    $6652
6642: 86 03          LDA    #$81
6644: BD 6C 2F       JSR    queue_sound_event_4ead
6647: 86 D7          LDA    #$FF
6649: BD C6 25       JSR    queue_sound_event_4ead
664C: 86 36          LDA    #$1E
664E: 97 A3          STA    $2B
6650: 0C 08          INC    event_sub_state_2a
6652: 39             RTS

6653: 0A 09          DEC    $2B
6655: 26 94          BNE    $666D
6657: 86 2C          LDA    #$04
6659: 97 C0          STA    $48
665B: BD AC F3       JSR    $84DB
665E: 0C 91          INC    $19
6660: 30 AA E2       LEAX   $60,X
6663: 0A 6A          DEC    $48
6665: 26 76          BNE    $665B
6667: 86 AA          LDA    #$82
6669: 97 A3          STA    $2B
666B: 0C 02          INC    event_sub_state_2a
666D: 39             RTS

666E: 86 8C          LDA    #$04
6670: 97 47          STA    $65
6672: A6 8F          LDA    $D,X
6674: 26 31          BNE    $6689
6676: BD CD A2       JSR    $4F8A
6679: A6 CA          LDA    $2,U
667B: AA 69          ORA    $1,U
667D: 43             COMA
667E: A4 4C          ANDA   ,U
6680: 84 27          ANDA   #$05
6682: 27 87          BEQ    $6689
6684: 6C A6          INC    ,X
6686: 0C A8          INC    event_sub_state_2a
6688: 39             RTS

6689: 0C 91          INC    $19
668B: 30 A0 48       LEAX   $60,X
668E: 0A ED          DEC    $65
6690: 26 C2          BNE    $6672
6692: 0A A9          DEC    $2B
6694: 26 13          BNE    $66C7
6696: 8E B0 08       LDX    #$3220
6699: BD 0D B3       JSR    $853B
669C: 86 38          LDA    #$10
669E: BD C6 91       JSR    force_queue_sound_event_4eb3
66A1: 86 93          LDA    #$11
66A3: BD 6C 91       JSR    force_queue_sound_event_4eb3
66A6: 86 90          LDA    #$12
66A8: BD 66 3B       JSR    force_queue_sound_event_4eb3
66AB: B6 19 15       LDA    $313D
66AE: 97 ED          STA    $65
66B0: FE 13 BC       LDU    $313E
66B3: 34 62          PSHS   U
66B5: C6 8C          LDB    #$0E
66B7: BD 7A DD       JSR    $52F5
66BA: 35 C8          PULS   U
66BC: 33 E0 C8       LEAU   $40,U
66BF: 0A 47          DEC    $65
66C1: 26 72          BNE    $66B3
66C3: 0C 0A          INC    event_sub_state_28
66C5: 0F A8          CLR    event_sub_state_2a
66C7: 39             RTS

66C8: 86 2C          LDA    #$04
66CA: 97 ED          STA    $65
66CC: 0F 72          CLR    $5A
66CE: A6 0C          LDA    ,X
66D0: 27 0A          BEQ    $66FA
66D2: 0D D8          TST    $5A
66D4: 27 26          BEQ    $66DA
66D6: 6F 06          CLR    ,X
66D8: 20 08          BRA    $66FA
66DA: 0C D2          INC    $5A
66DC: 96 94          LDA    $BC
66DE: 26 81          BNE    $66E9
66E0: A6 20          LDA    $2,X
66E2: 8B 92          ADDA   #$10
66E4: A7 20          STA    $2,X
66E6: BD 06 C8       JSR    $84E0
66E9: 96 34          LDA    $BC
66EB: 81 3A          CMPA   #$12
66ED: 26 83          BNE    $66FA
66EF: A6 20          LDA    $2,X
66F1: 8B 8A          ADDA   #$08
66F3: A7 20          STA    $2,X
66F5: BD 06 67       JSR    $84E5
66F8: 0C 02          INC    event_sub_state_2a
66FA: 30 00 48       LEAX   $60,X
66FD: 0C 91          INC    $19
66FF: 0A 47          DEC    $65
6701: 26 49          BNE    $66CE
6703: 0C 9E          INC    $BC
6705: 39             RTS

6706: 86 86          LDA    #$04
6708: 97 4D          STA    $65
670A: A6 0C          LDA    ,X
670C: 27 0F          BEQ    $6735
670E: 9F 76          STX    $FE
6710: 96 3B          LDA    $19
6712: D6 98          LDB    $1A
6714: 27 25          BEQ    $671D
6716: 4A             DECA
6717: D6 33          LDB    $1B
6719: 27 8A          BEQ    $671D
671B: 8B 2A          ADDA   #$02
671D: 97 75          STA    $FD
671F: BD 7B 90       JSR    $59B2
6722: A6 80          LDA    $2,X
6724: AB AA A2       ADDA   $20,X
6727: A7 2A          STA    $2,X
6729: BD 0C 6D       JSR    $84E5
672C: 96 94          LDA    $BC
672E: 81 9C          CMPA   #$14
6730: 26 21          BNE    $6735
6732: BD F5 47       JSR    $7765
6735: 30 0A E2       LEAX   $60,X
6738: 0C 31          INC    $19
673A: 0A ED          DEC    $65
673C: 26 E4          BNE    $670A
673E: 0C 34          INC    $BC
6740: 96 9E          LDA    $BC
6742: 81 AA          CMPA   #$28
6744: 27 6A          BEQ    $678E
6746: 81 BE          CMPA   #$3C
6748: 26 7B          BNE    $679D
674A: 0F 34          CLR    $BC
674C: 9E D6          LDX    $FE
674E: 6C 00 0B       INC    $29,X
6751: 8E B7 82       LDX    #$3500
6754: 96 DF          LDA    $FD
6756: C6 A2          LDB    #$20
6758: 3D             MUL
6759: 30 03          LEAX   D,X
675B: 9F D6          STX    $FE
675D: 6C 8B          INC    $3,X
675F: BD 74 22       JSR    $5600
6762: 8E B0 02       LDX    #$3220
6765: 6F 06          CLR    ,X
6767: 6F 29          CLR    $1,X
6769: 6F 8A          CLR    $2,X
676B: BD AD 13       JSR    $853B
676E: BD E8 5D       JSR    $607F
6771: 86 80          LDA    #$02
6773: D6 DF          LDB    $FD
6775: D7 9B          STB    $19
6777: CB 01          ADDB   #$29
6779: BD C6 12       JSR    queue_event_4e9a
677C: CC 2A 95       LDD    #$021D
677F: BD 6C B8       JSR    queue_event_4e9a
6782: CE A1 E6       LDU    #$23C4
6785: BD D1 FC       JSR    $537E
6788: 86 9C          LDA    #$B4
678A: 97 A3          STA    $2B
678C: 0C 02          INC    event_sub_state_2a
678E: 86 98          LDA    #$10
6790: BD 6C 31       JSR    force_queue_sound_event_4eb3
6793: 86 33          LDA    #$11
6795: BD CC 31       JSR    force_queue_sound_event_4eb3
6798: 86 3A          LDA    #$12
679A: BD C6 9B       JSR    force_queue_sound_event_4eb3
679D: 39             RTS

679E: BD DD 24       JSR    $5506
67A1: 96 A9          LDA    $2B
67A3: 81 82          CMPA   #$A0
67A5: 26 88          BNE    $67B1
67A7: 86 9B          LDA    #$B3
67A9: BD C6 3B       JSR    force_queue_sound_event_4eb3
67AC: 86 D7          LDA    #$FF
67AE: BD C6 91       JSR    force_queue_sound_event_4eb3
67B1: 0A A9          DEC    $2B
67B3: 26 32          BNE    $67C5
67B5: 9E 7C          LDX    $FE
67B7: A6 2B          LDA    $3,X
67B9: 81 8A          CMPA   #$02
67BB: 27 21          BEQ    $67C6
67BD: 0A AE          DEC    $26
67BF: 86 25          LDA    #$07
67C1: 97 AA          STA    event_sub_state_28
67C3: 0F 08          CLR    event_sub_state_2a
67C5: 39             RTS

67C6: CC 80 36       LDD    #$021E
67C9: BD C6 12       JSR    queue_event_4e9a
67CC: CC 2A 97       LDD    #$021F
67CF: BD 6C B8       JSR    queue_event_4e9a
67D2: 86 36          LDA    #$B4
67D4: 97 09          STA    $2B
67D6: 0C A8          INC    event_sub_state_2a
67D8: 39             RTS

67D9: BD DD 8E       JSR    $5506
67DC: 0A 03          DEC    $2B
67DE: 26 86          BNE    $67EE
67E0: 9E DC          LDX    $FE
67E2: 86 83          LDA    #$01
67E4: A7 26          STA    $4,X
67E6: 6A 83          DEC    $1,X
67E8: 27 2D          BEQ    $67EF
67EA: 86 81          LDA    #$09
67EC: 97 02          STA    event_sub_state_2a
67EE: 39             RTS

67EF: 6F A6          CLR    ,X
67F1: 6F 81          CLR    $3,X
67F3: 86 19          LDA    #$3B
67F5: BD CC 31       JSR    force_queue_sound_event_4eb3
67F8: CC 2A 80       LDD    #$0208
67FB: BD 66 B2       JSR    queue_event_4e9a
67FE: CC 8A 2B       LDD    #$0209
6801: BD CC 18       JSR    queue_event_4e9a
6804: 86 96          LDA    #$B4
6806: 97 A9          STA    $2B
6808: 0C 02          INC    event_sub_state_2a
680A: 39             RTS

680B: BD 7D 2E       JSR    $5506
680E: 0A A3          DEC    $2B
6810: 26 20          BNE    $6814
6812: 0C A8          INC    event_sub_state_2a
6814: 39             RTS

6815: 8E B7 82       LDX    #$3500
6818: 86 2C          LDA    #$04
681A: D6 92          LDB    $1A
681C: 27 21          BEQ    $6827
681E: 86 8A          LDA    #$02
6820: D6 39          LDB    $1B
6822: 27 81          BEQ    $6827
6824: 30 AA C2       LEAX   $40,X
6827: 97 60          STA    $48
6829: A6 0C          LDA    ,X
682B: 27 2C          BEQ    $6831
682D: A6 8C          LDA    $4,X
682F: 27 31          BEQ    $6844
6831: 30 0A A2       LEAX   $20,X
6834: 0A 6A          DEC    $48
6836: 26 73          BNE    $6829
6838: 96 32          LDA    $1A
683A: 27 87          BEQ    $684B
683C: 96 33          LDA    $1B
683E: 26 83          BNE    $684B
6840: 0C 39          INC    $1B
6842: 20 53          BRA    $6815
6844: 0A 04          DEC    $26
6846: 0F AA          CLR    event_sub_state_28
6848: 0F 02          CLR    event_sub_state_2a
684A: 39             RTS

684B: 86 2E          LDA    #$06
684D: 97 AE          STA    $26
684F: 0F 0A          CLR    event_sub_state_28
6851: 0F A8          CLR    event_sub_state_2a
6853: 39             RTS

6854: BD E2 82       JSR    $C000
6857: DC 58          LDD    $70
6859: 10 83 8A 38    CMPD   #$0210
685D: 27 B9          BEQ    $6890
685F: 0F 3B          CLR    $19
6861: 86 86          LDA    #$04
6863: 97 47          STA    $65
6865: 0F A3          CLR    $21
6867: 8E 18 88       LDX    #$30A0
686A: CE 5D 65       LDU   #table_d54d
686D: A6 0C          LDA    ,X
686F: 81 25          CMPA   #$07
6871: 26 80          BNE    $6875
6873: 0C 03          INC    $21
6875: 48             ASLA
6876: AD 54          JSR    [A,U]		; [jump_table]
6878: 0C 31          INC    $19
687A: 30 00 48       LEAX   $60,X
687D: 0A ED          DEC    $65
687F: 26 CB          BNE    $686A
6881: BD F6 F5       JSR    $7477
6884: BD 57 3E       JSR    $75BC
6887: 96 09          LDA    $21
6889: 81 8C          CMPA   #$04
688B: 26 2A          BNE    $688F
688D: 0C A0          INC    event_sub_state_28
688F: 39             RTS

6890: 0F 50          CLR    chrono_second_72
6892: 8E B2 82       LDX    #$30A0
6895: 86 86          LDA    #$04
6897: 97 4D          STA    $65
6899: 0F 91          CLR    $19
689B: A6 AC          LDA    ,X
689D: 81 8F          CMPA   #$07
689F: 27 24          BEQ    $68A7
68A1: BD FB 02       JSR    $7980
68A4: BD A6 21       JSR    $84A3
68A7: 30 A0 48       LEAX   $60,X
68AA: 0C 91          INC    $19
68AC: 0A 4D          DEC    $65
68AE: 26 63          BNE    $689B
68B0: 0C 0A          INC    event_sub_state_28
68B2: 39             RTS

68B3: 6F AA 02       CLR    $20,X
68B6: BD CD 89       JSR    $4FA1
68B9: 84 8D          ANDA   #$05
68BB: 27 0B          BEQ    $68E0
68BD: 81 8D          CMPA   #$05
68BF: 26 21          BNE    $68C4
68C1: 6C 0A D9       INC    $5B,X
68C4: 6C A6          INC    ,X
68C6: A6 8D          LDA    $F,X
68C8: 8B 38          ADDA   #$10
68CA: A7 87          STA    $F,X
68CC: A6 A0 CF       LDA    $47,X
68CF: 27 24          BEQ    $68D7
68D1: 86 92          LDA    #$10
68D3: A7 AA 02       STA    $20,X
68D6: 39             RTS

68D7: A6 2A          LDA    $2,X
68D9: 8B 98          ADDA   #$10
68DB: A7 2A          STA    $2,X
68DD: BD 0C 68       JSR    $84E0
68E0: 39             RTS

68E1: BD F6 D7       JSR    $7455
68E4: 6D AA D9       TST    $5B,X
68E7: 27 22          BEQ    $68F3
68E9: BD C7 29       JSR    $4FA1
68EC: 84 2A          ANDA   #$02
68EE: 27 8B          BEQ    $68F3
68F0: 6C AA D9       INC    $5B,X
68F3: 6F AA 02       CLR    $20,X
68F6: 6C 0A 34       INC    $1c,X
68F9: A6 00 94       LDA    $1c,X
68FC: 81 3A          CMPA   #$12
68FE: 26 95          BNE    $691D
6900: 6C AA C9       INC    $4B,X
6903: A6 2D          LDA    $F,X
6905: 8B 8A          ADDA   #$08
6907: A7 27          STA    $F,X
6909: A6 00 CF       LDA    $47,X
690C: 27 2E          BEQ    $6914
690E: 86 80          LDA    #$08
6910: A7 AA A2       STA    $20,X
6913: 39             RTS

6914: A6 20          LDA    $2,X
6916: 8B 8A          ADDA   #$08
6918: A7 2A          STA    $2,X
691A: BD 0C CD       JSR    $84E5
691D: 39             RTS

691E: BD FC 77       JSR    $7455
6921: BD DB 30       JSR    $59B2
6924: BD 55 DB       JSR    $7759
6927: 6D A0 73       TST    $5B,X
692A: 27 82          BEQ    $6936
692C: BD 67 29       JSR    $4FA1
692F: 84 20          ANDA   #$02
6931: 27 81          BEQ    $6936
6933: 6C AA 79       INC    $5B,X
6936: 6C 0A 34       INC    $1c,X
6939: A6 00 94       LDA    $1c,X
693C: 81 78          CMPA   #$50
693E: 27 85          BEQ    $694D
6940: 81 3C          CMPA   #$1E
6942: 26 8A          BNE    $694C
6944: BD 55 E7       JSR    $7765
6947: 86 3D          LDA    #$15
6949: BD C6 3B       JSR    force_queue_sound_event_4eb3
694C: 39             RTS

694D: 6C 0C          INC    ,X
694F: 6F AA 3E       CLR    $1c,X
6952: 39             RTS

6953: BD 7B A0       JSR    $5982
6956: BD FB 02       JSR    $792A
6959: BD F0 F3       JSR    $787B
695C: BD 71 3A       JSR    $59B2
695F: BD 55 7B       JSR    $7759
6962: EC 8C          LDD    $E,X
6964: 83 21 7A       SUBD   #$03F8
6967: 25 73          BCS    $69C4
6969: D7 D8          STB    $50
696B: A6 2A          LDA    $2,X
696D: 81 08          CMPA   #$80
696F: 26 2A          BNE    $6979
6971: A6 0A A2       LDA    $20,X
6974: 90 72          SUBA   $50
6976: BD F5 B5       JSR    $779D
6979: CC 8B 70       LDD    #$03F8
697C: ED 26          STD    $E,X
697E: 86 08          LDA    #$80
6980: A0 20          SUBA   $2,X
6982: 97 D3          STA    $51
6984: 86 A2          LDA    #$80
6986: 9B D2          ADDA   $50
6988: A7 2A          STA    $2,X
698A: 6C 0C          INC    ,X
698C: 6C A0 B2       INC    $3A,X
698F: BD 5A 1C       JSR    $783E
6992: A6 0A 02       LDA    $20,X
6995: 90 D2          SUBA   $50
6997: 90 79          SUBA   $51
6999: A7 00 A8       STA    $20,X
699C: 86 C8          LDA    #$E0
699E: A0 00 38       SUBA   $1A,X
69A1: 25 87          BCS    $69A8
69A3: BD 55 BF       JSR    $779D
69A6: 20 86          BRA    $69AC
69A8: 40             NEGA
69A9: BD F0 8E       JSR    $7806
69AC: EE A0 B9       LDU    $31,X
69AF: 33 7D          LEAU   -$1,U
69B1: EF 0A B3       STU    $31,X
69B4: 96 FA          LDA    $D8
69B6: 26 8E          BNE    $69C4
69B8: 96 31          LDA    $19
69BA: 4C             INCA
69BB: 97 F0          STA    $D8
69BD: A6 00 A8       LDA    $20,X
69C0: 97 C4          STA    $E6
69C2: 0C 5F          INC    $DD
69C4: 39             RTS

69C5: BD DB 00       JSR    $5982
69C8: BD 50 F3       JSR    $787B
69CB: BD 71 9A       JSR    $59B2
69CE: A6 8A          LDA    $2,X
69D0: AB AA A2       ADDA   $20,X
69D3: 81 F2          CMPA   #$D0
69D5: 25 93          BCS    $69E8
69D7: 86 02          LDA    #$2A
69D9: BD C6 3B       JSR    force_queue_sound_event_4eb3
69DC: 6C AC          INC    ,X
69DE: 86 58          LDA    #$D0
69E0: A7 20          STA    $2,X
69E2: BD FA 1C       JSR    $783E
69E5: 7E 06 21       JMP    $84A3
69E8: A7 2A          STA    $2,X
69EA: 7E F0 16       JMP    $783E
69ED: BD FC DD       JSR    $7455
69F0: A6 AA 9E       LDA    $1c,X
69F3: 81 3C          CMPA   #$1E
69F5: 27 85          BEQ    $69FE
69F7: BD AC C7       JSR    $84EF
69FA: 6C 00 34       INC    $1c,X
69FD: 39             RTS

69FE: 6C 0C          INC    ,X
6A00: 6C AA B8       INC    $3A,X
6A03: 86 F2          LDA    #$D0
6A05: A7 80          STA    $2,X
6A07: CC F3 DC       LDD    #$DBF4
6A0A: ED 83          STD    $B,X
6A0C: BD AB 33       JSR    $83BB
6A0F: 6F AA 02       CLR    $20,X
6A12: 39             RTS

6A13: BD 7B A0       JSR    $5982
6A16: BD FB 02       JSR    $792A
6A19: BD F0 F3       JSR    $787B
6A1C: BD 71 3A       JSR    $59B2
6A1F: BD 55 7B       JSR    $7759
6A22: EC 8C          LDD    $E,X
6A24: 83 2A AA       SUBD   #$0828
6A27: 24 6C          BCC    $6A6D
6A29: 96 54          LDA    $DC
6A2B: 26 0D          BNE    $6A52
6A2D: EC 86          LDD    $E,X
6A2F: 83 26 6A       SUBD   #$0448
6A32: 25 9F          BCS    $6A51
6A34: CC 26 CA       LDD    #$0448
6A37: ED 26          STD    $E,X
6A39: E6 8A          LDB    $2,X
6A3B: 86 A8          LDA    #$80
6A3D: A7 8A          STA    $2,X
6A3F: C0 A2          SUBB   #$80
6A41: E7 0A A2       STB    $20,X
6A44: BD 5A BC       JSR    $783E
6A47: 6F A0 08       CLR    $20,X
6A4A: 96 91          LDA    $19
6A4C: 4C             INCA
6A4D: 97 54          STA    $DC
6A4F: 0C FC          INC    $DE
6A51: 39             RTS

6A52: 96 5C          LDA    $DE
6A54: 27 34          BEQ    $6A6C
6A56: EC 8C          LDD    $E,X
6A58: 83 2C C0       SUBD   #$0448
6A5B: 23 27          BLS    $6A6C
6A5D: D7 D9          STB    $51
6A5F: CC 26 6A       LDD    #$0448
6A62: ED 8C          STD    $E,X
6A64: A6 AA A2       LDA    $20,X
6A67: 90 79          SUBA   $51
6A69: A7 00 A8       STA    $20,X
6A6C: 39             RTS

6A6D: D7 D8          STB    $50
6A6F: A6 20          LDA    $2,X
6A71: 81 02          CMPA   #$80
6A73: 26 28          BNE    $6A7F
6A75: A6 0A A2       LDA    $20,X
6A78: 90 78          SUBA   $50
6A7A: 97 D9          STA    $51
6A7C: BD 50 8E       JSR    $7806
6A7F: CC 2A 0A       LDD    #$0828
6A82: ED 8C          STD    $E,X
6A84: A6 20          LDA    $2,X
6A86: 80 02          SUBA   #$80
6A88: 97 79          STA    $51
6A8A: 86 08          LDA    #$80
6A8C: A7 2A          STA    $2,X
6A8E: 6C 0C          INC    ,X
6A90: 6C AA B8       INC    $3A,X
6A93: A6 AA 02       LDA    $20,X
6A96: 90 D2          SUBA   $50
6A98: 90 79          SUBA   $51
6A9A: A7 00 08       STA    $20,X
6A9D: BD 0C 62       JSR    $84EA
6AA0: A6 AA 98       LDA    $1A,X
6AA3: 2B 27          BMI    $6AAA
6AA5: BD FA 84       JSR    $7806
6AA8: 20 2C          BRA    $6AAE
6AAA: 40             NEGA
6AAB: BD 5F B5       JSR    $779D
6AAE: A6 85          LDA    $D,X
6AB0: 26 20          BNE    $6AB4
6AB2: 96 5B          LDA    $D9
6AB4: 26 2E          BNE    $6AC2
6AB6: 96 9B          LDA    $19
6AB8: 4C             INCA
6AB9: 97 51          STA    $D9
6ABB: A6 A0 08       LDA    $20,X
6ABE: 97 7A          STA    $F2
6AC0: 0C FD          INC    $DF
6AC2: BD FB A2       JSR    $7980
6AC5: 34 D2          PSHS   U,X
6AC7: 96 31          LDA    $19
6AC9: 97 FF          STA    $77
6ACB: CE FD 75       LDU   #table_d55d
6ACE: 96 91          LDA    $19
6AD0: 48             ASLA
6AD1: AD 54          JSR    [A,U]        ; [jump_table]
6AD3: 96 55          LDA    $77
6AD5: 97 9B          STA    $19
6AD7: 35 78          PULS   X,U
6AD9: 7E 0C 2B       JMP    $84A3

6ADC: 6F A0 A8       CLR    $20,X
6ADF: 39             RTS

6AE0: BD 5F 3F       JSR    $7DBD
6AE3: BD A3 82       JSR    $81A0
6AE6: 8E B7 20       LDX    #$3508
6AE9: C6 8C          LDB    #$04
6AEB: 6D AC          TST    ,X
6AED: 26 83          BNE    $6AFA
6AEF: 30 AA 02       LEAX   $20,X
6AF2: 5A             DECB
6AF3: 26 D4          BNE    $6AEB
6AF5: 0C A4          INC    $26
6AF7: 0F 00          CLR    event_sub_state_28
6AF9: 39             RTS

6AFA: 0C A0          INC    event_sub_state_28
6AFC: 86 35          LDA    #$1D
6AFE: BD C6 91       JSR    force_queue_sound_event_4eb3
6B01: 39             RTS

6B02: 8E 57 47       LDX   #table_d565
6B05: 96 A8          LDA    event_sub_state_2a
6B07: 48             ASLA
6B08: 6E BE          JMP    [A,X]        ; [jump_table]
6B0A: 8E BA B8       LDX    #$3290
6B0D: CE 5D E1       LDU    #$D569
6B10: 86 26          LDA    #$04
6B12: 97 CA          STA    $48
6B14: 6F A6          CLR    ,X
6B16: EC 43          LDD    ,U++
6B18: ED 29          STD    $1,X
6B1A: 30 00 08       LEAX   $20,X
6B1D: 0A C0          DEC    $48
6B1F: 26 D1          BNE    $6B14
6B21: 8E B7 8A       LDX    #$3508
6B24: CE 10 12       LDU    #$3290
6B27: C6 2C          LDB    #$04
6B29: 0D 92          TST    $1A
6B2B: 27 24          BEQ    $6B39
6B2D: C6 8A          LDB    #$02
6B2F: 33 EA 02       LEAU   $20,U
6B32: 0D 99          TST    $1B
6B34: 27 21          BEQ    $6B39
6B36: 8E B7 60       LDX    #$3548
6B39: 6D 0C          TST    ,X
6B3B: 27 2A          BEQ    $6B3F
6B3D: 6C 4C          INC    ,U
6B3F: 30 AA 02       LEAX   $20,X
6B42: 33 4A 02       LEAU   $20,U
6B45: 5A             DECB
6B46: 26 73          BNE    $6B39
6B48: 86 14          LDA    #$3C
6B4A: 97 A3          STA    $2B
6B4C: 0C 02          INC    event_sub_state_2a
6B4E: 39             RTS

6B4F: 86 1E          LDA    #$3C
6B51: 90 A9          SUBA   $2B
6B53: C6 2D          LDB    #$0F
6B55: BD 24 84       JSR    $A606
6B58: C1 2A          CMPB   #$02
6B5A: 25 8A          BCS    $6B5E
6B5C: C6 2A          LDB    #$02
6B5E: D7 D8          STB    $50
6B60: 8E 10 12       LDX    #$3290
6B63: 86 26          LDA    #$04
6B65: 97 CA          STA    $48
6B67: 0F 79          CLR    $51
6B69: BD 0A B8       JSR    $8230
6B6C: 0C 79          INC    $51
6B6E: 30 00 02       LEAX   $20,X
6B71: 0A CA          DEC    $48
6B73: 26 D6          BNE    $6B69
6B75: 0A A9          DEC    $2B
6B77: 26 7A          BNE    $6BCB
6B79: 8E BA 18       LDX    #$3290
6B7C: 86 2C          LDA    #$04
6B7E: 97 C0          STA    $48
6B80: 0F 6B          CLR    $49
6B82: 6D 06          TST    ,X
6B84: 27 2D          BEQ    $6B95
6B86: EC 83          LDD    $1,X
6B88: 8B 22          ADDA   #$0A
6B8A: 34 98          PSHS   X
6B8C: 30 38          LEAX   -$10,X
6B8E: ED 89          STD    $1,X
6B90: BD A0 D1       JSR    $8253
6B93: 35 32          PULS   X
6B95: 30 0A A2       LEAX   $20,X
6B98: 0C 61          INC    $49
6B9A: 0A C0          DEC    $48
6B9C: 26 CC          BNE    $6B82
6B9E: 8E BD 2A       LDX    #$3508
6BA1: 0F F5          CLR    $77
6BA3: 86 26          LDA    #$04
6BA5: 97 D6          STA    $54
6BA7: 6D AC          TST    ,X
6BA9: 27 84          BEQ    $6BB7
6BAB: 34 38          PSHS   X
6BAD: 86 8B          LDA    #$03
6BAF: B7 16 C4       STA    $34E6
6BB2: BD 02 D4       JSR    $80F6
6BB5: 35 92          PULS   X
6BB7: 30 A0 08       LEAX   $20,X
6BBA: 0C FF          INC    $77
6BBC: 0A 7C          DEC    $54
6BBE: 26 6F          BNE    $6BA7
6BC0: 86 1B          LDA    #$39
6BC2: BD CC 91       JSR    force_queue_sound_event_4eb3
6BC5: 0F AA          CLR    event_sub_state_28
6BC7: 0F 02          CLR    event_sub_state_2a
6BC9: 0C AE          INC    $26
6BCB: 39             RTS

long_horse_6bcc:
6BCC: 8E 18 28       LDX    #$30A0
6BCF: CE F7 53       LDU   #table_d571
6BD2: 96 AA          LDA    event_sub_state_28
6BD4: 48             ASLA
6BD5: 6E 54          JMP    [A,U]        ; [jump_table]

6BD7: CE FD A5       LDU   #table_d58d
6BDA: 96 A2          LDA    event_sub_state_2a
6BDC: 48             ASLA
6BDD: 6E 5E          JMP    [A,U]        ; [jump_table]

6BDF: BD A0 85       JSR    $82A7
6BE2: CC 8E 32       LDD    #$0C10
6BE5: FD B1 F7       STD    $3375
6BE8: 86 05          LDA    #$2D
6BEA: 97 4C          STA    $C4
6BEC: 8E 1A 08       LDX    #$3280
6BEF: BD A7 82       JSR    $85A0
6BF2: 8E B0 82       LDX    #$32A0
6BF5: BD 07 22       JSR    $85A0
6BF8: 86 36          LDA    #$1E
6BFA: 97 A3          STA    $2B
6BFC: 0C 02          INC    event_sub_state_2a
6BFE: 39             RTS

6BFF: 0A 09          DEC    $2B
6C01: 26 8B          BNE    $6C0C
6C03: 86 05          LDA    #$27
6C05: BD CC 31       JSR    force_queue_sound_event_4eb3
6C08: 0C 00          INC    event_sub_state_28
6C0A: 0F A2          CLR    event_sub_state_2a
6C0C: 39             RTS

6C0D: CE 5D 19       LDU   #table_d591
6C10: 96 08          LDA    event_sub_state_2a
6C12: 48             ASLA
6C13: 6E F4          JMP    [A,U]        ; [jump_table]
6C15: 0D 82          TST    game_playing_00
6C17: 27 2F          BEQ    $6C20
6C19: BD C7 29       JSR    $4FA1
6C1C: 84 2D          ANDA   #$05
6C1E: 26 A4          BNE    $6C4C
6C20: BD 75 1D       JSR    $579F
6C23: CE 16 D3       LDU    #$34F1
6C26: A6 C3          LDA    $1,U
6C28: 81 27          CMPA   #$0F
6C2A: 27 C9          BEQ    $6C6D
6C2C: 0D 28          TST    game_playing_00
6C2E: 26 8C          BNE    $6C34
6C30: 81 23          CMPA   #$01
6C32: 27 9A          BEQ    $6C4C
6C34: A6 E6          LDA    ,U
6C36: 26 91          BNE    $6C4B
6C38: A6 69          LDA    $1,U
6C3A: 81 86          CMPA   #$0E
6C3C: 27 20          BEQ    $6C46
6C3E: 81 83          CMPA   #$0B
6C40: 27 26          BEQ    $6C46
6C42: 81 8A          CMPA   #$08
6C44: 26 27          BNE    $6C4B
6C46: 86 BA          LDA    #$38
6C48: BD 66 3B       JSR    force_queue_sound_event_4eb3
6C4B: 39             RTS

6C4C: FC 1C 79       LDD    $34F1
6C4F: 10 83 22 80    CMPD   #$0002
6C53: 26 24          BNE    $6C5B
6C55: 0C 65          INC    $E7
6C57: C6 A2          LDB    #$8A
6C59: 8D A0          BSR    $6C83
6C5B: CC F1 B7       LDD    #$D99F
6C5E: DD 23          STD    $AB
6C60: 7F 16 73       CLR    $34F1
6C63: 7F 16 D0       CLR    $34F2
6C66: 86 87          LDA    #$05
6C68: 97 03          STA    $2B
6C6A: 0C A2          INC    event_sub_state_2a
6C6C: 39             RTS

6C6D: 86 85          LDA    #$0D
6C6F: 97 0A          STA    event_sub_state_28
6C71: 86 83          LDA    #$01
6C73: 97 0B          STA    $29
6C75: 39             RTS

6C76: 0A A9          DEC    $2B
6C78: 26 20          BNE    $6C82
6C7A: C6 08          LDB    #$80
6C7C: 8D 2D          BSR    $6C83
6C7E: 0F A2          CLR    event_sub_state_2a
6C80: 0C 0A          INC    event_sub_state_28
6C82: 39             RTS

6C83: CE 00 65       LDU    #$2247
6C86: 10 8E FD BD    LDY    #$D595
6C8A: 86 8A          LDA    #$02
6C8C: 97 60          STA    $48
6C8E: 86 8A          LDA    #$02
6C90: 97 6B          STA    $49
6C92: A6 22          LDA    ,Y+
6C94: BD 60 AF       JSR    $422D
6C97: 0A 61          DEC    $49
6C99: 26 7F          BNE    $6C92
6C9B: 33 E0 16       LEAU   $3E,U
6C9E: 0A C0          DEC    $48
6CA0: 26 CE          BNE    $6C8E
6CA2: 39             RTS

6CA3: CE F7 E0       LDU    #$D5C2
6CA6: 96 EA          LDA    current_level_68
6CA8: C6 2F          LDB    #$07
6CAA: BD 2E 2E       JSR    $A606
6CAD: C1 8D          CMPB   #$05
6CAF: 25 20          BCS    $6CB3
6CB1: C6 87          LDB    #$05
6CB3: 86 21          LDA    #$03
6CB5: 3D             MUL
6CB6: 33 49          LEAU   D,U
6CB8: EC EC          LDD    ,U
6CBA: DD D8          STD    $50
6CBC: A6 6A          LDA    $2,U
6CBE: 97 DA          STA    $52
6CC0: 0F 71          CLR    $53
6CC2: BD 32 36       JSR    $B014
6CC5: BD DB 30       JSR    $59B2
6CC8: BD 70 33       JSR    $58BB
6CCB: 86 2B          LDA    #$03
6CCD: BD C6 12       JSR    queue_event_4e9a
6CD0: BD 72 B7       JSR    $5035
6CD3: BD 43 78       JSR    $615A
6CD6: 0D 22          TST    $A0
6CD8: 27 2A          BEQ    $6CDC
6CDA: 0C A0          INC    event_sub_state_28
6CDC: 39             RTS

6CDD: BD D1 3A       JSR    $59B2
6CE0: BD 7A 39       JSR    $58BB
6CE3: 0F E8          CLR    $CA
6CE5: BD D2 B7       JSR    $5035
6CE8: BD 79 CD       JSR    $5145
6CEB: A6 EC          LDA    ,U		; [video_address]
6CED: 81 23          CMPA   #$AB
6CEF: 27 0F          BEQ    $6D1E
6CF1: BD CD 23       JSR    $4FA1
6CF4: 84 20          ANDA   #$02
6CF6: 26 8C          BNE    $6D06
6CF8: 0D 28          TST    game_playing_00
6CFA: 26 A9          BNE    $6D1D
6CFC: BD 7F 17       JSR    $579F
6CFF: B6 16 D3       LDA    $34F1
6D02: 81 88          CMPA   #$0A
6D04: 26 35          BNE    $6D1D
6D06: BD F8 E9       JSR    $7AC1
6D09: 86 86          LDA    #$0E
6D0B: BD 66 85       JSR    queue_sound_event_4ead
6D0E: 0D 66          TST    $EE
6D10: 27 27          BEQ    $6D17
6D12: 86 A0          LDA    #$22
6D14: BD 6C 2F       JSR    queue_sound_event_4ead
6D17: 0F ED          CLR    $C5
6D19: 0C 28          INC    $A0
6D1B: 0C 00          INC    event_sub_state_28
6D1D: 39             RTS

6D1E: CC 51 8F       LDD    #$D9AD
6D21: ED 89          STD    $B,X
6D23: BD A0 95       JSR    $82B7
6D26: BD D9 57       JSR    $5B7F
6D29: A6 8A          LDA    $2,X
6D2B: 8B 20          ADDA   #$08
6D2D: A7 8A          STA    $2,X
6D2F: 86 2A          LDA    #$08
6D31: 97 AB          STA    $29
6D33: 86 2E          LDA    #$0C
6D35: 97 AA          STA    event_sub_state_28
6D37: 39             RTS

6D38: CE FD 11       LDU   #table_d599
6D3B: 96 02          LDA    event_sub_state_2a
6D3D: 48             ASLA
6D3E: 6E 5E          JMP    [A,U]        ; [jump_table]
6D40: CE F7 1D       LDU    #$D59F
6D43: 96 C9          LDA    $EB
6D45: A6 44          LDA    A,U
6D47: A7 29          STA    $1,X
6D49: A6 8A          LDA    $2,X
6D4B: 8B 24          ADDA   #$0C
6D4D: A7 8A          STA    $2,X
6D4F: BD A7 67       JSR    $8545
6D52: 0D 6C          TST    $EE
6D54: 27 2A          BEQ    $6D5E
6D56: CE A6 EF       LDU    #$24C7
6D59: 8E 5D 39       LDX    #$D5B1
6D5C: 8D 3E          BSR    $6D74
6D5E: 86 8E          LDA    #$06
6D60: 97 09          STA    $2B
6D62: 0C A8          INC    event_sub_state_2a
6D64: 39             RTS

6D65: 0A A9          DEC    $2B
6D67: 26 22          BNE    $6D73
6D69: CE AC 4F       LDU    #$24C7
6D6C: 8E FD 2E       LDX    #$D5A6
6D6F: 8D 21          BSR    $6D74
6D71: 0C A8          INC    event_sub_state_2a
6D73: 39             RTS

6D74: 86 20          LDA    #$02
6D76: 97 E7          STA    $65
6D78: E6 A8          LDB    ,X+
6D7A: 96 98          LDA    $10
6D7C: 84 08          ANDA   #$20
6D7E: 26 8E          BNE    $6D86
6D80: C1 82          CMPB   #$A0
6D82: 26 80          BNE    $6D86
6D84: C6 E2          LDB    #$C0
6D86: 86 87          LDA    #$05
6D88: 97 4E          STA    $66
6D8A: E7 41 20 28    STB    $0800,U					;  [video_address]
6D8E: A6 08          LDA    ,X+
6D90: A7 E2          STA    ,U+					;  [video_address]
6D92: 0A E4          DEC    $66
6D94: 26 D6          BNE    $6D8A
6D96: 33 4A 13       LEAU   $3B,U
6D99: 0A ED          DEC    $65
6D9B: 26 C1          BNE    $6D86
6D9D: 39             RTS

6D9E: DC 38          LDD    speed_msb_b0
6DA0: DD D2          STD    $F0
6DA2: DC 30          LDD    $B2
6DA4: DD D0          STD    $F2
6DA6: CC 83 29       LDD    #$0101
6DA9: DD 38          STD    speed_msb_b0
6DAB: 0F 9A          CLR    $B2
6DAD: 0F 3B          CLR    $B3
6DAF: CE 13 62       LDU    #$3140
6DB2: 10 8E 11 58    LDY    #$337A
6DB6: 8D F1          BSR    $6E2B
6DB8: BD E8 AF       JSR    $C027
6DBB: EB 29          ADDB   $1,X
6DBD: E7 89          STB    $1,X
6DBF: CE 11 58       LDU    #$337A
6DC2: 10 8E 13 62    LDY    #$3140
6DC6: 8D E1          BSR    $6E2B
6DC8: DC D8          LDD    $F0
6DCA: DD 38          STD    speed_msb_b0
6DCC: DC DA          LDD    $F2
6DCE: DD 3A          STD    $B2
6DD0: 0A 9E          DEC    $BC
6DD2: CE B3 64       LDU    #$3146
6DD5: 10 8E B1 52    LDY    #$337A
6DD9: 8D D8          BSR    $6E2B
6DDB: BD E8 0F       JSR    $C027
6DDE: 97 48          STA    $C0
6DE0: CE 11 F8       LDU    #$337A
6DE3: 10 8E 13 C4    LDY    #$3146
6DE7: 8D 6A          BSR    $6E2B
6DE9: 96 4D          LDA    $C5
6DEB: 26 30          BNE    $6E05
6DED: A6 8A          LDA    $2,X
6DEF: 9B E2          ADDA   $C0
6DF1: 81 F2          CMPA   #$70
6DF3: 25 2E          BCS    $6E01
6DF5: 80 F2          SUBA   #$70
6DF7: 97 EF          STA    $C7
6DF9: 86 F8          LDA    #$70
6DFB: A7 2A          STA    $2,X
6DFD: 0C 4D          INC    $C5
6DFF: 20 2A          BRA    $6E09
6E01: A7 80          STA    $2,X
6E03: 20 25          BRA    $6E0C
6E05: 96 42          LDA    $C0
6E07: 97 EF          STA    $C7
6E09: BD D1 86       JSR    $590E
6E0C: BD AD CD       JSR    $8545
6E0F: 96 9E          LDA    $BC
6E11: 81 B5          CMPA   #$37
6E13: 26 37          BNE    $6E2A
6E15: 6C 06          INC    ,X
6E17: 86 5C          LDA    #$74
6E19: A7 89          STA    $1,X
6E1B: BD 78 0F       JSR    $5027
6E1E: 86 D8          LDA    #$50
6E20: 97 E6          STA    $C4
6E22: 0F 47          CLR    $C5
6E24: 0F 9E          CLR    $BC
6E26: 0F A8          CLR    event_sub_state_2a
6E28: 0C 00          INC    event_sub_state_28
6E2A: 39             RTS

6E2B: EC E9          LDD    ,U++
6E2D: ED 29          STD    ,Y++
6E2F: EC E3          LDD    ,U++
6E31: ED 23          STD    ,Y++
6E33: EC E3          LDD    ,U++
6E35: ED 23          STD    ,Y++
6E37: 39             RTS

6E38: 96 94          LDA    $BC
6E3A: 26 8F          BNE    $6E43
6E3C: 86 26          LDA    #$0E
6E3E: BD C6 8F       JSR    queue_sound_event_4ead
6E41: 20 96          BRA    $6E57
6E43: 81 06          CMPA   #$24
6E45: 10 27 82 84    LBEQ   $6EF5
6E49: C6 84          LDB    #$0C
6E4B: BD 8E 2E       JSR    $A606
6E4E: 4D             TSTA
6E4F: 26 2B          BNE    $6E5A
6E51: A6 80          LDA    $2,X
6E53: 8B 20          ADDA   #$02
6E55: A7 80          STA    $2,X
6E57: BD AD 48       JSR    $8560
6E5A: 0C 34          INC    $BC
6E5C: 0D 28          TST    game_playing_00
6E5E: 26 8E          BNE    $6E66
6E60: 96 9E          LDA    $BC
6E62: 81 9C          CMPA   #$1E
6E64: 27 2B          BEQ    $6E6F
6E66: BD CD 89       JSR    $4FA1
6E69: 84 8A          ANDA   #$02
6E6B: 10 27 28 0D    LBEQ   $6EF4
6E6F: 7F 14 0F       CLR    $362D
6E72: 7F B4 0D       CLR    $362F
6E75: EC 83          LDD    $1,X
6E77: 8B 3A          ADDA   #$12
6E79: CB 9C          ADDB   #$14
6E7B: ED 29          STD    $1,X
6E7D: CE 5D 34       LDU    #$D5BC
6E80: 96 9E          LDA    $BC
6E82: C6 84          LDB    #$06
6E84: BD 84 84       JSR    $A606
6E87: C1 2D          CMPB   #$05
6E89: 25 8A          BCS    $6E8D
6E8B: C6 2D          LDB    #$05
6E8D: D7 7C          STB    $F4
6E8F: A6 E7          LDA    B,U
6E91: 97 46          STA    $C4
6E93: CE F7 EC       LDU    #$D5CE
6E96: 96 EA          LDA    current_level_68
6E98: C6 2F          LDB    #$07
6E9A: BD 2E 2E       JSR    $A606
6E9D: C1 8D          CMPB   #$05
6E9F: 25 20          BCS    $6EA3
6EA1: C6 87          LDB    #$05
6EA3: 86 21          LDA    #$03
6EA5: 3D             MUL
6EA6: 33 49          LEAU   D,U
6EA8: EC EC          LDD    ,U
6EAA: DD 38          STD    speed_msb_b0
6EAC: A6 6A          LDA    $2,U
6EAE: 97 3A          STA    $B2
6EB0: 0F 91          CLR    $B3
6EB2: CE B2 92       LDU    #$30B0
6EB5: 96 69          LDA    $EB
6EB7: 97 60          STA    $48
6EB9: BD D9 A8       JSR    $5120
6EBC: 86 2D          LDA    #$05
6EBE: 90 7C          SUBA   $F4
6EC0: 44             LSRA
6EC1: 97 CB          STA    $49
6EC3: 24 25          BCC    $6ECC
6EC5: 86 87          LDA    #$05
6EC7: 97 60          STA    $48
6EC9: BD D9 87       JSR    $510F
6ECC: 96 61          LDA    $49
6ECE: 97 C0          STA    $48
6ED0: BD 73 A2       JSR    $5120
6ED3: 96 D6          LDA    $F4
6ED5: 1F 0B          TFR    A,B
6ED7: 8B 20          ADDA   #$08
6ED9: CB 8C          ADDB   #$04
6EDB: FD 1B 5D       STD    $3375
6EDE: 86 06          LDA    #$8E
6EE0: BD 6C 2F       JSR    queue_sound_event_4ead
6EE3: 86 DD          LDA    #$FF
6EE5: BD CC 2F       JSR    queue_sound_event_4ead
6EE8: 86 33          LDA    #$1B
6EEA: BD C6 85       JSR    queue_sound_event_4ead
6EED: 86 94          LDA    #$1C
6EEF: BD 6C 8F       JSR    queue_sound_event_4ead
6EF2: 0C AA          INC    event_sub_state_28
6EF4: 39             RTS

6EF5: 7F B4 AF       CLR    $362D
6EF8: 7F 1E A7       CLR    $362F
6EFB: 86 36          LDA    #$1E
6EFD: 97 4C          STA    $C4
6EFF: 86 2B          LDA    #$09
6F01: D6 69          LDB    $EB
6F03: 54             LSRB
6F04: CB 26          ADDB   #$04
6F06: FD B1 5D       STD    $3375
6F09: 86 06          LDA    #$8E
6F0B: BD 66 9B       JSR    force_queue_sound_event_4eb3
6F0E: 86 77          LDA    #$FF
6F10: BD 6C 31       JSR    force_queue_sound_event_4eb3
6F13: 86 25          LDA    #$07
6F15: 97 AA          STA    event_sub_state_28
6F17: 39             RTS

6F18: 96 27          LDA    $0F
6F1A: 44             LSRA
6F1B: 25 27          BCS    $6F2C
6F1D: BD 48 AF       JSR    $C027
6F20: EB 23          ADDB   $1,X
6F22: C1 D4          CMPB   #$56
6F24: 10 25 82 25    LBCS   $6FCF
6F28: E7 29          STB    $1,X
6F2A: 20 89          BRA    $6F2D
6F2C: 4F             CLRA
6F2D: 0D 4D          TST    $C5
6F2F: 26 34          BNE    $6F47
6F31: AB 80          ADDA   $2,X
6F33: 81 F2          CMPA   #$D0
6F35: 25 8E          BCS    $6F43
6F37: 80 F8          SUBA   #$D0
6F39: 97 4F          STA    $C7
6F3B: 86 F8          LDA    #$D0
6F3D: A7 8A          STA    $2,X
6F3F: 0C E7          INC    $C5
6F41: 20 84          BRA    $6F49
6F43: A7 20          STA    $2,X
6F45: 20 87          BRA    $6F4C
6F47: 97 EF          STA    $C7
6F49: BD D1 86       JSR    $590E
6F4C: 0D 28          TST    game_playing_00
6F4E: 26 84          BNE    $6F5C
6F50: 96 CD          LDA    nb_long_horse_turns_ef
6F52: 81 84          CMPA   #$06
6F54: 26 24          BNE    $6F5C
6F56: 96 64          LDA    $E6
6F58: 81 2A          CMPA   #$02
6F5A: 27 9E          BEQ    $6F72
6F5C: BD 73 48       JSR    $5BC0
6F5F: 5D             TSTB
6F60: 27 32          BEQ    $6F72
6F62: 0C 64          INC    $E6
6F64: 96 C4          LDA    $E6
6F66: 81 84          CMPA   #$06
6F68: 26 2A          BNE    $6F6C
6F6A: 0C 67          INC    nb_long_horse_turns_ef
6F6C: 81 20          CMPA   #$08
6F6E: 26 8A          BNE    $6F72
6F70: 0F C4          CLR    $E6
6F72: BD 07 AF       JSR    $858D
6F75: BD D2 B7       JSR    $5035
6F78: EE 2B          LDU    $3,X
6F7A: C6 8A          LDB    #$02
6F7C: A6 E0 48       LDA    -$40,U	; [video_address]
6F7F: 81 D2          CMPA   #$F0
6F81: 27 92          BEQ    $6F93
6F83: 81 D3          CMPA   #$F1
6F85: 27 8E          BEQ    $6F93
6F87: 81 DA          CMPA   #$F2
6F89: 27 80          BEQ    $6F93
6F8B: 5A             DECB
6F8C: 27 0E          BEQ    $6FB4
6F8E: A6 40 E3       LDA    -$3F,U	; [video_address]
6F91: 20 6E          BRA    $6F7F
6F93: 86 4C          LDA    #$6E
6F95: A7 83          STA    $1,X
6F97: BD 78 0F       JSR    $5027
6F9A: 0C 77          INC    $FF
6F9C: 0F 94          CLR    $BC
6F9E: 86 96          LDA    #$1E
6FA0: 97 E6          STA    $C4
6FA2: CC 8A 26       LDD    #$0804
6FA5: FD B1 F7       STD    $3375
6FA8: 4F             CLRA
6FA9: BD C6 25       JSR    queue_sound_event_4ead
6FAC: 86 0B          LDA    #$23
6FAE: BD C6 8F       JSR    queue_sound_event_4ead
6FB1: 0C AA          INC    event_sub_state_28
6FB3: 39             RTS

6FB4: CE 06 E2       LDU    #$2460
6FB7: 96 C7          LDA    nb_long_horse_turns_ef
6FB9: 2A 89          BPL    $6FBC
6FBB: 4F             CLRA
6FBC: BD 79 B2       JSR    $513A
6FBF: DD 6A          STD    $48
6FC1: 96 CB          LDA    $49
6FC3: 26 20          BNE    $6FC7
6FC5: 86 92          LDA    #$10
6FC7: BD 6A 04       JSR    write_char_and_move_cursor_422c
6FCA: 96 C0          LDA    $48
6FCC: 7E 6A A4       JMP    write_char_and_move_cursor_422c
6FCF: 4F             CLRA
6FD0: BD 6C 2F       JSR    queue_sound_event_4ead
6FD3: 0D C5          TST    $E7
6FD5: 27 86          BEQ    $6FDB
6FD7: 86 2B          LDA    #$03
6FD9: 97 6E          STA    $E6
6FDB: 96 CE          LDA    $E6
6FDD: 97 76          STA    $FE
6FDF: CE F7 C2       LDU    #$D5E0
6FE2: A6 44          LDA    A,U
6FE4: 97 D7          STA    $F5
6FE6: 96 64          LDA    $E6
6FE8: 27 22          BEQ    $6FF4
6FEA: C6 80          LDB    #$08
6FEC: 81 2D          CMPA   #$05
6FEE: 25 8E          BCS    $6FF6
6FF0: 81 24          CMPA   #$06
6FF2: 27 87          BEQ    $6FF9
6FF4: C6 28          LDB    #$0A
6FF6: D7 AA          STB    event_sub_state_28
6FF8: 39             RTS

6FF9: 96 67          LDA    nb_long_horse_turns_ef
6FFB: 81 29          CMPA   #$01
6FFD: 26 8B          BNE    $7002
6FFF: 7C 16 C5       INC    $34E7
7002: C6 8B          LDB    #$09
7004: 20 D2          BRA    $6FF6
7006: CE 57 C0       LDU   #table_d5e8
7009: 96 A2          LDA    event_sub_state_2a
700B: 48             ASLA
700C: 6E FE          JMP    [A,U]        ; [jump_table]

700E: BD 48 05       JSR    $C027
7011: AB 80          ADDA   $2,X
7013: A7 20          STA    $2,X
7015: EB 83          ADDB   $1,X
7017: 0D D7          TST    $FF
7019: 27 8E          BEQ    $7021
701B: C1 62          CMPB   #$4A
701D: 25 83          BCS    $702A
701F: 20 26          BRA    $7025
7021: C1 D4          CMPB   #$56
7023: 25 27          BCS    $702A
7025: E7 83          STB    $1,X
7027: 7E AD EB       JMP    $85C3

702A: 86 D4          LDA    #$5C
702C: 0D D7          TST    $FF
702E: 20 8A          BRA    $7032
7030: 86 72          LDA    #$50
7032: A7 83          STA    $1,X
7034: BD A7 4B       JSR    $85C9
7037: 86 1F          LDA    #$37
7039: BD C6 3B       JSR    force_queue_sound_event_4eb3
703C: 0F 94          CLR    $BC
703E: 0C A2          INC    event_sub_state_2a
7040: 39             RTS

7041: 96 8D          LDA    $0F
7043: 44             LSRA
7044: 25 00          BCS    $7068
7046: CE 57 DA       LDU    #$D5F2
7049: D6 34          LDB    $BC
704B: C1 3B          CMPB   #$13
704D: 27 92          BEQ    $7069
704F: 86 7E          LDA    #$5C
7051: 0D 7D          TST    $FF
7053: 27 20          BEQ    $7057
7055: 86 D2          LDA    #$50
7057: AB ED          ADDA   B,U
7059: A7 89          STA    $1,X
705B: 96 27          LDA    $0F
705D: 44             LSRA
705E: 44             LSRA
705F: 25 20          BCS    $7063
7061: 6C 80          INC    $2,X
7063: BD A7 EB       JSR    $85C9
7066: 0C 3E          INC    $BC
7068: 39             RTS

7069: 86 96          LDA    #$1E
706B: 97 01          STA    $29
706D: 86 85          LDA    #$0D
706F: 97 0A          STA    event_sub_state_28
7071: 0F A8          CLR    event_sub_state_2a
7073: 39             RTS

7074: BD A2 F5       JSR    $8077
7077: 8E 18 88       LDX    #$30A0
707A: CE 5D C4       LDU   #table_d5ec
707D: 96 A2          LDA    event_sub_state_2a
707F: 48             ASLA
7080: 6E F4          JMP    [A,U]        ; [jump_table]
7082: 86 DE          LDA    #$5C
7084: A7 23          STA    $1,X
7086: 86 A0          LDA    #$22
7088: BD 66 25       JSR    queue_sound_event_4ead
708B: 96 DD          LDA    $F5
708D: 26 8B          BNE    $7092
708F: 4C             INCA
7090: 20 27          BRA    $7097
7092: BD 07 FB       JSR    $85D9
7095: 86 9C          LDA    #$1E
7097: 97 03          STA    $2B
7099: 0C A2          INC    event_sub_state_2a
709B: 39             RTS

709C: 0A 03          DEC    $2B
709E: 26 98          BNE    $70B0
70A0: BD A7 4D       JSR    $85CF
70A3: 86 3C          LDA    #$1E
70A5: 7D B6 65       TST    $34E7
70A8: 27 2A          BEQ    $70AC
70AA: 86 08          LDA    #$80
70AC: 97 03          STA    $2B
70AE: 0C A2          INC    event_sub_state_2a
70B0: 39             RTS

70B1: 0A A9          DEC    $2B
70B3: 26 26          BNE    $70B9
70B5: 86 89          LDA    #$0B
70B7: 97 00          STA    event_sub_state_28
70B9: 39             RTS

70BA: 8E B8 88       LDX    #$30A0
70BD: CE 5D 7A       LDU    #$D5F2
70C0: 96 CA          LDA    $E8
70C2: A6 44          LDA    A,U
70C4: 8B 75          ADDA   #$57
70C6: A7 83          STA    $1,X
70C8: 0C C0          INC    $E8
70CA: 96 60          LDA    $E8
70CC: 81 3A          CMPA   #$12
70CE: 26 8A          BNE    $70D2
70D0: 0F CA          CLR    $E8
70D2: 96 47          LDA    $C5
70D4: 26 2E          BNE    $70E2
70D6: 6C 80          INC    $2,X
70D8: A6 2A          LDA    $2,X
70DA: 81 58          CMPA   #$D0
70DC: 26 2A          BNE    $70E0
70DE: 0C 4D          INC    $C5
70E0: 20 33          BRA    $70F3
70E2: 86 83          LDA    #$01
70E4: 97 E5          STA    $C7
70E6: 0C 6B          INC    $E9
70E8: 96 C1          LDA    $E9
70EA: 81 B8          CMPA   #$30
70EC: 26 2A          BNE    $70F0
70EE: 0C 62          INC    $EA
70F0: BD 7B 8C       JSR    $590E
70F3: BD A7 AF       JSR    $858D
70F6: 96 6A          LDA    $E8
70F8: 81 29          CMPA   #$01
70FA: 26 86          BNE    $710A
70FC: 86 0B          LDA    #$23
70FE: BD C6 91       JSR    force_queue_sound_event_4eb3
7101: 96 68          LDA    $EA
7103: 27 27          BEQ    $710A
7105: BD 02 E1       JSR    $8063
7108: 0A 00          DEC    event_sub_state_28
710A: 39             RTS

710B: CE FE 2D       LDU   #table_d605
710E: 96 A2          LDA    event_sub_state_2a
7110: 48             ASLA
7111: 6E 54          JMP    [A,U]        ; [jump_table]
7113: 86 74          LDA    #$56
7115: A7 83          STA    $1,X
7117: 86 4C          LDA    #$64
7119: BD C6 3B       JSR    force_queue_sound_event_4eb3
711C: 0C 02          INC    event_sub_state_2a
711E: 39             RTS

711F: 96 E7          LDA    $C5
7121: 26 8E          BNE    $712F
7123: 6C 20          INC    $2,X
7125: A6 80          LDA    $2,X
7127: 81 F8          CMPA   #$D0
7129: 26 8A          BNE    $712D
712B: 0C ED          INC    $C5
712D: 20 99          BRA    $7140
712F: 86 23          LDA    #$01
7131: 97 45          STA    $C7
7133: 0C CB          INC    $E9
7135: 96 6B          LDA    $E9
7137: 81 18          CMPA   #$30
7139: 26 8A          BNE    $713D
713B: 0C C2          INC    $EA
713D: BD D1 86       JSR    $590E
7140: 96 2D          LDA    $0F
7142: 44             LSRA
7143: 25 28          BCS    $714F
7145: 0C 64          INC    $E6
7147: 96 CE          LDA    $E6
7149: 81 80          CMPA   #$08
714B: 26 2A          BNE    $714F
714D: 0F 6E          CLR    $E6
714F: BD A7 AF       JSR    $858D
7152: 96 68          LDA    $EA
7154: 27 33          BEQ    $7167
7156: 96 64          LDA    $E6
7158: 81 2A          CMPA   #$02
715A: 26 83          BNE    $7167
715C: 86 4C          LDA    #$64
715E: BD C6 91       JSR    force_queue_sound_event_4eb3
7161: 86 8A          LDA    #$08
7163: 97 0A          STA    event_sub_state_28
7165: 0F A8          CLR    event_sub_state_2a
7167: 39             RTS

7168: BD 53 86       JSR    $7B0E
716B: 8E 18 B3       LDX    #$309B
716E: CE AC 87       LDU    #$24A5
7171: BD C1 5A       JSR    $43D8
7174: BD 76 E4       JSR    $5466
7177: BD 56 57       JSR    $7E7F
717A: 0C AE          INC    $26
717C: 0F 00          CLR    event_sub_state_28
717E: 0F A2          CLR    event_sub_state_2a
7180: 39             RTS

7181: CE 54 8B       LDU   #table_d609
7184: 96 08          LDA    event_sub_state_2a
7186: 48             ASLA
7187: 6E FE          JMP    [A,U]        ; [jump_table]
7189: 0A A1          DEC    $29
718B: 26 2A          BNE    $718F
718D: 0C A2          INC    event_sub_state_2a
718F: 39             RTS

7190: 86 3C          LDA    #$1E
7192: 97 AB          STA    $29
7194: 0C 0A          INC    event_sub_state_28
7196: 0F A8          CLR    event_sub_state_2a
7198: 39             RTS

7199: CE 5E 9B       LDU   #table_d613
719C: 96 02          LDA    event_sub_state_2a
719E: 48             ASLA
719F: 6E F4          JMP    [A,U]        ; [jump_table]
71A1: 0A AB          DEC    $29
71A3: 26 20          BNE    $71A7
71A5: 0C A8          INC    event_sub_state_2a
71A7: 39             RTS

71A8: CE 0C 2E       LDU    #$24A6
71AB: BD 4D 37       JSR    $651F
71AE: BD DC 44       JSR    $5466
71B1: 8E B7 8A       LDX    #$3508
71B4: 96 3B          LDA    $19
71B6: C6 A2          LDB    #$20
71B8: 3D             MUL
71B9: 30 03          LEAX   D,X
71BB: 6F AC          CLR    ,X
71BD: 6F 89          CLR    $1,X
71BF: 0F 0A          CLR    event_sub_state_28
71C1: 0F A8          CLR    event_sub_state_2a
71C3: 0C 04          INC    $26
71C5: 39             RTS

71C6: BD 42 0F       JSR    $C027
71C9: 97 4F          STA    $C7
71CB: EB 29          ADDB   $1,X
71CD: E7 89          STB    $1,X
71CF: A6 A6          LDA    ,X
71D1: 81 86          CMPA   #$04
71D3: 26 20          BNE    $71D7
71D5: CB 8B          ADDB   #$09
71D7: E1 A0 35       CMPB   $1D,X
71DA: 10 25 28 B9    LBCS   $726F
71DE: BD FA 96       JSR    $72B4
71E1: A6 A1          LDA    $3,Y
71E3: 27 07          BEQ    $720A
71E5: A6 26          LDA    ,Y
71E7: 26 34          BNE    $7205
71E9: BD C7 02       JSR    $4F8A
71EC: A6 EC          LDA    ,U
71EE: 84 8A          ANDA   #$02
71F0: 27 28          BEQ    $71FC
71F2: 96 46          LDA    $C4
71F4: 4C             INCA
71F5: 97 46          STA    $C4
71F7: 4C             INCA
71F8: 81 79          CMPA   #$51
71FA: 26 8F          BNE    $7203
71FC: 6C 8C          INC    ,Y
71FE: BD FB CC       JSR    $73EE
7201: 20 80          BRA    $7205
7203: 97 E6          STA    $C4
7205: 86 86          LDA    #$04
7207: BD 66 B2       JSR    queue_event_4e9a
720A: BD C7 89       JSR    $4FA1
720D: 84 8D          ANDA   #$05
720F: 27 2F          BEQ    $721E
7211: CE B2 32       LDU    #$30B0
7214: 86 23          LDA    #$01
7216: 97 CA          STA    $48
7218: BD 78 17       JSR    $509F
721B: BD 5C 0F       JSR    $7427
721E: 96 4D          LDA    $C5
7220: 26 3C          BNE    $7240
7222: A6 80          LDA    $2,X
7224: 9B E5          ADDA   $C7
7226: CE 54 3F       LDU    #$D617
7229: E6 0C          LDB    ,X
722B: A1 ED          CMPA   B,U
722D: 24 8F          BCC    $7236
722F: A7 20          STA    $2,X
7231: BD 00 F6       JSR    $8274
7234: 20 15          BRA    $726D
7236: A0 47          SUBA   B,U
7238: 97 EF          STA    $C7
723A: A6 4D          LDA    B,U
723C: A7 2A          STA    $2,X
723E: 0C 4D          INC    $C5
7240: A6 A6          LDA    ,X
7242: 81 86          CMPA   #$04
7244: 26 30          BNE    $7258
7246: 86 83          LDA    #$01
7248: 97 E2          STA    $CA
724A: BD D8 1D       JSR    $5035
724D: A6 10 96       LDA    [$1E,X]
7250: 81 0F          CMPA   #$2D
7252: 26 86          BNE    $7258
7254: 0F E7          CLR    $C5
7256: 20 48          BRA    $7222
7258: BD 71 86       JSR    $590E
725B: BD AA 5C       JSR    $8274
725E: 34 98          PSHS   X
7260: 8E 10 C2       LDX    #$3240
7263: 0F E8          CLR    $CA
7265: BD D2 B7       JSR    $5035
7268: BD 73 2D       JSR    $5BA5
726B: 35 38          PULS   X
726D: 20 D8          BRA    $72BF
726F: BD 72 05       JSR    $5027
7272: 96 3F          LDA    $BD
7274: A7 23          STA    $1,X
7276: A6 06          LDA    ,X
7278: 81 2C          CMPA   #$04
727A: 27 8B          BEQ    $727F
727C: BD 5B 9C       JSR    $7314
727F: 0F 9E          CLR    $BC
7281: CE B2 5E       LDU    #$30DC
7284: 96 82          LDA    $A0
7286: 81 80          CMPA   #$02
7288: 27 2B          BEQ    $728D
728A: CE B8 D8       LDU    #$30F0
728D: EC 4C          LDD    ,U
728F: DD 92          STD    speed_msb_b0
7291: EC C0          LDD    $2,U
7293: DD 90          STD    $B2
7295: CE B2 32       LDU    #$30B0
7298: 86 2D          LDA    #$05
729A: 97 C0          STA    $48
729C: D6 88          LDB    $A0
729E: C1 8B          CMPB   #$03
72A0: 27 27          BEQ    $72A7
72A2: BD D3 2D       JSR    $510F
72A5: 20 88          BRA    $72B1
72A7: 86 2D          LDA    #$05
72A9: 97 C0          STA    $48
72AB: BD 78 F9       JSR    $50D1
72AE: BD FB FD       JSR    $73DF
72B1: 0C A8          INC    event_sub_state_2a
72B3: 39             RTS

72B4: 10 8E B2 7A    LDY    #$30F8
72B8: A6 AC          LDA    ,X
72BA: 80 8A          SUBA   #$02
72BC: 31 8E          LEAY   A,Y
72BE: 39             RTS

72BF: 8D D1          BSR    $72B4
72C1: A6 A1          LDA    $3,Y
72C3: 26 60          BNE    $7307
72C5: 96 3E          LDA    $BC
72C7: 81 2E          CMPA   #$06
72C9: 24 B5          BCC    $7308
72CB: BD 67 89       JSR    $4FA1
72CE: 84 8A          ANDA   #$02
72D0: 27 17          BEQ    $7307
72D2: 6C A1          INC    $3,Y
72D4: CE 12 32       LDU    #$30B0
72D7: 86 2D          LDA    #$05
72D9: 97 C0          STA    $48
72DB: BD 79 27       JSR    $510F
72DE: 86 89          LDA    #$01
72E0: 97 6A          STA    $48
72E2: BD D3 02       JSR    $5120
72E5: 4F             CLRA
72E6: BD CC 85       JSR    queue_sound_event_4ead
72E9: 86 86          LDA    #$0E
72EB: BD 66 85       JSR    queue_sound_event_4ead
72EE: 96 28          LDA    $A0
72F0: 81 26          CMPA   #$04
72F2: 27 8B          BEQ    $72FD
72F4: 86 38          LDA    #$1A
72F6: BD CC 85       JSR    queue_sound_event_4ead
72F9: 86 94          LDA    #$1C
72FB: 20 2F          BRA    $7304
72FD: 86 93          LDA    #$1B
72FF: BD 6C 8F       JSR    queue_sound_event_4ead
7302: 86 9E          LDA    #$1C
7304: BD 6C 2F       JSR    queue_sound_event_4ead
7307: 39             RTS

7308: BD 73 F7       JSR    $5B7F
730B: 86 21          LDA    #$09
730D: 97 A0          STA    event_sub_state_28
730F: 86 20          LDA    #$02
7311: 97 A8          STA    event_sub_state_2a
7313: 39             RTS

7314: 86 2B          LDA    #$09
7316: 97 46          STA    $C4
7318: CE FE 94       LDU    #$D61C
731B: 96 88          LDA    $A0
731D: 4A             DECA
731E: 4A             DECA
731F: A6 E4          LDA    A,U
7321: 97 CA          STA    $48
7323: DC 96          LDD    $B4
7325: DB CA          ADDB   $48
7327: C5 68          BITB   #$40
7329: 27 8B          BEQ    $732E
732B: 83 28 68       SUBD   #$0040
732E: DD 6B          STD    $E3
7330: 96 82          LDA    $A0
7332: 81 81          CMPA   #$03
7334: 27 3B          BEQ    $734F
7336: DC 61          LDD    $E3
7338: C1 B7          CMPB   #$9F
733A: 25 87          BCS    $734B
733C: C1 86          CMPB   #$AE
733E: 25 8A          BCS    $7342
7340: C6 8F          LDB    #$AD
7342: DD 61          STD    $E3
7344: DD FA          STD    $D8
7346: CB 86          ADDB   #$04
7348: DD C9          STD    $E1
734A: 39             RTS

734B: C6 B7          LDB    #$9F
734D: 20 7B          BRA    $7342
734F: DC C1          LDD    $E3
7351: 10 83 A7 90    CMPD   #$25B2
7355: 24 89          BCC    $7362
7357: D1 CA          CMPB   $E2
7359: 24 8A          BCC    $735D
735B: DC C9          LDD    $E1
735D: DD 6B          STD    $E3
735F: DD F8          STD    $DA
7361: 39             RTS

7362: CC A7 93       LDD    #$25B1
7365: 20 74          BRA    $735D
7367: 34 38          PSHS   X
7369: CE 5E 96       LDU    #$D61E
736C: 96 88          LDA    $A0
736E: 4A             DECA
736F: 97 6B          STA    $49
7371: E6 44          LDB    A,U
7373: D7 6A          STB    $48
7375: 8E B0 E2       LDX    #$3260
7378: C6 08          LDB    #$20
737A: 3D             MUL
737B: 30 A3          LEAX   D,X
737D: 6C 0C          INC    ,X
737F: 96 6B          LDA    $49
7381: 8B A2          ADDA   #$20
7383: A7 2F          STA    $D,X
7385: 86 D9          LDA    #$5B
7387: D6 8A          LDB    $A2
7389: DB C0          ADDB   $48
738B: ED 29          STD    $1,X
738D: BD 0B 21       JSR    $83A9
7390: 35 32          PULS   X
7392: 39             RTS

7393: 96 C7          LDA    $E5
7395: 26 8C          BNE    $73A5
7397: BD 79 6D       JSR    $5145
739A: A6 4C          LDA    ,U		; [video_address]
739C: 81 1A          CMPA   #$32
739E: 27 89          BEQ    $73A1
73A0: 39             RTS

73A1: DF 64          STU    $E6
73A3: 0C C7          INC    $E5
73A5: EE 81          LDU    $3,X
73A7: 11 93 CE       CMPU   $E6
73AA: 27 98          BEQ    $73BC
73AC: BD 79 CD       JSR    $5145
73AF: 11 93 C4       CMPU   $E6
73B2: 27 92          BEQ    $73C4
73B4: 86 23          LDA    #$01
73B6: 97 49          STA    $CB
73B8: 7F 1C 6F       CLR    $34E7
73BB: 39             RTS

73BC: A6 2A          LDA    $2,X
73BE: 90 33          SUBA   $BB
73C0: 8B 25          ADDA   #$07
73C2: 20 8A          BRA    $73CC
73C4: A6 20          LDA    $2,X
73C6: 90 39          SUBA   $BB
73C8: 8B 20          ADDA   #$08
73CA: 8B 8F          ADDA   #$07
73CC: E6 2A          LDB    $2,X
73CE: CB 8F          ADDB   #$07
73D0: D7 72          STB    $50
73D2: 90 D2          SUBA   $50
73D4: 25 FC          BCS    $73B4
73D6: 81 87          CMPA   #$05
73D8: 25 2A          BCS    $73DC
73DA: 86 8D          LDA    #$05
73DC: 97 C0          STA    $E8
73DE: 39             RTS

73DF: CE F4 03       LDU    #$D621
73E2: 96 6A          LDA    $E8
73E4: A6 E4          LDA    A,U
73E6: 97 CA          STA    $48
73E8: CE 18 38       LDU    #$30B0
73EB: 7E 78 F9       JMP    $50D1
73EE: CE 5E 05       LDU    #$D627
73F1: D6 22          LDB    $A0
73F3: C0 20          SUBB   #$02
73F5: 96 46          LDA    $C4
73F7: A1 ED          CMPA   B,U
73F9: 27 8B          BEQ    $73FE
73FB: 7F 1C CF       CLR    $34E7
73FE: A0 4D          SUBA   B,U
7400: 24 23          BCC    $7403
7402: 40             NEGA
7403: 81 2D          CMPA   #$0F
7405: 25 80          BCS    $7409
7407: 86 27          LDA    #$0F
7409: 97 61          STA    $E9
740B: CE 18 98       LDU    #$30B0
740E: 48             ASLA
740F: 27 2D          BEQ    $7420
7411: BD D3 B8       JSR    $513A
7414: DD 6A          STD    $48
7416: BD D3 27       JSR    $510F
7419: 96 C1          LDA    $49
741B: 97 60          STA    $48
741D: 7E D9 A8       JMP    $5120
7420: 86 21          LDA    #$03
7422: 97 CA          STA    $48
7424: 7E 72 53       JMP    $50D1
7427: CE FE 02       LDU   #table_d62a
742A: 96 28          LDA    $A0
742C: 80 2A          SUBA   #$02
742E: 48             ASLA
742F: 6E F4          JMP    [A,U]        ; [jump_table]
7431: DC 32          LDD    speed_msb_b0
7433: 10 83 23 87    CMPD   #$0105
7437: 25 21          BCS    $7442
7439: CC 89 8D       LDD    #$0105
743C: DD 98          STD    speed_msb_b0
743E: 0F 3A          CLR    $B2
7440: 0F 91          CLR    $B3
7442: 39             RTS

7443: DC 92          LDD    speed_msb_b0
7445: 10 83 83 2B    CMPD   #$0103
7449: 25 81          BCS    $7454
744B: CC 29 2B       LDD    #$0103
744E: DD 38          STD    speed_msb_b0
7450: 0F 90          CLR    $B2
7452: 0F 31          CLR    $B3
7454: 39             RTS

7455: BD CD 23       JSR    $4FA1
7458: 84 2D          ANDA   #$05
745A: 27 92          BEQ    $7476
745C: A6 AC          LDA    ,X
745E: 81 8B          CMPA   #$03
7460: 24 21          BCC    $7465
7462: 6F 0A 79       CLR    $5B,X
7465: 33 0A 92       LEAU   $10,X
7468: 86 2D          LDA    #$05
746A: 97 C0          STA    $48
746C: BD 78 55       JSR    $50DD
746F: 86 23          LDA    #$01
7471: 97 CA          STA    $48
7473: BD 73 2D       JSR    $510F
7476: 39             RTS

7477: 96 C8          LDA    $E0
7479: 97 69          STA    $E1
747B: 0F C8          CLR    $E0
747D: 10 8E B8 C2    LDY    #$30E0
7481: 96 5A          LDA    $D8
7483: 27 2A          BEQ    $748D
7485: 4A             DECA
7486: A7 26          STA    ,Y
7488: BD 5F C6       JSR    $774E
748B: 20 2B          BRA    $7490
748D: BD FF A2       JSR    $772A
7490: 8E 12 62       LDX    #$30E0
7493: A6 38          LDA    -$6,X
7495: 26 90          BNE    $74A9
7497: EC 2A          LDD    $2,X
7499: ED 8C          STD    $4,X
749B: EC EC          LDD    ,U
749D: 0D 50          TST    $D8
749F: 27 21          BEQ    $74A4
74A1: CC 81 7A       LDD    #$03F8
74A4: A3 AA 4C       SUBD   -$32,X
74A7: ED 2A          STD    $2,X
74A9: 30 00 E8       LEAX   $60,X
74AC: 8C 1A E8       CMPX   #$3260
74AF: 26 C0          BNE    $7493
74B1: 8E B2 22       LDX    #$30A0
74B4: 96 C2          LDA    $E0
74B6: 97 9B          STA    $19
74B8: C6 48          LDB    #$60
74BA: 3D             MUL
74BB: 30 A3          LEAX   D,X
74BD: 96 50          LDA    $D8
74BF: 27 32          BEQ    $74D1
74C1: 9F 7C          STX    $FE
74C3: A6 A6          LDA    ,X
74C5: 97 6A          STA    $E8
74C7: 96 F5          LDA    $DD
74C9: 26 8A          BNE    $74CD
74CB: 0F CE          CLR    $E6
74CD: 0F 55          CLR    $DD
74CF: 20 1D          BRA    $7510
74D1: 96 62          LDA    $E0
74D3: 91 C3          CMPA   $E1
74D5: 27 AA          BEQ    $74FF
74D7: 86 A8          LDA    #$80
74D9: A0 8A          SUBA   $2,X
74DB: 27 0A          BEQ    $74FF
74DD: E6 0C          LDB    ,X
74DF: C1 20          CMPB   #$02
74E1: 25 9E          BCS    $74FF
74E3: 97 73          STA    $51
74E5: 86 02          LDA    #$80
74E7: A7 2A          STA    $2,X
74E9: A6 00 A8       LDA    $20,X
74EC: 97 7A          STA    $52
74EE: 90 D9          SUBA   $51
74F0: 27 24          BEQ    $74F8
74F2: A7 0A 02       STA    $20,X
74F5: BD FA B0       JSR    $7832
74F8: 96 7A          LDA    $52
74FA: 90 D9          SUBA   $51
74FC: A7 A0 A8       STA    $20,X
74FF: 9F DC          STX    $FE
7501: A6 06          LDA    ,X
7503: 97 CA          STA    $E8
7505: A6 0A A2       LDA    $20,X
7508: 97 CE          STA    $E6
750A: BD FF B2       JSR    $779A
750D: BD F0 BA       JSR    $7832
7510: 86 26          LDA    #$04
7512: 97 E4          STA    $66
7514: 8E 12 22       LDX    #$30A0
7517: 0F 31          CLR    $19
7519: 9C 76          CMPX   $FE
751B: 27 77          BEQ    $757C
751D: A6 00 B2       LDA    $3A,X
7520: 26 78          BNE    $757C
7522: EC 0A 60       LDD    $42,X
7525: 10 83 82 58    CMPD   #$0070
7529: 22 F8          BHI    $759B
752B: A6 A0 6F       LDA    $47,X
752E: 27 AF          BEQ    $7557
7530: 6F AA C5       CLR    $47,X
7533: 86 52          LDA    #$70
7535: A0 0A C1       SUBA   $43,X
7538: 97 79          STA    $51
753A: A6 00 08       LDA    $20,X
753D: 97 DA          STA    $52
753F: 90 73          SUBA   $51
7541: A7 0A A2       STA    $20,X
7544: A6 20          LDA    $2,X
7546: 9B D3          ADDA   $51
7548: A7 2A          STA    $2,X
754A: BD FF B2       JSR    $779A
754D: 96 DA          LDA    $52
754F: A7 AA 02       STA    $20,X
7552: BD FA 10       JSR    $7832
7555: 20 A7          BRA    $757C
7557: 0F 65          CLR    $4D
7559: EC 00 CA       LDD    $42,X
755C: A3 A0 CC       SUBD   $44,X
755F: 24 2A          BCC    $7569
7561: 0C CF          INC    $4D
7563: EC AA 66       LDD    $44,X
7566: A3 0A 6A       SUBD   $42,X
7569: D7 C6          STB    $4E
756B: 0D 65          TST    $4D
756D: 27 A9          BEQ    $7590
756F: A6 20          LDA    $2,X
7571: AB 0A A2       ADDA   $20,X
7574: A7 20          STA    $2,X
7576: BD FA 1A       JSR    $7832
7579: BD FF 09       JSR    $7781
757C: A6 A0 C3       LDA    $4B,X
757F: 27 27          BEQ    $7586
7581: 6C 06          INC    ,X
7583: 6F AA 69       CLR    $4B,X
7586: 30 0A 48       LEAX   $60,X
7589: 0C 91          INC    $19
758B: 0A 4E          DEC    $66
758D: 26 02          BNE    $7519
758F: 39             RTS

7590: BD 55 18       JSR    $779A
7593: BD 55 A7       JSR    $7785
7596: BD FA 1A       JSR    $7832
7599: 20 69          BRA    $757C
759B: 6D A0 6F       TST    $47,X
759E: 26 9C          BNE    $75B4
75A0: 6C AA C5       INC    $47,X
75A3: A6 20          LDA    $2,X
75A5: 80 92          SUBA   #$10
75A7: 97 66          STA    $4E
75A9: BD FF 12       JSR    $779A
75AC: BD 5F 0D       JSR    $7785
75AF: BD 5A 10       JSR    $7832
75B2: 20 4A          BRA    $757C
75B4: BD 55 18       JSR    $779A
75B7: BD 50 1A       JSR    $7832
75BA: 20 48          BRA    $757C
75BC: 96 C4          LDA    $EC
75BE: 97 65          STA    $ED
75C0: 0F CE          CLR    $EC
75C2: 10 8E 12 CE    LDY    #$30EC
75C6: 96 5B          LDA    $D9
75C8: 27 20          BEQ    $75D2
75CA: 4A             DECA
75CB: A7 8C          STA    ,Y
75CD: BD FF C6       JSR    $774E
75D0: 20 21          BRA    $75D5
75D2: BD F5 08       JSR    $772A
75D5: 8E B2 6E       LDX    #$30EC
75D8: EC 2A          LDD    $2,X
75DA: ED 8C          STD    $4,X
75DC: EC EC          LDD    ,U
75DE: 0D 51          TST    $D9
75E0: 27 21          BEQ    $75E5
75E2: CC 8A 0A       LDD    #$0828
75E5: A3 0A 40       SUBD   -$3E,X
75E8: ED 2A          STD    $2,X
75EA: 30 00 48       LEAX   $60,X
75ED: 8C BA E4       CMPX   #$326C
75F0: 26 C4          BNE    $75D8
75F2: 96 5E          LDA    $DC
75F4: 10 27 83 8E    LBEQ   $7704
75F8: 96 F6          LDA    $DE
75FA: 10 26 29 2E    LBNE   $7704
75FE: 8E B8 82       LDX    #$30A0
7601: 96 6E          LDA    $EC
7603: 97 3B          STA    $19
7605: C6 E2          LDB    #$60
7607: 3D             MUL
7608: 30 A3          LEAX   D,X
760A: A6 00 12       LDA    $3A,X
760D: 81 8A          CMPA   #$02
760F: 27 32          BEQ    $7621
7611: 9F 7E          STX    $FC
7613: A6 A6          LDA    ,X
7615: 97 76          STA    $F4
7617: 96 F7          LDA    $DF
7619: 26 8A          BNE    $761D
761B: 0F DA          CLR    $F2
761D: 0F 57          CLR    $DF
761F: 20 17          BRA    $7656
7621: 96 6E          LDA    $EC
7623: 91 CF          CMPA   $ED
7625: 27 9C          BEQ    $7645
7627: A6 2A          LDA    $2,X
7629: 80 08          SUBA   #$80
762B: 27 30          BEQ    $7645
762D: 97 D9          STA    $51
762F: C6 A2          LDB    #$80
7631: E7 80          STB    $2,X
7633: E6 AA 02       LDB    $20,X
7636: D7 D0          STB    $52
7638: A7 A0 A8       STA    $20,X
763B: BD 50 16       JSR    $783E
763E: 96 DA          LDA    $52
7640: 90 73          SUBA   $51
7642: A7 0A 02       STA    $20,X
7645: 9F 7E          STX    $FC
7647: A6 AC          LDA    ,X
7649: 97 7C          STA    $F4
764B: A6 A0 08       LDA    $20,X
764E: 97 7A          STA    $F2
7650: BD 5A 81       JSR    $7803
7653: BD 5A 1C       JSR    $783E
7656: 86 86          LDA    #$04
7658: 97 4E          STA    $66
765A: 8E B8 88       LDX    #$30A0
765D: 0F 91          CLR    $19
765F: 9C DE          CMPX   $FC
7661: 27 E3          BEQ    $76C4
7663: A6 AA 18       LDA    $3A,X
7666: 81 80          CMPA   #$02
7668: 26 72          BNE    $76C4
766A: EC 00 66       LDD    $4E,X
766D: 10 83 88 72    CMPD   #$0050
7671: 22 F2          BHI    $76E3
7673: A6 AA 71       LDA    $53,X
7676: 27 A5          BEQ    $769F
7678: 6F A0 DB       CLR    $53,X
767B: 86 78          LDA    #$50
767D: A0 00 C7       SUBA   $4F,X
7680: 97 73          STA    $51
7682: A6 0A 02       LDA    $20,X
7685: 97 D0          STA    $52
7687: 90 79          SUBA   $51
7689: A7 00 A8       STA    $20,X
768C: A6 2A          LDA    $2,X
768E: 90 D9          SUBA   $51
7690: A7 20          STA    $2,X
7692: BD FA 21       JSR    $7803
7695: 96 D0          LDA    $52
7697: A7 A0 08       STA    $20,X
769A: BD F0 1A       JSR    $7832
769D: 20 AD          BRA    $76C4
769F: 0F 6F          CLR    $4D
76A1: EC 0A CC       LDD    $4E,X
76A4: A3 AA D2       SUBD   $50,X
76A7: 24 20          BCC    $76B1
76A9: 0C C5          INC    $4D
76AB: EC A0 78       LDD    $50,X
76AE: A3 00 6C       SUBD   $4E,X
76B1: D7 CC          STB    $4E
76B3: 0D 6F          TST    $4D
76B5: 27 A3          BEQ    $76D8
76B7: A6 2A          LDA    $2,X
76B9: A0 00 A8       SUBA   $20,X
76BC: A7 2A          STA    $2,X
76BE: BD F0 10       JSR    $7832
76C1: BD F5 72       JSR    $77F0
76C4: A6 AA C9       LDA    $4B,X
76C7: 27 2D          BEQ    $76CE
76C9: 6C 0C          INC    ,X
76CB: 6F A0 63       CLR    $4B,X
76CE: 30 00 42       LEAX   $60,X
76D1: 0C 9B          INC    $19
76D3: 0A 44          DEC    $66
76D5: 26 0A          BNE    $765F
76D7: 39             RTS

76D8: BD 50 8B       JSR    $7803
76DB: BD 5F DC       JSR    $77F4
76DE: BD F0 10       JSR    $7832
76E1: 20 63          BRA    $76C4
76E3: 6D AA 65       TST    $47,X
76E6: 26 96          BNE    $76FC
76E8: 6C A0 DB       INC    $53,X
76EB: 86 F8          LDA    #$D0
76ED: A0 8A          SUBA   $2,X
76EF: 97 6C          STA    $4E
76F1: BD FA 81       JSR    $7803
76F4: BD 55 76       JSR    $77F4
76F7: BD 50 1A       JSR    $7832
76FA: 20 40          BRA    $76C4
76FC: BD 50 8B       JSR    $7803
76FF: BD 5A 10       JSR    $7832
7702: 20 42          BRA    $76C4
7704: 0F FC          CLR    $DE
7706: 86 86          LDA    #$04
7708: 97 4D          STA    $65
770A: 8E B8 88       LDX    #$30A0
770D: 0F 91          CLR    $19
770F: A6 AA 18       LDA    $3A,X
7712: 81 80          CMPA   #$02
7714: 26 28          BNE    $7720
7716: A6 80          LDA    $2,X
7718: A0 A0 A8       SUBA   $20,X
771B: A7 2A          STA    $2,X
771D: BD F0 B6       JSR    $783E
7720: 30 AA E2       LEAX   $60,X
7723: 0C 3B          INC    $19
7725: 0A E7          DEC    $65
7727: 26 CE          BNE    $770F
7729: 39             RTS

772A: DC 26          LDD    $AE
772C: 10 B3 B9 86    CMPD   $310E
7730: 24 27          BCC    $7737
7732: 6C 26          INC    ,Y
7734: FC 13 8C       LDD    $310E
7737: 10 B3 19 E6    CMPD   $316E
773B: 24 2F          BCC    $7744
773D: 86 8A          LDA    #$02
773F: A7 86          STA    ,Y
7741: FC B3 EC       LDD    $316E
7744: 10 B3 B3 4C    CMPD   $31CE
7748: 24 2C          BCC    $774E
774A: 86 8B          LDA    #$03
774C: A7 8C          STA    ,Y
774E: CE B8 8C       LDU    #$30AE
7751: A6 26          LDA    ,Y
7753: C6 42          LDB    #$60
7755: 3D             MUL
7756: 33 49          LEAU   D,U
7758: 39             RTS

7759: A6 00 A8       LDA    $20,X
775C: AB 27          ADDA   $F,X
775E: 24 8A          BCC    $7762
7760: 6C 2C          INC    $E,X
7762: A7 8D          STA    $F,X
7764: 39             RTS

7765: 34 92          PSHS   X
7767: CE 1A 48       LDU    #$3260
776A: 96 91          LDA    $19
776C: C6 08          LDB    #$20
776E: 3D             MUL
776F: 33 E9          LEAU   D,U
7771: 6C 46          INC    ,U
7773: EC 23          LDD    $1,X
7775: CB A2          ADDB   #$20
7777: ED 69          STD    $1,U
7779: 1F B9          TFR    U,X
777B: BD AD 36       JSR    $851E
777E: 35 98          PULS   X
7780: 39             RTS

7781: 96 64          LDA    $E6
7783: 97 6C          STA    $4E
7785: 96 6A          LDA    $E8
7787: 81 2A          CMPA   #$02
7789: 25 D4          BCS    $77E7
778B: 96 66          LDA    $4E
778D: E6 8A          LDB    $2,X
778F: D0 6C          SUBB   $4E
7791: E7 80          STB    $2,X
7793: BD A7 25       JSR    $8507
7796: 96 CC          LDA    $4E
7798: 20 2B          BRA    $779D
779A: A6 00 08       LDA    $20,X
779D: 97 C1          STA    $49
779F: 97 71          STA    $53
77A1: 27 C6          BEQ    $77E7
77A3: 10 8E F4 B4    LDY    #$D636
77A7: 96 31          LDA    $19
77A9: 48             ASLA
77AA: 48             ASLA
77AB: 31 8E          LEAY   A,Y
77AD: EE 2C          LDU    ,Y
77AF: 6C E3          INC    ,U++
77B1: 26 80          BNE    $77B5
77B3: 6C 7D          INC    -$1,U
77B5: 11 A3 A0       CMPU   $2,Y
77B8: 26 DD          BNE    $77AF
77BA: 6C 00 32       INC    $1A,X
77BD: 34 A8          PSHS   Y
77BF: BD 7D C1       JSR    $5FE3
77C2: BD FA 77       JSR    $7855
77C5: 35 A2          PULS   Y
77C7: 0A 61          DEC    $49
77C9: 26 6A          BNE    $77AD
77CB: 0D 31          TST    $19
77CD: 26 90          BNE    $77E7
77CF: 34 32          PSHS   X
77D1: 8E B0 A2       LDX    #$3220
77D4: 6D A6          TST    ,X
77D6: 27 8F          BEQ    $77E5
77D8: A6 2A          LDA    $2,X
77DA: 90 DB          SUBA   $53
77DC: 81 38          CMPA   #$10
77DE: 25 80          BCS    $77E8
77E0: A7 20          STA    $2,X
77E2: BD 07 19       JSR    $853B
77E5: 35 92          PULS   X
77E7: 39             RTS

77E8: 6F AC          CLR    ,X
77EA: 6F 89          CLR    $1,X
77EC: 6F 2A          CLR    $2,X
77EE: 20 7A          BRA    $77E2
77F0: 96 D0          LDA    $F2
77F2: 97 CC          STA    $4E
77F4: 96 6C          LDA    $4E
77F6: E6 80          LDB    $2,X
77F8: DB 66          ADDB   $4E
77FA: E7 8A          STB    $2,X
77FC: BD AD 8F       JSR    $8507
77FF: 96 6C          LDA    $4E
7801: 20 81          BRA    $7806
7803: A6 AA 02       LDA    $20,X
7806: 97 CB          STA    $49
7808: 27 0F          BEQ    $7831
780A: 10 8E FE 1E    LDY    #$D636
780E: 96 91          LDA    $19
7810: 48             ASLA
7811: 48             ASLA
7812: 31 24          LEAY   A,Y
7814: EE 86          LDU    ,Y
7816: A6 46          LDA    ,U
7818: 26 2A          BNE    $781C
781A: 6A C9          DEC    $1,U
781C: 6A E9          DEC    ,U++
781E: 11 A3 00       CMPU   $2,Y
7821: 26 71          BNE    $7816
7823: 6A AA 38       DEC    $1A,X
7826: 34 A2          PSHS   Y
7828: BD 48 99       JSR    $6011
782B: 35 08          PULS   Y
782D: 0A C1          DEC    $49
782F: 26 C1          BNE    $7814
7831: 39             RTS

7832: CE 54 12       LDU   #table_d630
7835: A6 06          LDA    ,X
7837: 81 2B          CMPA   #$03
7839: 24 8B          BCC    $783E
783B: 48             ASLA
783C: 6E FE          JMP    [A,U]        ; [jump_table]
783E: 6D 00 7A       TST    $58,X
7841: 26 8D          BNE    $7852
7843: A6 AA 02       LDA    $20,X
7846: 27 8B          BEQ    $7851
7848: 97 61          STA    $49
784A: BD 0B 93       JSR    $83BB
784D: 0A C1          DEC    $49
784F: 26 DB          BNE    $784A
7851: 39             RTS

7852: 7E 06 33       JMP    $8411
7855: 34 92          PSHS   X
7857: 8E 1A 48       LDX    #$3260
785A: 96 91          LDA    $19
785C: C6 08          LDB    #$20
785E: 3D             MUL
785F: 30 A9          LEAX   D,X
7861: A6 06          LDA    ,X
7863: 27 29          BEQ    $7870
7865: 6A 80          DEC    $2,X
7867: A6 2A          LDA    $2,X
7869: 81 78          CMPA   #$F0
786B: 27 2E          BEQ    $7873
786D: BD 0D 96       JSR    $851E
7870: 35 32          PULS   X
7872: 39             RTS

7873: 6F A6          CLR    ,X
7875: 6F 83          CLR    $1,X
7877: 6F 2A          CLR    $2,X
7879: 20 7A          BRA    $786D
787B: A6 A0 73       LDA    $5B,X
787E: 81 8C          CMPA   #$04
7880: 26 23          BNE    $7883
7882: 39             RTS

7883: 6D AA 7A       TST    $58,X
7886: 10 27 28 A1    LBEQ   $7913
788A: A6 00 7D       LDA    $55,X
788D: 27 AE          BEQ    $78B5
788F: 81 23          CMPA   #$01
7891: 27 CB          BEQ    $78DC
7893: 6D 2F          TST    $D,X
7895: 26 88          BNE    $78A1
7897: 33 A0 38       LEAU   $10,X
789A: 86 89          LDA    #$01
789C: 97 60          STA    $48
789E: BD D9 2D       JSR    $510F
78A1: 6A 0A D4       DEC    $56,X
78A4: 26 2C          BNE    $78B4
78A6: 4F             CLRA
78A7: 5F             CLRB
78A8: ED A0 DD       STD    $55,X
78AB: ED A0 7F       STD    $57,X
78AE: A7 00 7B       STA    $59,X
78B1: BD 01 39       JSR    $83BB
78B4: 39             RTS

78B5: 33 0A 92       LEAU   $10,X
78B8: 86 2E          LDA    #$06
78BA: 97 C0          STA    $48
78BC: BD 78 55       JSR    $50DD
78BF: BD 6D A8       JSR    $4F8A
78C2: 84 80          ANDA   #$02
78C4: 27 37          BEQ    $78DB
78C6: 86 E7          LDA    #$65
78C8: BD 66 3B       JSR    force_queue_sound_event_4eb3
78CB: 86 4E          LDA    #$66
78CD: BD C6 3B       JSR    force_queue_sound_event_4eb3
78D0: 6C AA DB       INC    $59,X
78D3: 6C AA 77       INC    $55,X
78D6: 86 92          LDA    #$10
78D8: A7 A0 DE       STA    $56,X
78DB: 39             RTS

78DC: 6D A0 D1       TST    $59,X
78DF: 27 34          BEQ    $78F7
78E1: BD CD 08       JSR    $4F8A
78E4: 84 20          ANDA   #$02
78E6: 26 87          BNE    $78ED
78E8: 6F A0 D1       CLR    $59,X
78EB: 20 22          BRA    $78F7
78ED: 33 00 98       LEAU   $10,X
78F0: 86 21          LDA    #$03
78F2: 97 CA          STA    $48
78F4: BD 72 5F       JSR    $50DD
78F7: 6D A0 7E       TST    $56,X
78FA: 27 8D          BEQ    $7901
78FC: 6A A0 DE       DEC    $56,X
78FF: 26 33          BNE    $7912
7901: 6D 0A DB       TST    $59,X
7904: 26 2E          BNE    $7912
7906: 6F 0A 7D       CLR    $55,X
7909: 6F 00 DF       CLR    $57,X
790C: 6F A0 D0       CLR    $58,X
790F: BD A1 99       JSR    $83BB
7912: 39             RTS

7913: A6 A6          LDA    ,X
7915: 81 87          CMPA   #$05
7917: 27 38          BEQ    $7929
7919: BD C7 02       JSR    $4F8A
791C: 84 2A          ANDA   #$02
791E: 27 81          BEQ    $7929
7920: 6C AA DA       INC    $58,X
7923: CC 20 1E       LDD    #$023C
7926: ED 0A 7D       STD    $55,X
7929: 39             RTS

792A: A6 85          LDA    $D,X
792C: 27 04          BEQ    $795A
792E: CE B8 82       LDU    #$30A0
7931: 6D CF          TST    $D,U
7933: 27 27          BEQ    $793A
7935: 33 4A E2       LEAU   $60,U
7938: 20 DF          BRA    $7931
793A: EC C6          LDD    $E,U
793C: A3 26          SUBD   $E,X
793E: 24 93          BCC    $795B
7940: 33 AA 92       LEAU   $10,X
7943: 86 27          LDA    #$05
7945: 97 CA          STA    $48
7947: BD 79 27       JSR    $510F
794A: 10 8E FE 6E    LDY    #$D646
794E: 96 91          LDA    $19
7950: E6 84          LDB    A,Y
7952: 4F             CLRA
7953: 10 A3 E6       CMPD   ,U
7956: 25 80          BCS    $795A
7958: ED EC          STD    ,U
795A: 39             RTS

795B: 10 83 28 C0    CMPD   #$0048
795F: 25 3C          BCS    $797F
7961: 8C B2 22       CMPX   #$30A0
7964: 27 3B          BEQ    $797F
7966: 8C B3 E8       CMPX   #$31C0
7969: 27 9C          BEQ    $797F
796B: 33 A0 38       LEAU   $10,X
796E: 86 8D          LDA    #$05
7970: 97 6A          STA    $48
7972: BD D2 F3       JSR    $50D1
7975: CC 83 81       LDD    #$0103
7978: 10 A3 4C       CMPD   ,U
797B: 24 2A          BCC    $797F
797D: ED 4C          STD    ,U
797F: 39             RTS

7980: 96 3B          LDA    $19
7982: 97 F5          STA    $77
7984: 34 32          PSHS   X
7986: 8E B1 A8       LDX    #$3380
7989: 96 91          LDA    $19
798B: D6 32          LDB    $1A
798D: 27 86          BEQ    $799D
798F: 4D             TSTA
7990: 27 6B          BEQ    $79DB
7992: 81 81          CMPA   #$03
7994: 27 67          BEQ    $79DB
7996: 4A             DECA
7997: D6 33          LDB    $1B
7999: 27 8A          BEQ    $799D
799B: 8B 2A          ADDA   #$02
799D: 97 91          STA    $19
799F: C6 2D          LDB    #$0F
79A1: 3D             MUL
79A2: 30 09          LEAX   D,X
79A4: CE 12 F2       LDU    #$3070
79A7: 10 8E 1C 20    LDY    #$34A8
79AB: 96 31          LDA    $19
79AD: 84 89          ANDA   #$01
79AF: C6 27          LDB    #$05
79B1: 3D             MUL
79B2: 31 29          LEAY   D,Y
79B4: A6 E2          LDA    ,U+
79B6: A7 02          STA    ,X+
79B8: A7 88          STA    ,Y+
79BA: C6 8A          LDB    #$02
79BC: A6 EC          LDA    ,U
79BE: 44             LSRA
79BF: 44             LSRA
79C0: 44             LSRA
79C1: 44             LSRA
79C2: A7 02          STA    ,X+
79C4: A7 82          STA    ,Y+
79C6: A6 42          LDA    ,U+
79C8: 84 27          ANDA   #$0F
79CA: A7 08          STA    ,X+
79CC: A7 88          STA    ,Y+
79CE: 5A             DECB
79CF: 26 C9          BNE    $79BC
79D1: 30 99          LEAX   -$5,X
79D3: BD 73 53       JSR    $5171
79D6: 86 84          LDA    #$06
79D8: BD 66 12       JSR    queue_event_4e9a
79DB: 35 38          PULS   X
79DD: 96 FF          LDA    $77
79DF: 97 3B          STA    $19
79E1: 39             RTS

79E2: 8D 85          BSR    $79EB
79E4: 8D 08          BSR    $7A10
79E6: 8D DE          BSR    $7A44
79E8: 7E 52 F0       JMP    $7A78
79EB: CE 0D AD       LDU    #$2585
79EE: 96 92          LDA    $1A
79F0: 27 2E          BEQ    $79FE
79F2: 8E 54 7B       LDX    #$D659
79F5: BD F8 18       JSR    $7A9A
79F8: 4F             CLRA
79F9: 97 C0          STA    $48
79FB: 7E 52 86       JMP    $7AAE
79FE: 8E 5E 6F       LDX    #$D64D
7A01: BD F8 18       JSR    $7A9A
7A04: 86 23          LDA    #$01
7A06: 0D 2F          TST    $AD
7A08: 27 29          BEQ    $7A0B
7A0A: 4F             CLRA
7A0B: 97 60          STA    $48
7A0D: 7E F2 26       JMP    $7AAE
7A10: CE 06 07       LDU    #$2485
7A13: 96 38          LDA    $1A
7A15: 27 9E          BEQ    $7A33
7A17: 8E FE 65       LDX    #$D64D
7A1A: 86 89          LDA    #$01
7A1C: 0D 33          TST    $1B
7A1E: 27 8D          BEQ    $7A25
7A20: 8E F4 D1       LDX    #$D653
7A23: 86 21          LDA    #$03
7A25: 97 CA          STA    $48
7A27: 8D 59          BSR    $7A9A
7A29: 7D B9 85       TST    $310D
7A2C: 27 2B          BEQ    $7A31
7A2E: 4F             CLRA
7A2F: 97 6A          STA    $48
7A31: 20 F9          BRA    $7AAE
7A33: 8E F4 72       LDX    #$D650
7A36: 8D E0          BSR    $7A9A
7A38: 86 2A          LDA    #$02
7A3A: 7D B9 25       TST    $310D
7A3D: 27 89          BEQ    $7A40
7A3F: 4F             CLRA
7A40: 97 6A          STA    $48
7A42: 20 E8          BRA    $7AAE
7A44: CE 01 07       LDU    #$2385
7A47: 96 32          LDA    $1A
7A49: 27 94          BEQ    $7A67
7A4B: 8E FE 78       LDX    #$D650
7A4E: 86 8A          LDA    #$02
7A50: 0D 39          TST    $1B
7A52: 27 87          BEQ    $7A59
7A54: 8E F4 D4       LDX    #$D656
7A57: 86 2C          LDA    #$04
7A59: 97 C0          STA    $48
7A5B: 8D 15          BSR    $7A9A
7A5D: 7D B9 E5       TST    $316D
7A60: 27 21          BEQ    $7A65
7A62: 4F             CLRA
7A63: 97 6A          STA    $48
7A65: 20 C5          BRA    $7AAE
7A67: 8E FE 7B       LDX    #$D653
7A6A: 8D A6          BSR    $7A9A
7A6C: 86 2B          LDA    #$03
7A6E: 7D B9 4F       TST    $316D
7A71: 27 83          BEQ    $7A74
7A73: 4F             CLRA
7A74: 97 6A          STA    $48
7A76: 20 B4          BRA    $7AAE
7A78: CE 0A 0D       LDU    #$2285
7A7B: 96 32          LDA    $1A
7A7D: 27 82          BEQ    $7A89
7A7F: 8E F4 7B       LDX    #$D659
7A82: 8D 94          BSR    $7A9A
7A84: 4F             CLRA
7A85: 97 CA          STA    $48
7A87: 20 0D          BRA    $7AAE
7A89: 8E 5E DE       LDX    #$D656
7A8C: 8D 24          BSR    $7A9A
7A8E: 86 8C          LDA    #$04
7A90: 7D 13 4F       TST    $31CD
7A93: 27 23          BEQ    $7A96
7A95: 4F             CLRA
7A96: 97 CA          STA    $48
7A98: 20 3C          BRA    $7AAE
7A9A: C6 85          LDB    #$0D
7A9C: A6 A8          LDA    ,X+
7A9E: BD CA 0F       JSR    $422D
7AA1: A6 02          LDA    ,X+
7AA3: BD 60 0F       JSR    $422D
7AA6: A6 02          LDA    ,X+
7AA8: BD 6A A5       JSR    $422D
7AAB: 33 69          LEAU   $1,U
7AAD: 39             RTS

7AAE: 96 C0          LDA    $48
7AB0: 27 28          BEQ    $7ABC
7AB2: 4A             DECA
7AB3: 97 3B          STA    $19
7AB5: 86 8F          LDA    #$0D
7AB7: 97 78          STA    $50
7AB9: 7E DB 08       JMP    $5380
7ABC: 8E FE C2       LDX    #$D64A
7ABF: 20 FB          BRA    $7A9A
7AC1: BD D3 C7       JSR    $5145
7AC4: 5F             CLRB
7AC5: 10 8E 54 74    LDY    #$D65C
7AC9: A6 28          LDA    ,Y+
7ACB: A1 EC          CMPA   ,U		; [video_address]
7ACD: 27 8B          BEQ    $7AD2
7ACF: 5C             INCB
7AD0: 20 D5          BRA    $7AC9
7AD2: D7 69          STB    $EB
7AD4: 86 2A          LDA    #$08
7AD6: 90 39          SUBA   $BB
7AD8: 97 C4          STA    $EC
7ADA: CE B8 98       LDU    #$30B0
7ADD: CC 89 8A       LDD    #$0102
7AE0: ED E6          STD    ,U
7AE2: 6F C0          CLR    $2,U
7AE4: 6F 61          CLR    $3,U
7AE6: 96 69          LDA    $EB
7AE8: 81 2A          CMPA   #$02
7AEA: 25 8F          BCS    $7AF3
7AEC: 97 60          STA    $48
7AEE: BD D8 F3       JSR    $50D1
7AF1: 20 88          BRA    $7AFD
7AF3: CC 23 23       LDD    #$0101
7AF6: ED 46          STD    ,U
7AF8: CC 20 88       LDD    #$0800
7AFB: ED 6A          STD    $2,U
7AFD: 4F             CLRA
7AFE: D6 32          LDB    $BA
7B00: C5 A2          BITB   #$80
7B02: 26 83          BNE    $7B05
7B04: 4C             INCA
7B05: 10 83 83 38    CMPD   #$0110
7B09: 25 8A          BCS    $7B0D
7B0B: 0C C6          INC    $EE
7B0D: 39             RTS

7B0E: CE BD 2A       LDU    #$3508
7B11: 96 9B          LDA    $19
7B13: C6 02          LDB    #$20
7B15: 3D             MUL
7B16: EC 49          LDD    D,U
7B18: DD D4          STD    $FC
7B1A: CE 5E 4B       LDU    #$D663
7B1D: 96 63          LDA    $EB
7B1F: E6 E4          LDB    A,U
7B21: 4F             CLRA
7B22: DD 74          STD    $F6
7B24: 96 DC          LDA    $FE
7B26: 48             ASLA
7B27: CE FE 42       LDU    #$D66A
7B2A: EC 4E          LDD    A,U
7B2C: DD D0          STD    $F8
7B2E: CE 5E 58       LDU    #$D67A
7B31: 96 6D          LDA    nb_long_horse_turns_ef
7B33: 81 34          CMPA   #$16
7B35: 25 80          BCS    $7B39
7B37: 86 3E          LDA    #$16
7B39: 48             ASLA
7B3A: EC 4E          LDD    A,U
7B3C: DD D2          STD    $FA
7B3E: BD F6 C4       JSR    $7EE6
7B41: 10 8E B2 D4    LDY    #$30F6
7B45: C6 86          LDB    #$04
7B47: 86 29          LDA    #$01
7B49: 97 DA          STA    $52
7B4B: BD 56 D8       JSR    $7EF0
7B4E: 31 AA          LEAY   $2,Y
7B50: 5A             DECB
7B51: 26 76          BNE    $7B47
7B53: CE 12 BA       LDU    #$3098
7B56: 0F 19          CLR    $9B
7B58: 31 6C          LEAY   $4,U
7B5A: C6 8A          LDB    #$02
7B5C: A6 E8          LDA    ,U+
7B5E: 97 C0          STA    $48
7B60: 44             LSRA
7B61: 44             LSRA
7B62: 44             LSRA
7B63: 44             LSRA
7B64: A7 82          STA    ,Y+
7B66: 96 CA          LDA    $48
7B68: 84 27          ANDA   #$0F
7B6A: A7 28          STA    ,Y+
7B6C: 5A             DECB
7B6D: 26 65          BNE    $7B5C
7B6F: 96 BE          LDA    $9C
7B71: 27 84          BEQ    $7B79
7B73: 0F BF          CLR    $9D
7B75: 0F 1C          CLR    $9E
7B77: 0F B7          CLR    $9F
7B79: CE BD 80       LDU    #$3508
7B7C: 96 31          LDA    $19
7B7E: C6 A8          LDB    #$20
7B80: 3D             MUL
7B81: 33 49          LEAU   D,U
7B83: 6F E6          CLR    ,U
7B85: 6F C3          CLR    $1,U
7B87: 8E 18 B3       LDX    #$309B
7B8A: BD DA 8B       JSR    $52A3
7B8D: 0D E4          TST    $6C
7B8F: 27 26          BEQ    $7B95
7B91: 86 87          LDA    #$05
7B93: A7 63          STA    $1,U
7B95: 39             RTS

7B96: 8E 54 80       LDX   #table_d6a8
7B99: 96 AC          LDA    $24
7B9B: 48             ASLA
7B9C: 6E BE          JMP    [A,X]        ; [jump_table]
7B9E: 96 84          LDA    $0C
7BA0: 84 2D          ANDA   #$0F
7BA2: 81 8D          CMPA   #$0F
7BA4: 27 25          BEQ    $7BAD
7BA6: 96 81          LDA    $03
7BA8: 27 22          BEQ    $7BB4
7BAA: 7E F4 08       JMP    $7C20
7BAD: BD D0 E1       JSR    $5869
7BB0: 4D             TSTA
7BB1: 27 83          BEQ    $7BB4
7BB3: 39             RTS

7BB4: 4F             CLRA
7BB5: 5F             CLRB
7BB6: 8E B2 40       LDX    #current_level_3068
7BB9: ED 09          STD    ,X++
7BBB: 8C 18 58       CMPX   #$3070
7BBE: 26 71          BNE    $7BB9
7BC0: 8E F4 2C       LDX    #$D6AE
7BC3: 0C 5C          INC    $7E
7BC5: 96 FC          LDA    $7E
7BC7: C6 2B          LDB    #$03
7BC9: BD 2E 8E       JSR    $A606
; select next demo
7BCC: A6 AE          LDA    A,X
7BCE: 97 E1          STA    current_event_69
7BD0: 86 23          LDA    #$01
7BD2: 97 8D          STA    $0F
7BD4: 7F 11 EE       CLR    $336C
7BD7: 86 BF          LDA    #$97
7BD9: B7 BB E5       STA    $336D
7BDC: 0C 0C          INC    $24
7BDE: 39             RTS

7BDF: 96 2E          LDA    $0C
7BE1: 84 8D          ANDA   #$0F
7BE3: 81 2D          CMPA   #$0F
7BE5: 27 85          BEQ    $7BEE
7BE7: 96 2B          LDA    $03
7BE9: 27 82          BEQ    $7BF5
7BEB: 7E 54 08       JMP    $7C20
7BEE: BD D0 4B       JSR    $5869
7BF1: 4D             TSTA
7BF2: 27 83          BEQ    $7BF5
7BF4: 39             RTS

7BF5: 8E 54 33       LDX   #table_d6b1
7BF8: 96 0E          LDA    $26
7BFA: 48             ASLA
7BFB: 6E BE          JMP    [A,X]        ; [jump_table]
7BFD: 8E BD 88       LDX    #$3500
7C00: 4F             CLRA
7C01: 5F             CLRB
7C02: ED 03          STD    ,X++
7C04: ED A3          STD    ,X++
7C06: 8C B7 A8       CMPX   #$3580
7C09: 26 7F          BNE    $7C02
7C0B: 96 0A          LDA    $22
7C0D: 0F AA          CLR    $22
7C0F: 81 21          CMPA   #$03
7C11: 27 86          BEQ    $7C17
7C13: 86 20          LDA    #$02
7C15: 97 A0          STA    $22
7C17: 0F 0C          CLR    $24
7C19: 0F AE          CLR    $26
7C1B: 0F 02          CLR    event_sub_state_2a
7C1D: 0F A3          CLR    $2B
7C1F: 39             RTS

7C20: 86 23          LDA    #$01
7C22: 97 A2          STA    $20
7C24: 0F 00          CLR    $22
7C26: 0F A6          CLR    $24
7C28: 0F 0E          CLR    $26
7C2A: 0F A0          CLR    event_sub_state_28
7C2C: 0F 02          CLR    event_sub_state_2a
7C2E: 0F A4          CLR    $2C
7C30: 39             RTS

7C31: BD 2D 43       JSR    $AFC1
7C34: CE 00 82       LDU    #$2200
7C37: 86 38          LDA    #$10
7C39: 97 C0          STA    $48
7C3B: 86 38          LDA    #$10
7C3D: C6 A8          LDB    #$20
7C3F: 6F EB 2A 82    CLR    $0800,U					;  [video_address]
7C43: A7 E2          STA    ,U+					;  [video_address]
7C45: 5A             DECB
7C46: 26 75          BNE    $7C3F
7C48: 33 E0 A8       LEAU   $20,U
7C4B: 0A 60          DEC    $48
7C4D: 26 66          BNE    $7C3D
7C4F: 39             RTS

7C50: CE 00 C0       LDU    #$2242
7C53: CC 39 2F       LDD    #$1B0D
7C56: DD CA          STD    $48
7C58: 86 52          LDA    #$7A
7C5A: 20 8A          BRA    $7C5E
7C5C: 86 53          LDA    #$7B
7C5E: DF C3          STU    $4B
7C60: D6 6A          LDB    $48
7C62: D7 CF          STB    $4D
7C64: 8D 3A          BSR    $7C7E
7C66: D6 CB          LDB    $49
7C68: D7 65          STB    $4D
7C6A: 8D 97          BSR    $7C8B
7C6C: DE 63          LDU    $4B
7C6E: 33 40 62       LEAU   $40,U
7C71: D6 CB          LDB    $49
7C73: D7 6F          STB    $4D
7C75: 8D 96          BSR    $7C8B
7C77: 33 E0 E9       LEAU   -$3F,U
7C7A: D6 C0          LDB    $48
7C7C: D7 65          STB    $4D
7C7E: D6 C2          LDB    $4A
7C80: E7 EB 8A 82    STB    $0800,U					;  [video_address]
7C84: A7 E2          STA    ,U+					;  [video_address]
7C86: 0A CF          DEC    $4D
7C88: 26 DE          BNE    $7C80
7C8A: 39             RTS

7C8B: D6 62          LDB    $4A
7C8D: E7 41 80 22    STB    $0800,U					;  [video_address]
7C91: A7 46          STA    ,U					;  [video_address]
7C93: 33 EA 62       LEAU   $40,U
7C96: 0A CF          DEC    $4D
7C98: 26 DB          BNE    $7C8D
7C9A: 39             RTS

7C9B: 8E 01 3D       LDX    #$2915
7C9E: B6 BB D6       LDA    $33F4
7CA1: 4A             DECA
7CA2: C6 C2          LDB    #$40
7CA4: 3D             MUL
7CA5: 30 09          LEAX   D,X
7CA7: 86 22          LDA    #$0A
7CA9: 97 C0          STA    $48
7CAB: 86 28          LDA    #$00
7CAD: D6 87          LDB    $0F
7CAF: C4 2A          ANDB   #$08
7CB1: 27 80          BEQ    $7CB5
7CB3: 86 21          LDA    #$03
7CB5: A7 02          STA    ,X+		; [video_address]
7CB7: 0A 60          DEC    $48
7CB9: 26 72          BNE    $7CB5
7CBB: 96 27          LDA    $0F
7CBD: 84 8B          ANDA   #$03
7CBF: 26 28          BNE    $7CCB
7CC1: CE A8 C0       LDU    #$2A42
7CC4: CC 39 8F       LDD    #$1B0D
7CC7: DD 60          STD    $48
7CC9: 8D DA          BSR    $7D1D
7CCB: 96 27          LDA    $0F
7CCD: 84 8C          ANDA   #$04
7CCF: 27 3A          BEQ    $7CE9
7CD1: CC 83 81       LDD    #$0103
7CD4: BD 6C 18       JSR    queue_event_4e9a
7CD7: 8D 34          BSR    $7CF5
7CD9: CC 89 82       LDD    #$010A
7CDC: BD 66 12       JSR    queue_event_4e9a
7CDF: 8D 38          BSR    $7CFB
7CE1: CC 83 83       LDD    #$0101
7CE4: BD 6C 18       JSR    queue_event_4e9a
7CE7: 20 00          BRA    $7D11
7CE9: CC 89 88       LDD    #$0100
7CEC: BD 66 12       JSR    queue_event_4e9a
7CEF: 8D 26          BSR    $7CF5
7CF1: 8D 8A          BSR    $7CFB
7CF3: 20 3E          BRA    $7D11
7CF5: CC 80 A2       LDD    #$0220
7CF8: 7E 66 12       JMP    queue_event_4e9a
7CFB: CC 2A 09       LDD    #$0221
7CFE: BD C6 B8       JSR    queue_event_4e9a
7D01: 86 80          LDA    #$02
7D03: F6 11 D6       LDB    $33F4
7D06: CB A6          ADDB   #$24
7D08: BD 66 12       JSR    queue_event_4e9a
7D0B: CC 2A 0A       LDD    #$0222
7D0E: 7E C6 B8       JMP    queue_event_4e9a
7D11: CC 80 A1       LDD    #$0223
7D14: BD 6C 18       JSR    queue_event_4e9a
7D17: CC 2A 0C       LDD    #$0224
7D1A: 7E C6 B2       JMP    queue_event_4e9a
7D1D: 0C ED          INC    $65
7D1F: 8E F4 99       LDX    #$D6BB
7D22: 96 E7          LDA    $65
7D24: 84 21          ANDA   #$03
7D26: 30 04          LEAX   A,X
7D28: D6 60          LDB    $48
7D2A: A6 0C          LDA    ,X
7D2C: A7 E8          STA    ,U+		; [video_address]
7D2E: 5A             DECB
7D2F: 27 37          BEQ    $7D46
7D31: A6 83          LDA    $1,X
7D33: A7 E2          STA    ,U+		; [video_address]
7D35: 5A             DECB
7D36: 27 8C          BEQ    $7D46
7D38: A6 2A          LDA    $2,X
7D3A: A7 48          STA    ,U+		; [video_address]
7D3C: 5A             DECB
7D3D: 27 8F          BEQ    $7D46
7D3F: A6 21          LDA    $3,X
7D41: A7 42          STA    ,U+		; [video_address]
7D43: 5A             DECB
7D44: 26 C6          BNE    $7D2A
7D46: D6 CB          LDB    $49
7D48: A6 AC          LDA    ,X
7D4A: A7 4C          STA    ,U		; [video_address]
7D4C: 33 E0 C8       LEAU   $40,U
7D4F: 5A             DECB
7D50: 27 3C          BEQ    $7D70
7D52: A6 83          LDA    $1,X
7D54: A7 E6          STA    ,U				; [video_address]
7D56: 33 4A 68       LEAU   $40,U
7D59: 5A             DECB
7D5A: 27 9C          BEQ    $7D70
7D5C: A6 2A          LDA    $2,X
7D5E: A7 4C          STA    ,U					; [video_address]
7D60: 33 EA C2       LEAU   $40,U
7D63: 5A             DECB
7D64: 27 28          BEQ    $7D70
7D66: A6 81          LDA    $3,X
7D68: A7 EC          STA    ,U					; [video_address]
7D6A: 33 40 68       LEAU   $40,U
7D6D: 5A             DECB
7D6E: 26 50          BNE    $7D48
7D70: 33 63          LEAU   $1,U
7D72: D6 CA          LDB    $48
7D74: A6 A6          LDA    ,X
7D76: A7 40          STA    ,-U				; [video_address]
7D78: 5A             DECB
7D79: 27 9D          BEQ    $7D90
7D7B: A6 29          LDA    $1,X
7D7D: A7 4A          STA    ,-U					; [video_address]
7D7F: 5A             DECB
7D80: 27 2C          BEQ    $7D90
7D82: A6 80          LDA    $2,X
7D84: A7 E0          STA    ,-U					; [video_address]
7D86: 5A             DECB
7D87: 27 2F          BEQ    $7D90
7D89: A6 8B          LDA    $3,X
7D8B: A7 EA          STA    ,-U					; [video_address]
7D8D: 5A             DECB
7D8E: 26 6C          BNE    $7D74
7D90: 33 7D          LEAU   -$1,U
7D92: D6 CB          LDB    $49
7D94: A6 A6          LDA    ,X
7D96: A7 46          STA    ,U			; [video_address]
7D98: 33 E0 48       LEAU   -$40,U	
7D9B: 5A             DECB
7D9C: 27 36          BEQ    $7DBC
7D9E: A6 89          LDA    $1,X
7DA0: A7 E6          STA    ,U						; [video_address]
7DA2: 33 4A E2       LEAU   -$40,U
7DA5: 5A             DECB
7DA6: 27 96          BEQ    $7DBC
7DA8: A6 2A          LDA    $2,X
7DAA: A7 4C          STA    ,U					; [video_address]
7DAC: 33 E0 48       LEAU   -$40,U
7DAF: 5A             DECB
7DB0: 27 28          BEQ    $7DBC
7DB2: A6 81          LDA    $3,X
7DB4: A7 E6          STA    ,U					; [video_address]
7DB6: 33 4A E8       LEAU   -$40,U
7DB9: 5A             DECB
7DBA: 26 50          BNE    $7D94
7DBC: 39             RTS

7DBD: 8E BB 08       LDX    #$3380
7DC0: 0F 3B          CLR    $19
7DC2: 86 86          LDA    #$04
7DC4: D6 38          LDB    $1A
7DC6: 27 89          BEQ    $7DD3
7DC8: 86 2A          LDA    #$02
7DCA: D6 93          LDB    $1B
7DCC: 27 2D          BEQ    $7DD3
7DCE: 30 00 3C       LEAX   event_pointer_1e,X
7DD1: 97 9B          STA    $19
7DD3: 97 47          STA    $65
7DD5: BD FC 64       JSR    $7EE6
7DD8: 10 8E BD 8C    LDY    #$3504
7DDC: 96 31          LDA    $19
7DDE: C6 A8          LDB    #$20
7DE0: 3D             MUL
7DE1: A6 29          LDA    D,Y
7DE3: 26 19          BNE    $7E20
7DE5: A6 06          LDA    ,X
7DE7: C6 2E          LDB    #$06
7DE9: 3D             MUL
7DEA: EB 89          ADDB   $1,X
7DEC: D7 7A          STB    $52
7DEE: C1 83          CMPB   #$0B
7DF0: 24 05          BCC    $7E19
7DF2: 86 88          LDA    #$0A
7DF4: 90 70          SUBA   $52
7DF6: 27 8B          BEQ    $7E01
7DF8: 97 7A          STA    $52
7DFA: 10 8E FE E5    LDY    #$D6CD
7DFE: BD F6 D2       JSR    $7EF0
7E01: A6 80          LDA    $2,X
7E03: C6 28          LDB    #$0A
7E05: 3D             MUL
7E06: EB 81          ADDB   $3,X
7E08: D7 7A          STB    $52
7E0A: 86 EC          LDA    #$64
7E0C: 90 7A          SUBA   $52
7E0E: 97 DA          STA    $52
7E10: 27 25          BEQ    $7E19
7E12: 10 8E F4 E1    LDY    #$D6C3
7E16: BD FC D8       JSR    $7EF0
7E19: 34 98          PSHS   X
7E1B: BD 57 22       JSR    $7F0A
7E1E: 35 98          PULS   X
7E20: 30 2D          LEAX   $F,X
7E22: 0C 9B          INC    $19
7E24: 0A 47          DEC    $65
7E26: 26 2F          BNE    $7DD5
7E28: 39             RTS

7E29: 8E B8 14       LDX    #$309C
7E2C: BD 56 6E       JSR    $7EE6
7E2F: A6 A6          LDA    ,X
7E31: C6 88          LDB    #$0A
7E33: 3D             MUL
7E34: EB 23          ADDB   $1,X
7E36: C1 89          CMPB   #$0B
7E38: 25 14          BCS    $7E76
7E3A: D7 D8          STB    $50
7E3C: C0 23          SUBB   #$0B
7E3E: 27 81          BEQ    $7E49
7E40: D7 70          STB    $52
7E42: 10 8E F4 F7    LDY    #$D6D5
7E46: BD FC D8       JSR    $7EF0
7E49: A6 8A          LDA    $2,X
7E4B: C6 22          LDB    #$0A
7E4D: 3D             MUL
7E4E: EB 8B          ADDB   $3,X
7E50: D7 70          STB    $52
7E52: 27 85          BEQ    $7E5B
7E54: 10 8E 54 53    LDY    #$D6D1
7E58: BD 56 78       JSR    $7EF0
7E5B: 86 2A          LDA    #$02
7E5D: 97 DA          STA    $52
7E5F: 10 8E F4 51    LDY    #$D6D3
7E63: BD 5C D2       JSR    $7EF0
7E66: 96 D2          LDA    $50
7E68: 81 3B          CMPA   #$13
7E6A: 25 82          BCS    $7E76
7E6C: 86 22          LDA    #$0A
7E6E: 97 DA          STA    $52
7E70: 10 8E 54 4D    LDY    #$D6CF
7E74: 8D 58          BSR    $7EF0
7E76: EC 46          LDD    ,U
7E78: ED 69          STD    $1,U
7E7A: 6F 4C          CLR    ,U
7E7C: 7E 57 82       JMP    $7F0A
7E7F: 8E 12 BE       LDX    #$309C
7E82: 8D E0          BSR    $7EE6
7E84: A6 A6          LDA    ,X
7E86: 81 83          CMPA   #$01
7E88: 27 7D          BEQ    $7EDF
7E8A: A6 89          LDA    $1,X
7E8C: C6 22          LDB    #$0A
7E8E: 3D             MUL
7E8F: EB 20          ADDB   $2,X
7E91: C1 BC          CMPB   #$3E
7E93: 25 6A          BCS    $7EDD
7E95: C0 BC          SUBB   #$3E
7E97: D7 7B          STB    $53
7E99: 27 86          BEQ    $7EA9
7E9B: C1 08          CMPB   #$20
7E9D: 25 8A          BCS    $7EA1
7E9F: C6 02          LDB    #$20
7EA1: D7 D0          STB    $52
7EA3: 10 8E F4 45    LDY    #$D6C7
7EA7: 8D 6F          BSR    $7EF0
7EA9: 96 DB          LDA    $53
7EAB: 81 08          CMPA   #$20
7EAD: 24 9A          BCC    $7EC1
7EAF: A6 21          LDA    $3,X
7EB1: 81 87          CMPA   #$05
7EB3: 26 28          BNE    $7EBF
7EB5: 86 83          LDA    #$01
7EB7: 97 7A          STA    $52
7EB9: 10 8E 5E ED    LDY    #$D6C5
7EBD: 8D B9          BSR    $7EF0
7EBF: 20 6B          BRA    $7F0A
7EC1: 80 A2          SUBA   #$20
7EC3: 27 2A          BEQ    $7ECD
7EC5: 97 D0          STA    $52
7EC7: 10 8E FE 43    LDY    #$D6CB
7ECB: 8D 0B          BSR    $7EF0
7ECD: A6 8B          LDA    $3,X
7ECF: 81 27          CMPA   #$05
7ED1: 26 88          BNE    $7EDD
7ED3: 86 23          LDA    #$01
7ED5: 97 D0          STA    $52
7ED7: 10 8E FE 41    LDY    #$D6C9
7EDB: 8D 3B          BSR    $7EF0
7EDD: 20 A3          BRA    $7F0A
7EDF: CC 32 22       LDD    #$1000
7EE2: ED C3          STD    $1,U
7EE4: 20 06          BRA    $7F0A
7EE6: CE B2 BF       LDU    #$3097
7EE9: 6F 4C          CLR    ,U
7EEB: 6F 69          CLR    $1,U
7EED: 6F CA          CLR    $2,U
7EEF: 39             RTS

7EF0: A6 60          LDA    $2,U
7EF2: AB A3          ADDA   $1,Y
7EF4: 19             DAA
7EF5: A7 C0          STA    $2,U
7EF7: A6 69          LDA    $1,U
7EF9: A9 2C          ADCA   ,Y
7EFB: 19             DAA
7EFC: A7 69          STA    $1,U
7EFE: A6 4C          LDA    ,U
7F00: 89 22          ADCA   #$00
7F02: 19             DAA
7F03: A7 E6          STA    ,U
7F05: 0A D0          DEC    $52
7F07: 26 CF          BNE    $7EF0
7F09: 39             RTS

7F0A: 8E BC A8       LDX    #$3480
7F0D: 96 91          LDA    $19
7F0F: C6 21          LDB    #$03
7F11: 3D             MUL
7F12: 30 09          LEAX   D,X
7F14: CE 12 15       LDU    #$3097
7F17: 8D 20          BSR    $7F21
7F19: BD DD B4       JSR    $553C
7F1C: 86 2F          LDA    #$07
7F1E: 7E C6 B8       JMP    queue_event_4e9a
7F21: A6 80          LDA    $2,X
7F23: AB 60          ADDA   $2,U
7F25: 19             DAA
7F26: A7 80          STA    $2,X
7F28: A6 29          LDA    $1,X
7F2A: A9 C9          ADCA   $1,U
7F2C: 19             DAA
7F2D: A7 89          STA    $1,X
7F2F: A6 A6          LDA    ,X
7F31: A9 46          ADCA   ,U
7F33: 19             DAA
7F34: A7 A6          STA    ,X
7F36: 39             RTS

7F37: 96 40          LDA    current_level_68
7F39: C6 8F          LDB    #$07
7F3B: BD 8E 2E       JSR    $A606
7F3E: D7 C0          STB    $48
7F40: C1 21          CMPB   #$03
7F42: 24 8B          BCC    $7F4D
7F44: FC 1D 82       LDD    $3F00
7F47: 10 83 29 8A    CMPD   #$0102
7F4B: 27 72          BEQ    $7FA7
7F4D: 8E 5E 56       LDX    #$D6DE
7F50: D6 6A          LDB    $48
7F52: C1 87          CMPB   #$05
7F54: 25 20          BCS    $7F58
7F56: C6 87          LDB    #$05
7F58: 58             ASLB
7F59: AE 0D          LDX    B,X
7F5B: C1 2C          CMPB   #$04
7F5D: 24 87          BCC    $7F6E
7F5F: 96 2C          LDA    $0E
7F61: 5D             TSTB
7F62: 27 87          BEQ    $7F69
7F64: CE F4 68       LDU    #$D6EA
7F67: A6 EE          LDA    A,U
7F69: C6 8F          LDB    #$07
7F6B: 3D             MUL
7F6C: 30 A3          LEAX   D,X
7F6E: CE 5F B9       LDU    #$D79B
7F71: 96 EB          LDA    current_event_69
7F73: 1F AB          TFR    A,B
7F75: 48             ASLA
7F76: EE 44          LDU    A,U
7F78: 86 2B          LDA    #$03
7F7A: C1 8B          CMPB   #$03
7F7C: 27 2A          BEQ    $7F80
7F7E: 86 8A          LDA    #$02
7F80: E6 A7          LDB    B,X
7F82: 3D             MUL
7F83: 33 E9          LEAU   D,U
7F85: 8E B2 E2       LDX    #$3060
7F88: 4F             CLRA
7F89: D6 E1          LDB    current_event_69
7F8B: C1 2B          CMPB   #$03
7F8D: 26 8A          BNE    $7F91
7F8F: A6 E2          LDA    ,U+
7F91: A7 02          STA    ,X+
7F93: C6 20          LDB    #$02
7F95: A6 46          LDA    ,U
7F97: 44             LSRA
7F98: 44             LSRA
7F99: 44             LSRA
7F9A: 44             LSRA
7F9B: A7 A8          STA    ,X+
7F9D: A6 48          LDA    ,U+
7F9F: 84 2D          ANDA   #$0F
7FA1: A7 02          STA    ,X+
7FA3: 5A             DECB
7FA4: 26 CD          BNE    $7F95
7FA6: 39             RTS

7FA7: 8E 17 38       LDX    #$3F10
7FAA: 86 95          LDA    #$1D
7FAC: D6 60          LDB    $48
7FAE: 3D             MUL
7FAF: 30 A9          LEAX   D,X
7FB1: CE 54 55       LDU    #$D6D7
7FB4: 96 4B          LDA    current_event_69
7FB6: E6 44          LDB    A,U
7FB8: 30 AD          LEAX   B,X
7FBA: CE B8 48       LDU    #$3060
7FBD: C6 8D          LDB    #$05
7FBF: 81 21          CMPA   #$03
7FC1: 27 86          BEQ    $7FC7
7FC3: C6 26          LDB    #$04
7FC5: 6F 42          CLR    ,U+
7FC7: A6 A8          LDA    ,X+
7FC9: A7 48          STA    ,U+
7FCB: 5A             DECB
7FCC: 26 D1          BNE    $7FC7
7FCE: 39             RTS

7FCF: CE 14 12       LDU    #$3630
7FD2: 10 8E FA 6C    LDY    #$D84E
7FD6: B6 B0 4B       LDA    $3263
7FD9: 48             ASLA
7FDA: 31 2E          LEAY   A,Y
7FDC: 7E A1 C3       JMP    $894B

8000: 96 4B          LDA    current_event_69
8002: 81 82          CMPA   #$00
8004: 26 31          BNE    $8019
8006: 8E B0 48       LDX    #$3260
8009: 6F 0C          CLR    ,X
800B: B6 1C CF       LDA    $34E7
800E: 27 81          BEQ    $8019
8010: 6C A6          INC    ,X
8012: CC 32 D2       LDD    #$B0F0
8015: ED 83          STD    $1,X
8017: 8D 12          BSR    $8053
8019: 39             RTS

801A: 96 E1          LDA    current_event_69
801C: 81 28          CMPA   #$00
801E: 26 BA          BNE    $8052
8020: 8E 10 E2       LDX    #$3260
8023: 6D A6          TST    ,X
8025: 27 A9          BEQ    $8052
8027: 6A 2A          DEC    $2,X
8029: A6 8A          LDA    $2,X
802B: 81 27          CMPA   #$0F
802D: 27 86          BEQ    $803D
802F: 81 12          CMPA   #$30
8031: 25 86          BCS    $8037
8033: 0F 6A          CLR    $48
8035: 20 9E          BRA    $8053
8037: 86 29          LDA    #$01
8039: 97 C0          STA    $48
803B: 20 3E          BRA    $8053
803D: 6F 0C          CLR    ,X
803F: 6F 23          CLR    $1,X
8041: 6F 80          CLR    $2,X
8043: 8D 2C          BSR    $8053
8045: 86 81          LDA    #$03
8047: B7 1C CE       STA    $34E6
804A: BD 08 DE       JSR    $80F6
804D: 86 B1          LDA    #$39
804F: BD 6C 91       JSR    force_queue_sound_event_4eb3
8052: 39             RTS

8053: CE FA 16       LDU    #$D834
8056: 96 CA          LDA    $48
8058: C6 2B          LDB    #$03
805A: 3D             MUL
805B: 31 E3          LEAY   D,U
805D: CE BE 88       LDU    #$3600
8060: 7E AB 8D       JMP    $890F
8063: 8E 10 72       LDX    #$3250
8066: 6F 06          CLR    ,X
8068: B6 1C 6F       LDA    $34E7
806B: 27 21          BEQ    $8076
806D: 6C 0C          INC    ,X
806F: CC D2 52       LDD    #$F070
8072: ED 83          STD    $1,X
8074: 8D 40          BSR    $80D8
8076: 39             RTS

8077: 7D 1C CF       TST    $34E7
807A: 27 A9          BEQ    $809D
807C: 8E 1A D8       LDX    #$3250
807F: CE FA 0C       LDU   #table_d82e
8082: A6 06          LDA    ,X
8084: 48             ASLA
8085: 6E 54          JMP    [A,U]        ; [jump_table]
8087: 6A 29          DEC    $1,X
8089: 6A 89          DEC    $1,X
808B: A6 29          LDA    $1,X
808D: 81 D5          CMPA   #$5D
808F: 25 20          BCS    $8093
8091: 20 C7          BRA    $80D8
8093: 6C A6          INC    ,X
8095: 86 DE          LDA    #$5C
8097: A7 29          STA    $1,X
8099: 0F 60          CLR    $E8
809B: 0F 4D          CLR    $65
809D: 39             RTS

809E: CE 5D D0       LDU    #$D5F2
80A1: 96 6A          LDA    $E8
80A3: A6 E4          LDA    A,U
80A5: 8B DE          ADDA   #$5C
80A7: A7 29          STA    $1,X
80A9: 0C 60          INC    $E8
80AB: 96 C0          LDA    $E8
80AD: 81 9A          CMPA   #$12
80AF: 26 20          BNE    $80B3
80B1: 0F 6A          CLR    $E8
80B3: 81 23          CMPA   #$01
80B5: 26 8F          BNE    $80C4
80B7: 86 0B          LDA    #$23
80B9: BD C6 3B       JSR    force_queue_sound_event_4eb3
80BC: 0C 4D          INC    $65
80BE: 96 ED          LDA    $65
80C0: 81 26          CMPA   #$04
80C2: 27 86          BEQ    $80C8
80C4: 6C 20          INC    $2,X
80C6: 20 92          BRA    $80D8
80C8: 6F AC          CLR    ,X
80CA: 8D 9E          BSR    $80E2
80CC: 96 31          LDA    $19
80CE: 97 FF          STA    $77
80D0: 86 21          LDA    #$03
80D2: B7 B6 C4       STA    $34E6
80D5: 8D 9D          BSR    $80F6
80D7: 39             RTS

80D8: CE 1E 88       LDU    #$3600
80DB: 10 8E F0 B2    LDY    #$D83A
80DF: 7E AB 69       JMP    $894B
80E2: 8E B0 7A       LDX    #$3258
80E5: FC B0 D3       LDD    $3251
80E8: 8B 38          ADDA   #$10
80EA: ED 89          STD    $1,X
80EC: CE 1E 8C       LDU    #$3604
80EF: 10 8E FA BE    LDY    #$D83C
80F3: 7E AB 69       JMP    $894B
80F6: 8E B6 A8       LDX    #$3480
80F9: 96 FF          LDA    $77
80FB: C6 2B          LDB    #$03
80FD: 3D             MUL
80FE: 30 03          LEAX   D,X
8100: CE FA EB       LDU    #$D869
8103: B6 16 C4       LDA    $34E6
8106: 27 93          BEQ    $8119
8108: 4A             DECA
8109: C6 8B          LDB    #$03
810B: 3D             MUL
810C: 33 E3          LEAU   D,U
810E: BD F7 03       JSR    $7F21
8111: BD D7 BE       JSR    $553C
8114: 86 25          LDA    #$07
8116: BD CC B2       JSR    queue_event_4e9a
8119: 39             RTS

811A: 96 E1          LDA    current_event_69
811C: 81 2A          CMPA   #$02
811E: 26 94          BNE    $813C
8120: 8E 10 E2       LDX    #$3260
8123: 6F A6          CLR    ,X
8125: B6 B6 65       LDA    $34E7
8128: 27 3A          BEQ    $813C
812A: 6C 0C          INC    ,X
812C: CC 64 D0       LDD    #$4C58
812F: ED 23          STD    $1,X
8131: C3 82 8D       ADDD   #$000F
8134: ED 26          STD    $4,X
8136: 7F B0 4B       CLR    $3263
8139: BD F7 47       JSR    $7FCF
813C: 39             RTS

813D: 96 E1          LDA    current_event_69
813F: 81 20          CMPA   #$02
8141: 26 CB          BNE    $818C
8143: 8E 10 42       LDX    #$3260
8146: 6D 06          TST    ,X
8148: 27 6A          BEQ    $818C
814A: 96 A1          LDA    $29
814C: 81 C8          CMPA   #$E0
814E: 27 92          BEQ    $816A
8150: 81 F2          CMPA   #$D0
8152: 27 94          BEQ    $816A
8154: 81 E2          CMPA   #$C0
8156: 27 90          BEQ    $816A
8158: 81 98          CMPA   #$B0
815A: 27 86          BEQ    $816A
815C: 81 B8          CMPA   #$90
815E: 27 82          BEQ    $816A
8160: 81 52          CMPA   #$70
8162: 27 8D          BEQ    $8173
8164: 81 23          CMPA   #$01
8166: 27 92          BEQ    $8178
8168: 20 0A          BRA    $818C
816A: 7C BA 4B       INC    $3263
816D: 8E BA E8       LDX    #$3260
8170: 7E 5D 4D       JMP    $7FCF
8173: 8E 10 41       LDX    #$3263
8176: 20 97          BRA    $818D
8178: 6F AC          CLR    ,X
817A: 6F 89          CLR    $1,X
817C: 6F 2A          CLR    $2,X
817E: 6F 8B          CLR    $3,X
8180: 6F 26          CLR    $4,X
8182: 6F 87          CLR    $5,X
8184: BD 5D 4D       JSR    $7FCF
8187: 8D 2C          BSR    $818D
8189: 17 77 E2       LBSR   $80F6
818C: 39             RTS

818D: CE BE A4       LDU    #$362C
8190: 10 8E 5A D8    LDY    #$D85A
8194: B6 16 64       LDA    $34E6
8197: 4A             DECA
8198: C6 2B          LDB    #$03
819A: 3D             MUL
819B: 31 83          LEAY   D,Y
819D: 7E 01 87       JMP    $890F
81A0: 0D 38          TST    $1A
81A2: 26 CF          BNE    $81F1
81A4: 8E 11 53       LDX    #$33D1
81A7: BD 7A 8B       JSR    $52A3
81AA: 0D E4          TST    $6C
81AC: 27 6A          BEQ    $81F0
81AE: 31 8E          LEAY   $6,X
81B0: 86 27          LDA    #$05
81B2: 34 B2          PSHS   Y,X
81B4: BD 84 43       JSR    $A6C1
81B7: 35 18          PULS   X,Y
81B9: 4D             TSTA
81BA: 26 BC          BNE    $81F0
81BC: 86 2A          LDA    #$02
81BE: 97 C0          STA    $48
81C0: A6 3D          LDA    -$1,X
81C2: 85 92          BITA   #$10
81C4: 26 20          BNE    $81C8
81C6: 8D DC          BSR    $8226
81C8: B6 1B 5E       LDA    $33D6
81CB: 0A 60          DEC    $48
81CD: 26 7B          BNE    $81C2
81CF: 86 20          LDA    #$02
81D1: 97 CA          STA    $48
81D3: 31 2E          LEAY   $C,X
81D5: 86 87          LDA    #$05
81D7: 34 18          PSHS   Y,X
81D9: BD 2E 49       JSR    $A6C1
81DC: 35 18          PULS   X,Y
81DE: 4D             TSTA
81DF: 26 2A          BNE    $81E9
81E1: A6 BD          LDA    -$1,Y
81E3: 85 32          BITA   #$10
81E5: 26 80          BNE    $81E9
81E7: 8D 15          BSR    $8226
81E9: 31 00 9A       LEAY   $12,X
81EC: 0A 60          DEC    $48
81EE: 26 6D          BNE    $81D5
81F0: 39             RTS

81F1: 8E B6 2A       LDX    #$34A8
81F4: BD 70 21       JSR    $52A3
81F7: 0D 44          TST    $6C
81F9: 27 A2          BEQ    $8225
81FB: 10 8E 1C 25    LDY    #$34AD
81FF: 86 27          LDA    #$05
8201: BD 24 43       JSR    $A6C1
8204: 4D             TSTA
8205: 26 9C          BNE    $8225
8207: 8E 19 25       LDX    #$310D
820A: CE BD 28       LDU    #$3500
820D: 0D 93          TST    $1B
820F: 27 21          BEQ    $8214
8211: CE B7 C2       LDU    #$3540
8214: C6 20          LDB    #$02
8216: 6D 06          TST    ,X
8218: 26 2A          BNE    $821C
821A: 6C C0          INC    $8,U
821C: 30 A0 E8       LEAX   $60,X
821F: 33 EA 02       LEAU   $20,U
8222: 5A             DECB
8223: 26 D3          BNE    $8216
8225: 39             RTS

8226: CE B7 20       LDU    #$3508
8229: 4A             DECA
822A: C6 A8          LDB    #$20
822C: 3D             MUL
822D: 6C 43          INC    D,U
822F: 39             RTS

8230: 6D A6          TST    ,X
8232: 27 79          BEQ    $822F
8234: CE FA BC       LDU    #$D83E
8237: 0D 32          TST    $1A
8239: 26 8F          BNE    $8242
823B: 8C 1A F8       CMPX   #$32D0
823E: 25 8A          BCS    $8242
8240: 33 64          LEAU   $6,U
8242: 96 D2          LDA    $50
8244: 48             ASLA
8245: 31 44          LEAY   A,U
8247: CE 1E 38       LDU    #$3610
824A: 96 D9          LDA    $51
824C: 48             ASLA
824D: 48             ASLA
824E: 33 4E          LEAU   A,U
8250: 7E AB C9       JMP    $894B
8253: 10 8E FA C8    LDY    #$D84A
8257: 0D 32          TST    $1A
8259: 26 85          BNE    $8268
825B: 8C 1A E8       CMPX   #$32C0
825E: 25 80          BCS    $8268
8260: 31 00          LEAY   $2,Y
8262: A6 83          LDA    $1,X
8264: 80 36          SUBA   #$14
8266: A7 83          STA    $1,X
8268: CE 1E 88       LDU    #$3600
826B: 96 61          LDA    $49
826D: 48             ASLA
826E: 48             ASLA
826F: 33 E4          LEAU   A,U
8271: 7E 0B C9       JMP    $894B
8274: CE FA FA       LDU    #$D878
8277: A6 AC          LDA    ,X
8279: 4A             DECA
827A: 4A             DECA
827B: 48             ASLA
827C: EE EE          LDU    A,U
827E: 96 34          LDA    $BC
8280: C6 28          LDB    #$0A
8282: BD 24 24       JSR    $A606
8285: C1 87          CMPB   #$05
8287: 25 2A          BCS    $828B
8289: C6 8C          LDB    #$04
828B: 86 2F          LDA    #$07
828D: 3D             MUL
828E: 31 43          LEAY   D,U
8290: BD A4 18       JSR    $869A
8293: 20 4A          BRA    $82FD
8295: 96 3E          LDA    $BC
8297: 44             LSRA
8298: 44             LSRA
8299: 44             LSRA
829A: CE 53 1C       LDU    #$DB34
829D: C6 8F          LDB    #$07
829F: 3D             MUL
82A0: 31 E9          LEAY   D,U
82A2: BD 04 B8       JSR    $869A
82A5: 20 D4          BRA    $82FD
82A7: CC F1 B0       LDD    #$D998
82AA: BD 0E B0       JSR    $8698
82AD: 20 C6          BRA    $82FD
82AF: CC FB D4       LDD    #$D9F6
82B2: BD 04 BA       JSR    $8698
82B5: 20 C4          BRA    $82FD
82B7: A6 AC          LDA    ,X
82B9: 81 89          CMPA   #$01
82BB: 27 07          BEQ    $82EC
82BD: 6A 8D          DEC    $5,X
82BF: 26 02          BNE    $82E1
82C1: 10 AE 89       LDY    $B,X
82C4: 31 05          LEAY   $7,Y
82C6: A6 26          LDA    ,Y
82C8: 81 D7          CMPA   #$FF
82CA: 26 8B          BNE    $82CF
82CC: 10 AE A9       LDY    $1,Y
82CF: 10 AF 29       STY    $B,X
82D2: A6 26          LDA    ,Y
82D4: 81 2D          CMPA   #$0F
82D6: 26 87          BNE    $82DD
82D8: 86 29          LDA    #$01
82DA: BD C6 9B       JSR    force_queue_sound_event_4eb3
82DD: 86 8E          LDA    #$06
82DF: A7 27          STA    $5,X
82E1: 10 AE 89       LDY    $B,X
82E4: CE 14 9E       LDU    #$361C
82E7: BD AE C6       JSR    $86EE
82EA: 20 99          BRA    $82FD
82EC: 10 AE 83       LDY    $B,X
82EF: CE 14 3E       LDU    #$361C
82F2: BD 04 CC       JSR    $86EE
82F5: 20 84          BRA    $82FD
82F7: CC F3 9A       LDD    #$DBB2
82FA: BD 0E B0       JSR    $8698
82FD: 34 98          PSHS   X
82FF: 8E 10 22       LDX    #$3200
8302: DC 23          LDD    $A1
8304: 27 00          BEQ    $8328
8306: 96 22          LDA    $A0
8308: 81 38          CMPA   #$10
830A: 27 AE          BEQ    $8332
830C: CE F0 6E       LDU    #$D8E6
830F: 96 4B          LDA    current_event_69
8311: C6 8E          LDB    #$0C
8313: 3D             MUL
8314: A6 E9          LDA    D,U
8316: 80 8A          SUBA   #$08
8318: D6 41          LDB    current_event_69
831A: C1 8E          CMPB   #$06
831C: 27 3F          BEQ    $8335
831E: C1 8A          CMPB   #$02
8320: 26 26          BNE    $8326
8322: 96 23          LDA    $A1
8324: 80 2B          SUBA   #$09
8326: D6 20          LDB    $A2
8328: ED 29          STD    $1,X
832A: 31 AC          LEAY   $4,Y
832C: CE 1E D0       LDU    #$3658
832F: BD AB 2D       JSR    $890F
8332: 35 92          PULS   X
8334: 39             RTS

8335: 0D 7D          TST    $FF
8337: 27 C5          BEQ    $8326
8339: 86 C0          LDA    #$48
833B: 20 C1          BRA    $8326
833D: 10 8E 56 32    LDY    #$DE10
8341: CE B4 EE       LDU    #$366C
8344: 7E AB C9       JMP    $894B
8347: 10 8E F6 B5    LDY    #$DE3D
834B: 20 24          BRA    $8359
834D: 10 8E 56 1F    LDY    #$DE3D
8351: 96 3E          LDA    $BC
8353: 27 26          BEQ    $8359
8355: 10 8E 5C 6C    LDY    #$DE44
8359: CE BE 94       LDU    #$361C
835C: BD AE 66       JSR    $86EE
835F: 20 BE          BRA    $82FD
8361: CE B4 9E       LDU    #$361C
8364: 86 24          LDA    #$06
8366: 97 E5          STA    $67
8368: BD AE 59       JSR    $86D1
836B: 20 B8          BRA    $82FD
836D: 96 28          LDA    $A0
836F: 81 32          CMPA   #$10
8371: 27 91          BEQ    $8386
8373: CE 14 3E       LDU    #$361C
8376: 86 92          LDA    #$10
8378: F6 1C 7C       LDB    $34F4
837B: C1 29          CMPB   #$01
837D: 26 8A          BNE    $8381
837F: 86 2A          LDA    #$08
8381: 97 E5          STA    $67
8383: BD A4 F3       JSR    $86D1
8386: 39             RTS

8387: 10 8E F6 9E    LDY    #$DE16
838B: A6 25          LDA    $D,X
838D: C6 8B          LDB    #$03
838F: 3D             MUL
8390: 31 89          LEAY   D,Y
8392: CE B4 5E       LDU    #$367C
8395: 7E 0A 1F       JMP    $889D
8398: 86 2C          LDA    #$04
839A: 97 EF          STA    $67
839C: 86 2E          LDA    #$06
839E: 97 C0          STA    $48
83A0: BD A4 33       JSR    $86B1
83A3: CE 14 0E       LDU    #$362C
83A6: 7E 05 D3       JMP    $87FB
83A9: 10 8E 56 26    LDY    #$DE0E
83AD: CE BE E8       LDU    #$3660
83B0: A6 2F          LDA    $D,X
83B2: 84 8D          ANDA   #$0F
83B4: 48             ASLA
83B5: 48             ASLA
83B6: 33 44          LEAU   A,U
83B8: 7E A1 C3       JMP    $894B
83BB: 6A 2D          DEC    $5,X
83BD: 26 C4          BNE    $840B
83BF: 10 AE 29       LDY    $B,X
83C2: 31 A6          LEAY   $4,Y
83C4: A6 86          LDA    ,Y
83C6: 81 7D          CMPA   #$FF
83C8: 26 2B          BNE    $83CD
83CA: 10 AE 09       LDY    $1,Y
83CD: 10 AF 83       STY    $B,X
83D0: A6 03          LDA    $1,Y
83D2: 81 9B          CMPA   #$19
83D4: 27 24          BEQ    $83DC
83D6: A6 A1          LDA    $3,Y
83D8: 81 31          CMPA   #$19
83DA: 26 92          BNE    $83F6
83DC: A6 AC          LDA    ,X
83DE: 81 8C          CMPA   #$04
83E0: 27 36          BEQ    $83F6
83E2: A6 0A 79       LDA    $5B,X
83E5: 81 86          CMPA   #$04
83E7: 27 25          BEQ    $83F6
83E9: 6C 00 DF       INC    $57,X
83EC: E6 A0 DF       LDB    $57,X
83EF: C1 26          CMPB   #$04
83F1: 26 81          BNE    $83F6
83F3: 6C AA 7A       INC    $58,X
83F6: A6 A3          LDA    $1,Y
83F8: 81 3A          CMPA   #$12
83FA: 27 8E          BEQ    $8402
83FC: A6 0B          LDA    $3,Y
83FE: 81 9A          CMPA   #$12
8400: 26 27          BNE    $8407
8402: 86 96          LDA    #$14
8404: BD 6C 31       JSR    force_queue_sound_event_4eb3
8407: 86 22          LDA    #$0A
8409: A7 8D          STA    $5,X
840B: 10 AE 23       LDY    $B,X
840E: 7E 0C F2       JMP    $84D0
8411: A6 0A D7       LDA    $55,X
8414: 27 08          BEQ    $8440
8416: 81 83          CMPA   #$01
8418: 27 53          BEQ    $8495
841A: CE 54 1B       LDU    #$DC33
841D: A6 0C          LDA    ,X
841F: 81 27          CMPA   #$05
8421: 25 81          BCS    $8426
8423: CE FE 61       LDU    #$DC43
8426: A6 0A 7E       LDA    $56,X
8429: 85 8F          BITA   #$07
842B: 26 22          BNE    $8437
842D: 86 3C          LDA    #$B4
842F: BD 6C 91       JSR    force_queue_sound_event_4eb3
8432: 86 7D          LDA    #$FF
8434: BD 6C 31       JSR    force_queue_sound_event_4eb3
8437: 84 20          ANDA   #$08
8439: 26 8A          BNE    $843D
843B: 33 6C          LEAU   $4,U
843D: 7E 0C 46       JMP    $84CE
8440: A6 A6          LDA    ,X
8442: 81 87          CMPA   #$05
8444: 25 36          BCS    $845A
8446: CE 5E 13       LDU    #$DC3B
8449: BD 0C 46       JSR    $84CE
844C: 6D 25          TST    $D,X
844E: 26 CC          BNE    $8494
8450: 8D 45          BSR    $84B9
8452: A6 80          LDA    $2,X
8454: 80 2A          SUBA   #$08
8456: A7 C0          STA    $2,U
8458: 20 39          BRA    $846B
845A: CE 54 03       LDU    #$DC2B
845D: 8D E7          BSR    $84CE
845F: 6D 2F          TST    $D,X
8461: 26 B3          BNE    $8494
8463: 8D 76          BSR    $84B9
8465: A6 80          LDA    $2,X
8467: 8B 30          ADDA   #$18
8469: A7 CA          STA    $2,U
846B: A6 29          LDA    $1,X
846D: 8B 84          ADDA   #$0C
846F: 34 32          PSHS   X
8471: 1F B3          TFR    U,X
8473: A7 23          STA    $1,X
8475: 10 8E 5E 52    LDY    #$DC7A
8479: 0D 92          TST    $1A
847B: 26 38          BNE    $848D
847D: 96 91          LDA    $19
847F: 81 20          CMPA   #$02
8481: 25 88          BCS    $848D
8483: 10 8E FE FF    LDY    #$DC7D
8487: A6 29          LDA    $1,X
8489: 80 90          SUBA   #$18
848B: A7 29          STA    $1,X
848D: 8D BC          BSR    $84C3
848F: BD AB 2D       JSR    $890F
8492: 35 92          PULS   X
8494: 39             RTS

8495: CE 5E AD       LDU    #$DC2F
8498: A6 AC          LDA    ,X
849A: 81 8D          CMPA   #$05
849C: 25 2B          BCS    $84A1
849E: CE 54 1D       LDU    #$DC3F
84A1: 8D A9          BSR    $84CE
84A3: 8D 36          BSR    $84B9
84A5: 34 92          PSHS   X
84A7: 1F 19          TFR    U,X
84A9: 6F 89          CLR    $1,X
84AB: 6F 2A          CLR    $2,X
84AD: 8D 9C          BSR    $84C3
84AF: 10 8E FE F8    LDY    #$DC7A
84B3: BD AB 2D       JSR    $890F
84B6: 35 92          PULS   X
84B8: 39             RTS

84B9: CE BC 88       LDU    #$3400
84BC: 96 31          LDA    $19
84BE: 48             ASLA
84BF: 48             ASLA
84C0: 33 E4          LEAU   A,U
84C2: 39             RTS

84C3: CE 14 42       LDU    #$3660
84C6: 96 9B          LDA    $19
84C8: 48             ASLA
84C9: 48             ASLA
84CA: 48             ASLA
84CB: 33 EE          LEAU   A,U
84CD: 39             RTS

84CE: 1F BA          TFR    U,Y
84D0: BD A4 24       JSR    $86A6
84D3: 7E A5 D9       JMP    $87FB
84D6: CE 59 91       LDU    #$DBB9
84D9: 20 7B          BRA    $84CE
84DB: CE F3 95       LDU    #$DBBD
84DE: 20 66          BRA    $84CE
84E0: CE F9 43       LDU    #$DBC1
84E3: 20 CB          BRA    $84CE
84E5: CE 59 47       LDU    #$DBC5
84E8: 20 CC          BRA    $84CE
84EA: CE 54 63       LDU    #$DC4B
84ED: 20 57          BRA    $84CE
84EF: A6 AA 3E       LDA    $1c,X
84F2: C6 88          LDB    #$0A
84F4: BD 84 84       JSR    $A606
84F7: C1 2B          CMPB   #$03
84F9: 25 8A          BCS    $84FD
84FB: C6 2A          LDB    #$02
84FD: 10 8E 54 3D    LDY    #$DC1F
8501: 58             ASLB
8502: 58             ASLB
8503: 31 87          LEAY   B,Y
8505: 20 4B          BRA    $84D0
8507: BD AE 8E       JSR    $86A6
850A: 7E 01 59       JMP    $8971
850D: A6 0C          LDA    ,X
850F: 81 32          CMPA   #$10
8511: 26 83          BNE    $8514
8513: 39             RTS

8514: BD A4 24       JSR    $86A6
8517: 86 38          LDA    #$10
8519: 97 EF          STA    $67
851B: 7E AF F3       JMP    $87DB
851E: CE BE 22       LDU    #$3600
8521: 96 9B          LDA    $19
8523: C6 2E          LDB    #$0C
8525: 3D             MUL
8526: 33 49          LEAU   D,U
8528: 10 8E 54 DD    LDY    #$DC55
852C: A6 09          LDA    $1,Y
852E: A7 CA          STA    $2,U
8530: A6 86          LDA    ,Y
8532: 7E 0A 14       JMP    $8836
8535: 10 8E 5E 67    LDY    #$DC4F
8539: 20 8C          BRA    $853F
853B: 10 8E F4 DA    LDY    #$DC52
853F: CE 14 42       LDU    #$3660
8542: 7E 0B 2D       JMP    $890F
8545: CE 5F B2       LDU    #$DD30
8548: 96 94          LDA    $BC
854A: C6 90          LDB    #$18
854C: BD 8E 8E       JSR    $A606
854F: C1 20          CMPB   #$02
8551: 25 80          BCS    $8555
8553: C6 20          LDB    #$02
8555: 86 85          LDA    #$07
8557: 3D             MUL
8558: 31 E3          LEAY   D,U
855A: BD 0E 88       JSR    $86A0
855D: 7E 0A 75       JMP    $82FD
8560: CE FF C7       LDU    #$DD45
8563: 96 9E          LDA    $BC
8565: C6 8E          LDB    #$0C
8567: BD 8E 2E       JSR    $A606
856A: 86 8F          LDA    #$07
856C: 3D             MUL
856D: 31 43          LEAY   D,U
856F: BD A4 82       JSR    $86A0
8572: BD 00 DF       JSR    $82FD
8575: CE 5F D8       LDU    #$DD5A
8578: 96 94          LDA    $BC
857A: C6 84          LDB    #$0C
857C: BD 8E 8E       JSR    $A606
857F: 31 E7          LEAY   B,U
8581: EC 83          LDD    $1,X
8583: 8B 02          ADDA   #$20
8585: DD D3          STD    $51
8587: CE 1E 04       LDU    #$362C
858A: 7E 01 7A       JMP    $8952
858D: CE 54 65       LDU    #$DCED
8590: 96 C4          LDA    $E6
8592: C6 8A          LDB    #$08
8594: 3D             MUL
8595: 31 49          LEAY   D,U
8597: CE 1E 34       LDU    #$361C
859A: BD 0F 9C       JSR    $87B4
859D: 7E 0A 75       JMP    $82FD
85A0: 10 8E 5F F0    LDY    #$DD72
85A4: CE 10 E2       LDU    #$3260
85A7: 0F 78          CLR    $50
85A9: DF D9          STU    $51
85AB: 9C 79          CMPX   $51
85AD: 27 8F          BEQ    $85B6
85AF: 0C 72          INC    $50
85B1: 33 4A A2       LEAU   $20,U
85B4: 20 D1          BRA    $85A9
85B6: CE B4 10       LDU    #$3638
85B9: 96 D8          LDA    $50
85BB: C6 20          LDB    #$08
85BD: 3D             MUL
85BE: 33 43          LEAU   D,U
85C0: 7E AA 1F       JMP    $889D
85C3: 10 8E FF E6    LDY    #$DD64
85C7: 20 22          BRA    $85D3
85C9: 10 8E 55 43    LDY    #$DD6B
85CD: 20 8C          BRA    $85D3
85CF: 10 8E FF DF    LDY    #$DD5D
85D3: BD A4 82       JSR    $86A0
85D6: 7E 00 D5       JMP    $82FD
85D9: CE 55 FD       LDU    #$DD75
85DC: 96 DD          LDA    $F5
85DE: 4A             DECA
85DF: C6 25          LDB    #$07
85E1: 3D             MUL
85E2: 31 49          LEAY   D,U
85E4: 20 CF          BRA    $85D3
85E6: 8E B2 88       LDX    #$30A0
85E9: CC C0 FF       LDD    #$4877
85EC: ED 29          STD    $1,X
85EE: 86 8A          LDA    #$02
85F0: 97 45          STA    $67
85F2: 86 92          LDA    #$10
85F4: 97 6A          STA    $48
85F6: BD 04 99       JSR    $86B1
85F9: CE BE A0       LDU    #$3628
85FC: 7E 87 9B       JMP    $AF13
85FF: 8E 16 02       LDX    #$3420
8602: 96 9B          LDA    $19
8604: C6 32          LDB    #$10
8606: 3D             MUL
8607: 30 A3          LEAX   D,X
8609: CE BE 88       LDU    #$3600
860C: A6 AC          LDA    ,X
860E: 10 27 22 53    LBEQ   $8683
8612: 10 8E FA 5C    LDY    #$D87E
8616: 0F CA          CLR    $48
8618: 96 31          LDA    $19
861A: D6 E3          LDB    $6B
861C: 27 2C          BEQ    $8622
861E: D6 92          LDB    $1A
8620: 27 26          BEQ    $8626
8622: 84 83          ANDA   #$01
8624: 20 20          BRA    $8628
8626: 0C CA          INC    $48
8628: C6 2F          LDB    #$07
862A: 3D             MUL
862B: 31 83          LEAY   D,Y
862D: EC 29          LDD    ,Y++
862F: ED 23          STD    $1,X
8631: 96 8D          LDA    $0F
8633: 85 32          BITA   #$10
8635: 27 87          BEQ    $863C
8637: BD AF B6       JSR    $879E
863A: 20 8B          BRA    $863F
863C: BD A1 3F       JSR    $89B7
863F: 33 EA 32       LEAU   $10,U
8642: 8E D8 F2       LDX    #$5AD0
8645: 96 9B          LDA    $19
8647: 44             LSRA
8648: 24 2B          BCC    $864D
864A: 8E D2 08       LDX    #$5A20
864D: 1F 98          TFR    X,D
864F: 8E 16 32       LDX    #$3410
8652: ED 83          STD    $1,X
8654: 10 8E 5C FB    LDY    #$DE79
8658: 96 31          LDA    $19
865A: C6 8B          LDB    #$03
865C: 3D             MUL
865D: 31 23          LEAY   D,Y
865F: 0D 6A          TST    $48
8661: 27 90          BEQ    $8675
8663: 96 3B          LDA    $19
8665: 84 80          ANDA   #$02
8667: 27 24          BEQ    $8675
8669: EC 89          LDD    $1,X
866B: 40             NEGA
866C: 80 38          SUBA   #$10
866E: 50             NEGB
866F: C0 32          SUBB   #$10
8671: ED 83          STD    $1,X
8673: 31 04          LEAY   $6,Y
8675: 96 8D          LDA    $0F
8677: 84 38          ANDA   #$10
8679: 27 8D          BEQ    $8680
867B: BD A1 27       JSR    $890F
867E: 20 8B          BRA    $8683
8680: BD AB 40       JSR    $89C2
8683: 8E 16 22       LDX    #$3400
8686: 33 CA          LEAU   $8,U
8688: 10 8E 56 B3    LDY    #$DE3B
868C: 96 27          LDA    $0F
868E: 84 98          ANDA   #$10
8690: 27 21          BEQ    $8695
8692: 7E 0B 69       JMP    $894B
8695: 7E 0B 4B       JMP    $89C9
8698: 1F 2A          TFR    D,Y
869A: CE BE 34       LDU    #$361C
869D: 7E 0E 66       JMP    $86EE
86A0: CE 14 9E       LDU    #$361C
86A3: 7E 9C 4F       JMP    $BE6D
86A6: CE B4 18       LDU    #$3630
86A9: 96 91          LDA    $19
86AB: C6 24          LDB    #$0C
86AD: 3D             MUL
86AE: 33 43          LEAU   D,U
86B0: 39             RTS

86B1: 10 AE 89       LDY    $B,X
86B4: A6 27          LDA    $5,X
86B6: 27 86          BEQ    $86BC
86B8: 6A 2D          DEC    $5,X
86BA: 20 9C          BRA    $86D0
86BC: 96 4F          LDA    $67
86BE: 31 2E          LEAY   A,Y
86C0: A6 86          LDA    ,Y
86C2: 81 7D          CMPA   #$FF
86C4: 26 21          BNE    $86C9
86C6: 10 AE 09       LDY    $1,Y
86C9: 96 C0          LDA    $48
86CB: A7 2D          STA    $5,X
86CD: 10 AF 83       STY    $B,X
86D0: 39             RTS

86D1: 10 AE 89       LDY    $B,X
86D4: A6 27          LDA    $5,X
86D6: 27 86          BEQ    $86DC
86D8: 6A 2D          DEC    $5,X
86DA: 20 9A          BRA    $86EE
86DC: 31 0F          LEAY   $7,Y
86DE: A6 2C          LDA    ,Y
86E0: 81 DD          CMPA   #$FF
86E2: 26 81          BNE    $86E7
86E4: 10 AE A3       LDY    $1,Y
86E7: 96 4F          LDA    $67
86E9: A7 8D          STA    $5,X
86EB: 10 AF 23       STY    $B,X
86EE: 96 8A          LDA    $02
86F0: 26 76          BNE    $8746
86F2: A6 26          LDA    ,Y
86F4: A7 60          STA    $2,U
86F6: A7 85          STA    $7,X
86F8: 86 68          LDA    #$40
86FA: 9A 91          ORA    $19
86FC: 4C             INCA
86FD: A7 4C          STA    ,U
86FF: A7 24          STA    $6,X
8701: EC 83          LDD    $1,X
8703: 10 27 20 32    LBEQ   $89B7
8707: 4C             INCA
8708: A7 69          STA    $1,U
870A: E7 CB          STB    $3,U
870C: A6 09          LDA    $1,Y
870E: A7 CE          STA    $6,U
8710: A7 2A          STA    $8,X
8712: A6 84          LDA    $6,X
8714: A7 66          STA    $4,U
8716: EC 83          LDD    $1,X
8718: 4C             INCA
8719: C0 98          SUBB   #$10
871B: A7 6D          STA    $5,U
871D: E7 CF          STB    $7,U
871F: A6 00          LDA    $2,Y
8721: A7 C8          STA    $A,U
8723: A7 2B          STA    $9,X
8725: A6 84          LDA    $6,X
8727: A7 60          STA    $8,U
8729: EC 89          LDD    $1,X
872B: 8B 39          ADDA   #$11
872D: A7 C1          STA    $9,U
872F: E7 69          STB    $B,U
8731: A6 A1          LDA    $3,Y
8733: A7 6C          STA    $E,U
8735: A7 88          STA    $A,X
8737: A6 2E          LDA    $6,X
8739: A7 C4          STA    $C,U
873B: EC 29          LDD    $1,X
873D: 8B 99          ADDA   #$11
873F: C0 32          SUBB   #$10
8741: A7 CF          STA    $D,U
8743: E7 6D          STB    $F,U
8745: 39             RTS

8746: A6 26          LDA    ,Y
8748: A7 6A          STA    $2,U
874A: A7 8F          STA    $7,X
874C: 86 28          LDA    #$00
874E: 9A 91          ORA    $19
8750: 4C             INCA
8751: A7 46          STA    ,U
8753: A7 24          STA    $6,X
8755: EC 83          LDD    $1,X
8757: 10 27 2A D4    LBEQ   $89B7
875B: 50             NEGB
875C: C0 38          SUBB   #$10
875E: 4A             DECA
875F: A7 63          STA    $1,U
8761: E7 C1          STB    $3,U
8763: A6 03          LDA    $1,Y
8765: A7 C4          STA    $6,U
8767: A7 20          STA    $8,X
8769: A6 8E          LDA    $6,X
876B: A7 6C          STA    $4,U
876D: EC 89          LDD    $1,X
876F: 50             NEGB
8770: 4A             DECA
8771: A7 C7          STA    $5,U
8773: E7 65          STB    $7,U
8775: A6 A0          LDA    $2,Y
8777: A7 62          STA    $A,U
8779: A7 81          STA    $9,X
877B: A6 2E          LDA    $6,X
877D: A7 C0          STA    $8,U
877F: EC 23          LDD    $1,X
8781: 50             NEGB
8782: 8B 8D          ADDA   #$0F
8784: C0 32          SUBB   #$10
8786: A7 CB          STA    $9,U
8788: E7 63          STB    $B,U
878A: A6 AB          LDA    $3,Y
878C: A7 66          STA    $E,U
878E: A7 82          STA    $A,X
8790: A6 24          LDA    $6,X
8792: A7 CE          STA    $C,U
8794: EC 23          LDD    $1,X
8796: 50             NEGB
8797: 8B 27          ADDA   #$0F
8799: A7 C5          STA    $D,U
879B: E7 67          STB    $F,U
879D: 39             RTS

879E: A6 28          LDA    ,Y+
87A0: BD AB 2B       JSR    $89A9
87A3: A7 E6          STA    ,U
87A5: A7 84          STA    $6,X
87A7: A6 8C          LDA    ,Y
87A9: A7 CA          STA    $2,U
87AB: 96 2A          LDA    $02
87AD: 26 8B          BNE    $87B2
87AF: 7E A5 23       JMP    $8701
87B2: 20 23          BRA    $8755
87B4: A6 82          LDA    ,Y+
87B6: 0D 80          TST    $02
87B8: 27 22          BEQ    $87C4
87BA: 85 C8          BITA   #$40
87BC: 27 2C          BEQ    $87C2
87BE: 84 37          ANDA   #$BF
87C0: 20 20          BRA    $87C4
87C2: 8A C2          ORA    #$40
87C4: 9A 3B          ORA    $19
87C6: 4C             INCA
87C7: A7 EC          STA    ,U
87C9: A7 8E          STA    $6,X
87CB: A6 8C          LDA    ,Y
87CD: A7 CA          STA    $2,U
87CF: A7 25          STA    $7,X
87D1: 96 80          LDA    $02
87D3: 26 21          BNE    $87D8
87D5: 7E 05 83       JMP    $8701
87D8: 7E AF DD       JMP    $8755
87DB: 10 AE 23       LDY    $B,X
87DE: A6 8D          LDA    $5,X
87E0: 27 26          BEQ    $87E6
87E2: 6A 87          DEC    $5,X
87E4: 20 37          BRA    $87FB
87E6: 31 A6          LEAY   $4,Y
87E8: A6 8C          LDA    ,Y
87EA: 81 77          CMPA   #$FF
87EC: 26 2B          BNE    $87F1
87EE: 10 AE 03       LDY    $1,Y
87F1: 96 E5          LDA    $67
87F3: A7 27          STA    $5,X
87F5: 10 AF 89       STY    $B,X
87F8: 10 AE 83       LDY    $B,X
87FB: A6 09          LDA    $1,Y
87FD: A7 CA          STA    $2,U
87FF: A7 25          STA    $7,X
8801: A6 26          LDA    ,Y
8803: BD AB 8B       JSR    $89A9
8806: 8C B0 68       CMPX   #$3240
8809: 27 A3          BEQ    $8836
880B: E6 25          LDB    $D,X
880D: 27 8C          BEQ    $8813
880F: 8A 2B          ORA    #$09
8811: 20 8D          BRA    $8822
8813: 9A 3B          ORA    $19
8815: D6 98          LDB    $1A
8817: 27 20          BEQ    $8821
8819: D6 93          LDB    $1B
881B: 27 2D          BEQ    $8822
881D: 8B 8A          ADDA   #$02
881F: 20 23          BRA    $8822
8821: 4C             INCA
8822: 0D 98          TST    $1A
8824: 26 32          BNE    $8836
8826: D6 9B          LDB    $19
8828: C1 2A          CMPB   #$02
882A: 25 82          BCS    $8836
882C: 85 A8          BITA   #$80
882E: 26 8C          BNE    $8834
8830: 8A A2          ORA    #$80
8832: 20 80          BRA    $8836
8834: 84 5D          ANDA   #$7F
8836: A7 46          STA    ,U
8838: A7 2E          STA    $6,X
883A: 96 8A          LDA    $02
883C: 26 06          BNE    $886C
883E: EC 89          LDD    $1,X
8840: 4C             INCA
8841: CB 92          ADDB   #$10
8843: A7 63          STA    $1,U
8845: E7 C1          STB    $3,U
8847: A6 0A          LDA    $2,Y
8849: A7 CE          STA    $6,U
884B: A7 20          STA    $8,X
884D: A6 8E          LDA    $6,X
884F: A7 66          STA    $4,U
8851: EC 83          LDD    $1,X
8853: 4C             INCA
8854: A7 67          STA    $5,U
8856: E7 C5          STB    $7,U
8858: A6 0B          LDA    $3,Y
885A: A7 C2          STA    $A,U
885C: A7 21          STA    $9,X
885E: A6 8E          LDA    $6,X
8860: A7 6A          STA    $8,U
8862: EC 83          LDD    $1,X
8864: 4C             INCA
8865: C0 92          SUBB   #$10
8867: A7 61          STA    $9,U
8869: E7 C3          STB    $B,U
886B: 39             RTS

886C: EC 29          LDD    $1,X
886E: 4A             DECA
886F: 50             NEGB
8870: C0 02          SUBB   #$20
8872: A7 C3          STA    $1,U
8874: E7 61          STB    $3,U
8876: A6 A0          LDA    $2,Y
8878: A7 6E          STA    $6,U
887A: A7 80          STA    $8,X
887C: A6 2E          LDA    $6,X
887E: A7 CC          STA    $4,U
8880: EC 23          LDD    $1,X
8882: 4A             DECA
8883: 50             NEGB
8884: C0 32          SUBB   #$10
8886: A7 C7          STA    $5,U
8888: E7 6F          STB    $7,U
888A: A6 AB          LDA    $3,Y
888C: A7 62          STA    $A,U
888E: A7 81          STA    $9,X
8890: A6 24          LDA    $6,X
8892: A7 CA          STA    $8,U
8894: EC 23          LDD    $1,X
8896: 4A             DECA
8897: 50             NEGB
8898: A7 61          STA    $9,U
889A: E7 C3          STB    $B,U
889C: 39             RTS

889D: A6 AA          LDA    $2,Y
889F: A7 64          STA    $6,U
88A1: 96 80          LDA    $02
88A3: 26 0D          BNE    $88D4
88A5: A6 26          LDA    ,Y
88A7: A7 6C          STA    $4,U
88A9: EC 89          LDD    $1,X
88AB: 10 27 29 9B    LBEQ   $89C2
88AF: 8B 32          ADDA   #$10
88B1: 11 83 B4 52    CMPU   #$3670
88B5: 24 83          BCC    $88B8
88B7: 4C             INCA
88B8: A7 6D          STA    $5,U
88BA: E7 CF          STB    $7,U
88BC: A6 09          LDA    $1,Y
88BE: A7 CA          STA    $2,U
88C0: A7 25          STA    $7,X
88C2: E6 26          LDB    ,Y
88C4: E7 E6          STB    ,U
88C6: EC 83          LDD    $1,X
88C8: 11 83 BE F8    CMPU   #$3670
88CC: 24 29          BCC    $88CF
88CE: 4C             INCA
88CF: A7 63          STA    $1,U
88D1: E7 C1          STB    $3,U
88D3: 39             RTS

88D4: A6 86          LDA    ,Y
88D6: BD 0B 81       JSR    $89A9
88D9: A7 CC          STA    $4,U
88DB: EC 29          LDD    $1,X
88DD: 10 27 88 C3    LBEQ   $89C2
88E1: 50             NEGB
88E2: 8B 92          ADDA   #$10
88E4: C0 32          SUBB   #$10
88E6: 11 83 1E 58    CMPU   #$3670
88EA: 24 89          BCC    $88ED
88EC: 4A             DECA
88ED: A7 CD          STA    $5,U
88EF: E7 65          STB    $7,U
88F1: A6 A3          LDA    $1,Y
88F3: A7 60          STA    $2,U
88F5: A7 85          STA    $7,X
88F7: A6 8C          LDA    ,Y
88F9: BD 01 21       JSR    $89A9
88FC: A7 EC          STA    ,U
88FE: EC 89          LDD    $1,X
8900: 50             NEGB
8901: C0 92          SUBB   #$10
8903: 11 83 14 F2    CMPU   #$3670
8907: 24 29          BCC    $890A
8909: 4A             DECA
890A: A7 C9          STA    $1,U
890C: E7 6B          STB    $3,U
890E: 39             RTS

890F: A6 00          LDA    $2,Y
8911: A7 C4          STA    $6,U
8913: 96 20          LDA    $02
8915: 26 9B          BNE    $8930
8917: A6 8C          LDA    ,Y
8919: A7 CC          STA    $4,U
891B: EC 29          LDD    $1,X
891D: 10 27 88 83    LBEQ   $89C2
8921: 11 83 B4 52    CMPU   #$3670
8925: 24 83          BCC    $8928
8927: 4C             INCA
8928: C0 38          SUBB   #$10
892A: A7 CD          STA    $5,U
892C: E7 6F          STB    $7,U
892E: 20 04          BRA    $88BC
8930: A6 86          LDA    ,Y
8932: BD 0B 8B       JSR    $89A9
8935: A7 C6          STA    $4,U
8937: EC 29          LDD    $1,X
8939: 10 27 88 AD    LBEQ   $89C2
893D: 11 83 BE 52    CMPU   #$3670
8941: 24 83          BCC    $8944
8943: 4A             DECA
8944: 50             NEGB
8945: A7 C7          STA    $5,U
8947: E7 6F          STB    $7,U
8949: 20 2E          BRA    $88F1
894B: 96 2A          LDA    $02
894D: 26 2A          BNE    $88F1
894F: 7E AA 9E       JMP    $88BC
8952: A6 26          LDA    ,Y
8954: A7 60          STA    $2,U
8956: 96 24          LDA    $A6
8958: A7 EC          STA    ,U
895A: 96 8A          LDA    $02
895C: 26 20          BNE    $8966
895E: DC D9          LDD    $51
8960: 4C             INCA
8961: A7 C3          STA    $1,U
8963: E7 61          STB    $3,U
8965: 39             RTS

8966: DC D3          LDD    $51
8968: 50             NEGB
8969: 4A             DECA
896A: C0 98          SUBB   #$10
896C: A7 69          STA    $1,U
896E: E7 CB          STB    $3,U
8970: 39             RTS

8971: 96 80          LDA    $02
8973: 26 38          BNE    $898F
8975: EC 83          LDD    $1,X
8977: 4C             INCA
8978: CB 38          ADDB   #$10
897A: A7 C9          STA    $1,U
897C: E7 6B          STB    $3,U
897E: EC 89          LDD    $1,X
8980: 4C             INCA
8981: A7 C7          STA    $5,U
8983: E7 65          STB    $7,U
8985: EC 83          LDD    $1,X
8987: 4C             INCA
8988: C0 38          SUBB   #$10
898A: A7 C1          STA    $9,U
898C: E7 63          STB    $B,U
898E: 39             RTS

898F: EC 23          LDD    $1,X
8991: 4A             DECA
8992: C0 A2          SUBB   #$20
8994: A7 63          STA    $1,U
8996: E7 C1          STB    $3,U
8998: EC 29          LDD    $1,X
899A: 4A             DECA
899B: C0 38          SUBB   #$10
899D: A7 CD          STA    $5,U
899F: E7 65          STB    $7,U
89A1: EC 83          LDD    $1,X
89A3: 4A             DECA
89A4: A7 6B          STA    $9,U
89A6: E7 C9          STB    $B,U
89A8: 39             RTS

89A9: D6 8A          LDB    $02
89AB: 27 2E          BEQ    $89B3
89AD: 85 C8          BITA   #$40
89AF: 26 21          BNE    $89B4
89B1: 8A C2          ORA    #$40
89B3: 39             RTS

89B4: 84 9D          ANDA   #$BF
89B6: 39             RTS

89B7: CC D7 28       LDD    #$FF00
89BA: A7 C5          STA    $D,U
89BC: E7 67          STB    $F,U
89BE: A7 C1          STA    $9,U
89C0: E7 69          STB    $B,U
89C2: CC 7D 22       LDD    #$FF00
89C5: A7 C7          STA    $5,U
89C7: E7 6F          STB    $7,U
89C9: CC 77 88       LDD    #$FF00
89CC: A7 69          STA    $1,U
89CE: E7 CB          STB    $3,U
89D0: 39             RTS

89D1: 8E B1 E2       LDX    #$3360
89D4: CE FA 26       LDU    #$D8A4
89D7: C6 24          LDB    #$0C
89D9: A6 08          LDA    ,X+
89DB: A1 E8          CMPA   ,U+
89DD: 26 8B          BNE    $89E2
89DF: 5A             DECB
89E0: 26 D5          BNE    $89D9
89E2: 39             RTS

89E3: 86 23          LDA    #$01
89E5: 97 CA          STA    $48
89E7: C6 2F          LDB    #$07
89E9: 96 9C          LDA    $14
89EB: 9A 3D          ORA    $15
89ED: 43             COMA
89EE: 94 9B          ANDA   $13
89F0: 44             LSRA
89F1: 25 95          BCS    $8A0A
89F3: 0C 6A          INC    $48
89F5: 5A             DECB
89F6: 26 7A          BNE    $89F0
89F8: C6 2F          LDB    #$07
89FA: 96 9F          LDA    $17
89FC: 9A 30          ORA    $18
89FE: 43             COMA
89FF: 94 34          ANDA   $16
8A01: 44             LSRA
8A02: 25 84          BCS    $8A0A
8A04: 0C 6A          INC    $48
8A06: 5A             DECB
8A07: 26 D0          BNE    $8A01
8A09: 39             RTS

8A0A: 8E 50 E7       LDX    #$D8CF
8A0D: 96 C0          LDA    $48
8A0F: F6 16 C6       LDB    $34E4
8A12: A1 07          CMPA   B,X
8A14: 26 31          BNE    $8A29
8A16: 7C B6 CC       INC    $34E4
8A19: B6 BC 6C       LDA    $34E4
8A1C: 81 26          CMPA   #$0E
8A1E: 26 80          BNE    $8A28
8A20: 86 23          LDA    #$01
8A22: B7 B6 C7       STA    $34E5
8A25: 7F B6 66       CLR    $34E4
8A28: 39             RTS

8A29: 7F BC 6C       CLR    $34E4
8A2C: 39             RTS

8A2D: 8E 50 12       LDX   #table_d89a
8A30: 96 04          LDA    $26
8A32: 48             ASLA
8A33: 6E B4          JMP    [A,X]        ; [jump_table]
8A35: 4F             CLRA
8A36: 5F             CLRB
8A37: DD 58          STD    $70
8A39: DD FA          STD    chrono_second_72
8A3B: FD 1C D9       STD    $34F1
8A3E: 0C AE          INC    $26
8A40: 39             RTS

8A41: BD 42 82       JSR    $C000
8A44: 96 53          LDA    chrono_hundredth_second_71
8A46: 81 90          CMPA   #$12
8A48: 27 33          BEQ    $8A65
8A4A: 96 9B          LDA    $13
8A4C: 84 7F          ANDA   #$57
8A4E: 81 DF          CMPA   #$57
8A50: 26 2F          BNE    $8A5F
8A52: BD D5 BD       JSR    $579F
8A55: B6 B6 70       LDA    $34F2
8A58: 81 2C          CMPA   #$04
8A5A: 26 8A          BNE    $8A5E
8A5C: 0C 0E          INC    $26
8A5E: 39             RTS

8A5F: 4F             CLRA
8A60: 5F             CLRB
8A61: FD B6 73       STD    $34F1
8A64: 39             RTS

8A65: 0C A2          INC    $20
8A67: 4F             CLRA
8A68: 5F             CLRB
8A69: DD AA          STD    $22
8A6B: DD 0C          STD    $24
8A6D: DD AE          STD    $26
8A6F: DD 0A          STD    event_sub_state_28
8A71: 39             RTS

8A72: 4F             CLRA
8A73: BD 6C B8       JSR    queue_event_4e9a
8A76: 86 80          LDA    #$02
8A78: 97 0F          STA    $27
8A7A: 0C AE          INC    $26
8A7C: 39             RTS

8A7D: 0A AF          DEC    $27
8A7F: 26 0E          BNE    $8AAD
8A81: 8E 5A 32       LDX    #$D8B0
8A84: CE 01 87       LDU    #$2305
8A87: 86 3E          LDA    #$16
8A89: 97 C0          STA    $48
8A8B: A6 A8          LDA    ,X+
8A8D: 80 83          SUBA   #$0B
8A8F: BD 60 0E       JSR    write_char_and_move_cursor_422c
8A92: 0A CA          DEC    $48
8A94: 26 D7          BNE    $8A8B
8A96: 8E 5A EE       LDX    #$D8C6
8A99: CE AC 98       LDU    #$2410
8A9C: 86 21          LDA    #$09
8A9E: 97 C0          STA    $48
8AA0: A6 A2          LDA    ,X+
8AA2: 80 94          SUBA   #$16
8AA4: BD 60 AE       JSR    write_char_and_move_cursor_422c
8AA7: 0A 60          DEC    $48
8AA9: 26 7D          BNE    $8AA0
8AAB: 0C 0E          INC    $26
8AAD: 39             RTS

8AAE: 39             RTS

skeet_shooting_8aaf:
8AAF: 96 0A          LDA    event_sub_state_28
8AB1: 48             ASLA
8AB2: 8E 6E C8       LDX   #table_ecea
8AB5: 6E 14          JMP    [A,X]        ; [jump_table]

8AB7: 8E 19 E8       LDX    #$31C0
8ABA: CC E8 A6       LDD    #$608E
8ABD: ED 89          STD    $1,X
8ABF: C6 40          LDB    #$62
8AC1: ED 89          STD    $B,X
8AC3: 86 20          LDA    #$02
8AC5: A7 87          STA    $5,X
8AC7: 86 23          LDA    #$0B
8AC9: A7 8E          STA    $6,X
8ACB: B7 19 F8       STA    $31D0
8ACE: BD 18 EE       JSR    $90CC
8AD1: 8E B2 15       LDX    #$3097
8AD4: 86 2B          LDA    #$09
8AD6: 6F 02          CLR    ,X+
8AD8: 4A             DECA
8AD9: 26 73          BNE    $8AD6
8ADB: 86 0F          LDA    #$27
8ADD: BD C6 3B       JSR    force_queue_sound_event_4eb3
8AE0: BD B2 F4       JSR    $9076
8AE3: 0C 0A          INC    event_sub_state_28
8AE5: 86 7D          LDA    #$FF
8AE7: D6 40          LDB    current_level_68
8AE9: 5A             DECB
8AEA: 4C             INCA
8AEB: C0 2F          SUBB   #$07
8AED: 2A 73          BPL    $8AEA
8AEF: 81 24          CMPA   #$06
8AF1: 25 80          BCS    $8AF5
8AF3: 86 27          LDA    #$05
8AF5: 97 72          STA    $F0
8AF7: CE 0A 28       LDU    #$2200
8AFA: 1F 01          TFR    A,B
8AFC: 5C             INCB
8AFD: E7 C9          STB    $1,U		; [video_address]
8AFF: 4D             TSTA
8B00: 27 21          BEQ    $8B05
8B02: 4C             INCA
8B03: 97 C5          STA    $E7
8B05: 97 69          STA    $EB
8B07: 8B 22          ADDA   #$0A
8B09: 97 60          STA    $E8
8B0B: 8E 1D 20       LDX    #$3508
8B0E: D6 91          LDB    $19
8B10: 3A             ABX
8B11: A6 06          LDA    ,X
8B13: D6 D2          LDB    $F0
8B15: C5 83          BITB   #$01
8B17: 27 20          BEQ    $8B21
8B19: 8B 8B          ADDA   #$03
8B1B: 81 2E          CMPA   #$06
8B1D: 25 8A          BCS    $8B21
8B1F: 80 24          SUBA   #$06
8B21: 1F 0B          TFR    A,B
8B23: CB 33          ADDB   #$11
8B25: E7 46          STB    ,U		; [video_address]
8B27: C6 27          LDB    #$0F
8B29: 3D             MUL
8B2A: 8E 64 DA       LDX    #$ECF2
8B2D: 30 03          LEAX   D,X
8B2F: 9F DE          STX    $FC
8B31: CC 87 87       LDD    #$0505
8B34: ED EB 8A 82    STD    $0800,U		; [video_address_word]
8B38: 8E 19 59       LDX    #$31D1
8B3B: 86 2A          LDA    #$02
8B3D: A7 08          STA    ,X+
8B3F: 86 20          LDA    #$02
8B41: A7 02          STA    ,X+
8B43: 97 C8          STA    $EA
8B45: 86 92          LDA    #$10
8B47: A7 A8          STA    ,X+
8B49: 86 B4          LDA    #$3C
8B4B: A7 A8          STA    ,X+
8B4D: 86 83          LDA    #$0B
8B4F: A7 A2          STA    ,X+
8B51: 86 D8          LDA    #$5A
8B53: 97 97          STA    $B5
8B55: 86 86          LDA    #$04
8B57: 0D D8          TST    $F0
8B59: 27 89          BEQ    $8B5C
8B5B: 4A             DECA
8B5C: 97 C9          STA    $E1
8B5E: 0F A7          CLR    $2F
8B60: 39             RTS

8B61: 0A 37          DEC    $B5
8B63: 27 25          BEQ    $8B6C
8B65: BD CD 08       JSR    $4F8A
8B68: A6 EC          LDA    ,U
8B6A: 27 84          BEQ    $8B78
8B6C: 0C 00          INC    event_sub_state_28
8B6E: CC 89 27       LDD    #$0105
8B71: 0D 82          TST    game_playing_00
8B73: 26 23          BNE    $8B76
8B75: 5F             CLRB
8B76: DD F2          STD    $70
8B78: 39             RTS

8B79: BD 27 27       JSR    $AFAF
8B7C: BD B8 FE       JSR    $9076
8B7F: 86 DD          LDA    #$FF
8B81: B7 B3 42       STA    $31C0
8B84: B7 13 48       STA    $31CA
8B87: 0F DB          CLR    $F3
8B89: 0F 7E          CLR    $F6
8B8B: 0F 05          CLR    $2D
8B8D: BD C7 29       JSR    $4FA1
8B90: 84 27          ANDA   #$05
8B92: 27 C1          BEQ    $8BD7
8B94: 1F AB          TFR    A,B
8B96: C4 86          ANDB   #$04
8B98: D7 F6          STB    $DE
8B9A: F6 B9 ED       LDB    shoot_ready_flag_31C5
8B9D: 27 A6          BEQ    $8BCD
8B9F: 81 27          CMPA   #$05
8BA1: 26 85          BNE    $8BAA
8BA3: 5A             DECB
8BA4: 26 26          BNE    $8BAA
8BA6: 84 83          ANDA   #$01
8BA8: 20 29          BRA    $8BAB
8BAA: 5A             DECB
8BAB: F7 19 ED       STB    shoot_ready_flag_31C5
8BAE: 97 A5          STA    $2D
8BB0: 86 21          LDA    #$03
8BB2: 97 AE          STA    $2C
8BB4: 4F             CLRA
8BB5: BD CC 2F       JSR    queue_sound_event_4ead
8BB8: 86 2C          LDA    #$04
8BBA: BD C6 85       JSR    queue_sound_event_4ead
8BBD: 86 8B          LDA    #$03
8BBF: BD 6C 8F       JSR    queue_sound_event_4ead
8BC2: 86 80          LDA    #$02
8BC4: BD 6C 2F       JSR    queue_sound_event_4ead
8BC7: 86 3C          LDA    #$14
8BC9: 97 6D          STA    $E5
8BCB: 20 22          BRA    $8BD7
8BCD: 86 E8          LDA    #$60
8BCF: BD 6C 91       JSR    force_queue_sound_event_4eb3
8BD2: 86 A0          LDA    #$22
8BD4: BD 6C 31       JSR    force_queue_sound_event_4eb3
8BD7: BD B8 E4       JSR    $90CC
8BDA: 0D 5F          TST    $D7
8BDC: 27 2B          BEQ    $8BE1
8BDE: 7E 1A 0E       JMP    $922C
8BE1: 0D 73          TST    $F1
8BE3: 26 05          BNE    $8C0C
8BE5: 0D AD          TST    $2F
8BE7: 27 2C          BEQ    $8BED
8BE9: 0A A7          DEC    $2F
8BEB: 20 37          BRA    $8C0C
8BED: 0A 61          DEC    $E9
8BEF: 8E 13 22       LDX    #$3100
8BF2: 6D 06          TST    ,X
8BF4: 27 28          BEQ    $8C00
8BF6: 30 0A 18       LEAX   $30,X
8BF9: 8C B9 18       CMPX   #$3190
8BFC: 22 26          BHI    $8C0C
8BFE: 20 7A          BRA    $8BF2
8C00: 86 2A          LDA    #$08
8C02: BD CC 91       JSR    force_queue_sound_event_4eb3
8C05: BD 0D 3A       JSR    $8FB8
8C08: 86 36          LDA    #$1E
8C0A: 97 A7          STA    $2F
8C0C: CE 1E C4       LDU    #$364C
8C0F: 8E 12 F2       LDX    #$30D0
8C12: 30 0A 12       LEAX   $30,X
8C15: 8C B3 12       CMPX   #$3190
8C18: 10 24 89 F0    LBCC   $8D94
8C1C: 6D AC          TST    ,X
8C1E: 27 7A          BEQ    $8C12
8C20: EC 2A          LDD    $8,X
8C22: FD B1 57       STD    $3375
8C25: EC 88          LDD    $A,X
8C27: FD 1B 52       STD    $337A
8C2A: EC 84          LDD    $C,X
8C2C: FD 1B F4       STD    $337C
8C2F: EC 2C          LDD    $E,X
8C31: FD B1 FC       STD    $337E
8C34: BD E2 A5       JSR    $C027
8C37: E7 A0 30       STB    $18,X
8C3A: EB 89          ADDB   $1,X
8C3C: E7 29          STB    $1,X
8C3E: 1F 01          TFR    A,B
8C40: EB 26          ADDB   $4,X
8C42: E7 86          STB    $4,X
8C44: E6 A6          LDB    ,X
8C46: C4 83          ANDB   #$01
8C48: 27 29          BEQ    $8C4B
8C4A: 40             NEGA
8C4B: AB 2A          ADDA   $2,X
8C4D: A7 8A          STA    $2,X
8C4F: A7 24          STA    $6,X
8C51: 81 7A          CMPA   #$F8
8C53: 22 26          BHI    $8C59
8C55: 81 87          CMPA   #$05
8C57: 24 2D          BCC    $8C5E
8C59: BD 19 0F       JSR    $9187
8C5C: 20 3C          BRA    $8C72
8C5E: FC BB 57       LDD    $3375
8C61: ED 8A          STD    $8,X
8C63: FC 11 58       LDD    $337A
8C66: ED 88          STD    $A,X
8C68: FC 1B F4       LDD    $337C
8C6B: ED 24          STD    $C,X
8C6D: FC BB F6       LDD    $337E
8C70: ED 2C          STD    $E,X
8C72: 33 C6          LEAU   $4,U
8C74: 10 8E 5E 0E    LDY    #$DC8C
8C78: A6 AC          LDA    ,X
8C7A: 2A 8F          BPL    $8C83
8C7C: 84 58          ANDA   #$70
8C7E: 44             LSRA
8C7F: 44             LSRA
8C80: 44             LSRA
8C81: 31 24          LEAY   A,Y
8C83: BD AB 69       JSR    $894B
8C86: A6 86          LDA    $4,X
8C88: A0 2B          SUBA   $3,X
8C8A: 25 8C          BCS    $8C90
8C8C: A7 2C          STA    $4,X
8C8E: 6C 8D          INC    $5,X
8C90: A6 23          LDA    $1,X
8C92: A1 87          CMPA   $5,X
8C94: 22 28          BHI    $8CA0
8C96: A7 87          STA    $5,X
8C98: BD B9 0F       JSR    $9187
8C9B: 86 27          LDA    #$0F
8C9D: BD C6 3B       JSR    force_queue_sound_event_4eb3
8CA0: 33 66          LEAU   $4,U
8CA2: 10 8E FE B4    LDY    #$DC96
8CA6: 30 86          LEAX   $4,X
8CA8: BD A1 C3       JSR    $894B
8CAB: 30 34          LEAX   -$4,X
8CAD: CC 77 28       LDD    #$FFA0
8CB0: DD 8C          STD    $AE
8CB2: BD 13 CE       JSR    $91EC
8CB5: 6D 0A 9A       TST    $18,X
8CB8: 2A 39          BPL    $8CCB
8CBA: CC 18 A0       LDD    #$9088
8CBD: DD 26          STD    $AE
8CBF: 5F             CLRB
8CC0: BD B3 6E       JSR    $91EC
8CC3: CC A2 5A       LDD    #$8078
8CC6: DD 2C          STD    $AE
8CC8: BD B9 64       JSR    $91EC
8CCB: 86 2A          LDA    #$02
8CCD: 97 A6          STA    $2E
8CCF: 0A 0C          DEC    $2E
8CD1: 10 2B 7D 1F    LBMI   $8C12
8CD5: 10 8E B3 E8    LDY    #$31C0
8CD9: 96 A6          LDA    $2E
8CDB: C6 22          LDB    #$0A
8CDD: 3D             MUL
8CDE: 31 2D          LEAY   B,Y
8CE0: 96 0F          LDA    $2D
8CE2: 10 27 22 A5    LBEQ   $8D6D
8CE6: D6 AC          LDB    $2E
8CE8: 27 2E          BEQ    $8CF0
8CEA: 85 8C          BITA   #$04
8CEC: 26 2E          BNE    $8CF4
8CEE: 20 F5          BRA    $8D6D
8CF0: 85 23          BITA   #$01
8CF2: 27 FB          BEQ    $8D6D
8CF4: BD B3 45       JSR    $91C7
8CF7: 0D CE          TST    $E6
8CF9: 27 FA          BEQ    $8D6D
8CFB: 0A C2          DEC    $EA
8CFD: 26 98          BNE    $8D0F
8CFF: B6 13 F0       LDA    $31D2
8D02: 97 68          STA    $EA
8D04: B6 13 51       LDA    $31D3
8D07: B1 19 EE       CMPA   $31C6
8D0A: 23 8B          BLS    $8D0F
8D0C: 7C 19 4E       INC    $31C6
8D0F: 0C D1          INC    $F3
8D11: 0C 74          INC    $F6
8D13: 0C DD          INC    $FF
8D15: EC A3          LDD    $1,Y
8D17: DD DF          STD    $F7
8D19: 7C B9 4D       INC    shoot_ready_flag_31C5
8D1C: 6D AC          TST    ,X
8D1E: 2A 81          BPL    $8D29
8D20: C6 20          LDB    #$02
8D22: 0D 56          TST    $D4
8D24: 27 23          BEQ    $8D27
8D26: 5C             INCB
8D27: D7 FE          STB    $D6
8D29: BD 19 24       JSR    $91AC
8D2C: 96 FD          LDA    $D5
8D2E: 27 A0          BEQ    $8D58
8D30: 84 92          ANDA   #$B0
8D32: 81 32          CMPA   #$B0
8D34: 26 00          BNE    $8D58
8D36: 0D 7C          TST    $FE
8D38: 26 36          BNE    $8D58
8D3A: B6 B9 28       LDA    $3100
8D3D: BA B9 B8       ORA    $3130
8D40: BA 13 E2       ORA    $3160
8D43: 26 33          BNE    $8D56
8D45: 0C 54          INC    $D6
8D47: 96 05          LDA    $2D
8D49: 84 89          ANDA   #$01
8D4B: 9B FD          ADDA   $D5
8D4D: 85 89          BITA   #$01
8D4F: 27 21          BEQ    $8D54
8D51: BD 10 8B       JSR    $9209
8D54: 20 20          BRA    $8D58
8D56: 0F 54          CLR    $D6
8D58: 96 C3          LDA    $EB
8D5A: 91 60          CMPA   $E8
8D5C: 24 27          BCC    $8D6D
8D5E: 0A 69          DEC    $E1
8D60: 26 29          BNE    $8D6D
8D62: 86 86          LDA    #$04
8D64: 0D D2          TST    $F0
8D66: 27 83          BEQ    $8D69
8D68: 4A             DECA
8D69: 97 69          STA    $E1
8D6B: 0C C3          INC    $EB
8D6D: BD 19 4F       JSR    $91C7
8D70: 0D C4          TST    $E6
8D72: 27 86          BEQ    $8D78
8D74: 6F 86          CLR    ,Y
8D76: 20 8D          BRA    $8D87
8D78: A6 2A          LDA    $2,X
8D7A: 8B 8E          ADDA   #$06
8D7C: A0 0A          SUBA   $2,Y
8D7E: 22 89          BHI    $8D81
8D80: 40             NEGA
8D81: A1 26          CMPA   ,Y
8D83: 22 2E          BHI    $8D91
8D85: A7 26          STA    ,Y
8D87: 96 CC          LDA    $E4
8D89: 44             LSRA
8D8A: 40             NEGA
8D8B: 8B 2A          ADDA   #$02
8D8D: AB 89          ADDA   $1,X
8D8F: A7 01          STA    $3,Y
8D91: 7E 0E 4D       JMP    $8CCF
8D94: 0D 0F          TST    $2D
8D96: 27 ED          BEQ    $8E07
8D98: 96 DB          LDA    $F3
8D9A: 27 E3          BEQ    $8E07
8D9C: C6 29          LDB    #$01
8D9E: 81 89          CMPA   #$01
8DA0: 27 23          BEQ    $8DA3
8DA2: 5C             INCB
8DA3: 0D F5          TST    $D7
8DA5: 27 80          BEQ    $8DA9
8DA7: C6 2B          LDB    #$03
8DA9: 0D 5E          TST    $D6
8DAB: 27 0D          BEQ    $8DD2
8DAD: D6 5E          LDB    $D6
8DAF: C1 26          CMPB   #$04
8DB1: 27 8F          BEQ    $8DC0
8DB3: D6 D2          LDB    $F0
8DB5: C1 84          CMPB   #$06
8DB7: 25 2A          BCS    $8DBB
8DB9: C6 8D          LDB    #$05
8DBB: 58             ASLB
8DBC: DB FE          ADDB   $D6
8DBE: 20 98          BRA    $8DD0
8DC0: C6 23          LDB    #$01
8DC2: 0D 7C          TST    $FE
8DC4: 26 28          BNE    $8DD0
8DC6: 8E B7 60       LDX    #$3548
8DC9: D6 91          LDB    $19
8DCB: 3A             ABX
8DCC: E6 AC          LDB    ,X
8DCE: CB 86          ADDB   #$0E
8DD0: 0F F4          CLR    $D6
8DD2: D7 46          STB    $C4
8DD4: 58             ASLB
8DD5: 8E 6F C8       LDX    #$ED4A
8DD8: 3A             ABX
8DD9: A6 89          LDA    $1,X
8DDB: 9B B1          ADDA   $99
8DDD: 19             DAA
8DDE: 97 11          STA    $99
8DE0: A6 A6          LDA    ,X
8DE2: 99 1A          ADCA   $98
8DE4: 19             DAA
8DE5: 97 1A          STA    $98
8DE7: 86 2C          LDA    #$04
8DE9: 97 C0          STA    $48
8DEB: 8E 19 38       LDX    #$3110
8DEE: 6D 98          TST    -$10,X
8DF0: 27 2C          BEQ    $8E00
8DF2: A6 83          LDA    $1,X
8DF4: 81 2B          CMPA   #$09
8DF6: 27 86          BEQ    $8DFC
8DF8: 6C 29          INC    $1,X
8DFA: 20 8C          BRA    $8E00
8DFC: 6F 29          CLR    $1,X
8DFE: 6C 0C          INC    ,X
8E00: 30 AA B2       LEAX   $30,X
8E03: 0A 6A          DEC    $48
8E05: 26 65          BNE    $8DEE
8E07: B6 19 EB       LDA    $31C3
8E0A: B7 B9 E9       STA    $31C1
8E0D: B6 B9 45       LDA    $31CD
8E10: B7 13 49       STA    $31CB
8E13: 7D 13 E6       TST    $31C4
8E16: 27 98          BEQ    $8E32
8E18: 7A 19 4C       DEC    $31C4
8E1B: 26 3D          BNE    $8E32
8E1D: F6 B9 5C       LDB    $31D4
8E20: F7 13 46       STB    $31C4
8E23: B6 13 E7       LDA    shoot_ready_flag_31C5
8E26: 4C             INCA
8E27: 81 2B          CMPA   #$03
8E29: 26 8C          BNE    $8E2F
8E2B: 4A             DECA
8E2C: 7F 19 4C       CLR    $31C4
8E2F: B7 13 E7       STA    shoot_ready_flag_31C5
8E32: 0D 74          TST    $F6
8E34: 27 1A          BEQ    $8E6E
8E36: 86 85          LDA    #$07
8E38: 9E DF          LDX    $F7
8E3A: BF B9 D9       STX    $31F1
8E3D: CE B9 72       LDU    #$31FA
8E40: AF E3          STX    ,U++
8E42: 4A             DECA
8E43: 26 D9          BNE    $8E40
8E45: 86 9C          LDA    #$1E
8E47: 97 D2          STA    $FA
8E49: 4F             CLRA
8E4A: 5F             CLRB
8E4B: FD 19 DE       STD    $31F6
8E4E: FD B9 DA       STD    $31F8
8E51: 0D 55          TST    $D7
8E53: 27 2E          BEQ    $8E61
8E55: 86 32          LDA    #$B0
8E57: BD 66 9B       JSR    force_queue_sound_event_4eb3
8E5A: 86 77          LDA    #$FF
8E5C: BD 66 3B       JSR    force_queue_sound_event_4eb3
8E5F: 20 2F          BRA    $8E6E
8E61: BD CC 2F       JSR    queue_sound_event_4ead
8E64: 86 32          LDA    #$10
8E66: BD CC 85       JSR    queue_sound_event_4ead
8E69: 86 86          LDA    #$0E
8E6B: BD 66 85       JSR    queue_sound_event_4ead
8E6E: 0D 72          TST    $FA
8E70: 27 20          BEQ    $8E74
8E72: 0A 78          DEC    $FA
8E74: 10 27 82 23    LBEQ   $8F19
8E78: 96 EC          LDA    $C4
8E7A: 4A             DECA
8E7B: 48             ASLA
8E7C: 10 8E 54 28    LDY    #$DCA0
8E80: 31 84          LEAY   A,Y
8E82: 8E B2 82       LDX    #$30A0
8E85: FC B3 73       LDD    $31F1
8E88: ED 29          STD    $1,X
8E8A: CE BE 28       LDU    #$3600
8E8D: 96 4C          LDA    $C4
8E8F: 81 2C          CMPA   #$0E
8E91: 25 8A          BCS    $8E9B
8E93: CE 14 6E       LDU    #$364C
8E96: BD 22 30       JSR    $A018
8E99: 20 8B          BRA    $8E9E
8E9B: BD A1 63       JSR    $894B
8E9E: 8E B9 D8       LDX    #$31FA
8EA1: A6 83          LDA    $1,X
8EA3: 8B 26          ADDA   #$04
8EA5: 24 88          BCC    $8EB1
8EA7: 6F AC          CLR    ,X
8EA9: 6F 89          CLR    $1,X
8EAB: 86 D6          LDA    #$FE
8EAD: A7 94          STA    -$4,X
8EAF: 20 20          BRA    $8EB3
8EB1: A7 83          STA    $1,X
8EB3: A7 21          STA    $3,X
8EB5: A7 8D          STA    $F,X
8EB7: 6D 35          TST    -$3,X
8EB9: 26 86          BNE    $8EC9
8EBB: A6 2A          LDA    $2,X
8EBD: 8B 8C          ADDA   #$04
8EBF: 24 20          BCC    $8EC3
8EC1: 6C 9F          INC    -$3,X
8EC3: A7 20          STA    $2,X
8EC5: A7 86          STA    $4,X
8EC7: A7 2E          STA    $6,X
8EC9: 6D 96          TST    -$2,X
8ECB: 26 3E          BNE    $8EE3
8ECD: A6 8F          LDA    $7,X
8ECF: 80 26          SUBA   #$04
8ED1: 24 88          BCC    $8EDD
8ED3: 6F 2A          CLR    $8,X
8ED5: 6F 8B          CLR    $9,X
8ED7: 86 29          LDA    #$01
8ED9: A7 96          STA    -$2,X
8EDB: 20 2A          BRA    $8EDF
8EDD: A7 81          STA    $9,X
8EDF: A7 25          STA    $7,X
8EE1: A7 89          STA    $B,X
8EE3: 6D 3D          TST    -$1,X
8EE5: 26 94          BNE    $8EFD
8EE7: A6 22          LDA    $A,X
8EE9: 80 8C          SUBA   #$04
8EEB: 81 48          CMPA   #$60
8EED: 22 80          BHI    $8EF7
8EEF: 6F 2E          CLR    $C,X
8EF1: 6F 8F          CLR    $D,X
8EF3: 6C 3D          INC    -$1,X
8EF5: 20 80          BRA    $8EF9
8EF7: A7 24          STA    $C,X
8EF9: A7 82          STA    $A,X
8EFB: A7 26          STA    $E,X
8EFD: 10 8E 54 B6    LDY    #$DC94
8F01: 86 8A          LDA    #$08
8F03: 97 09          STA    $2B
8F05: 30 8D          LEAX   $F,X
8F07: CE 1E 40       LDU    #$3668
8F0A: EC 99          LDD    -$F,X
8F0C: ED 29          STD    $1,X
8F0E: BD 01 69       JSR    $894B
8F11: 30 80          LEAX   $2,X
8F13: 33 66          LEAU   $4,U
8F15: 0A A9          DEC    $2B
8F17: 26 D9          BNE    $8F0A
8F19: 0D 79          TST    $F1
8F1B: 26 04          BNE    $8F49
8F1D: 0A FB          DEC    $73
8F1F: 2A 0A          BPL    $8F49
8F21: 86 87          LDA    #$05
8F23: 97 51          STA    $73
8F25: 0A F0          DEC    chrono_second_72
8F27: 2A 08          BPL    $8F49
8F29: 0D F9          TST    chrono_hundredth_second_71
8F2B: 27 20          BEQ    $8F35
8F2D: 0A F9          DEC    chrono_hundredth_second_71
8F2F: 86 2B          LDA    #$09
8F31: 97 F0          STA    chrono_second_72
8F33: 20 36          BRA    $8F49
8F35: 0D F2          TST    $70
8F37: 26 20          BNE    $8F41
8F39: 0F FA          CLR    chrono_second_72
8F3B: 0F 5B          CLR    $73
8F3D: 0C 79          INC    $F1
8F3F: 20 2A          BRA    $8F49
8F41: 0A F2          DEC    $70
8F43: 86 2B          LDA    #$09
8F45: 97 F3          STA    chrono_hundredth_second_71
8F47: 97 5A          STA    chrono_second_72
8F49: 0D 79          TST    $F1
8F4B: 27 27          BEQ    $8F5C
8F4D: B6 B9 88       LDA    $3100
8F50: BA 13 B2       ORA    $3130
8F53: BA 13 42       ORA    $3160
8F56: 9A 78          ORA    $FA
8F58: 26 2A          BNE    $8F5C
8F5A: 0C A0          INC    event_sub_state_28
8F5C: 0D FF          TST    $D7
8F5E: 26 8E          BNE    $8F66
8F60: 96 E6          LDA    $C4
8F62: 81 8C          CMPA   #$0E
8F64: 25 24          BCS    $8F6C
8F66: CE B4 64       LDU    #$364C
8F69: BD 28 90       JSR    $A018
8F6C: B6 19 4D       LDA    shoot_ready_flag_31C5
8F6F: 81 20          CMPA   #$02
8F71: 27 89          BEQ    $8F7E
8F73: 7D 13 E6       TST    $31C4
8F76: 26 84          BNE    $8F7E
8F78: B6 19 5C       LDA    $31D4
8F7B: B7 19 EC       STA    $31C4
8F7E: 39             RTS

8F7F: 0F 0E          CLR    $2C
8F81: BD 2D 2D       JSR    $AFAF
8F84: BD B3 BC       JSR    $913E
8F87: BD B8 5E       JSR    $9076
8F8A: 96 4C          LDA    $C4
8F8C: 81 26          CMPA   #$0E
8F8E: 25 8B          BCS    $8F93
8F90: BD 82 9A       JSR    $A018
8F93: BD 5D 28       JSR    $7F0A
8F96: BD D6 4E       JSR    $5466
8F99: 8E BD 80       LDX    #$3508
8F9C: D6 31          LDB    $19
8F9E: 3A             ABX
8F9F: 96 DC          LDA    $FE
8FA1: 26 85          BNE    $8FAA
8FA3: 6C A6          INC    ,X
8FA5: 6C 0A C2       INC    $40,X
8FA8: 20 2B          BRA    $8FAD
8FAA: 6F 00 68       CLR    $40,X
8FAD: 0C AE          INC    $26
8FAF: 86 2A          LDA    #$08
8FB1: 8E B2 AA       LDX    #$3028
8FB4: 7E B4 69       JMP    $96EB
8FB7: 39             RTS

8FB8: 0C D3          INC    $FB
8FBA: 96 63          LDA    $EB
8FBC: C6 38          LDB    #$10
8FBE: 3D             MUL
8FBF: CE CF 4E       LDU    #$ED6C
8FC2: 33 49          LEAU   D,U
8FC4: 10 9E 7E       LDY    $FC
8FC7: 96 F0          LDA    $D8
8FC9: 84 89          ANDA   #$01
8FCB: 27 21          BEQ    $8FD6
8FCD: 31 A9          LEAY   $1,Y
8FCF: 10 9F DE       STY    $FC
8FD2: 10 8E 12 FB    LDY    #$30D9
8FD6: 0C 5A          INC    $D8
8FD8: A6 8C          LDA    ,Y
8FDA: 84 8B          ANDA   #$03
8FDC: C6 2C          LDB    #$04
8FDE: 3D             MUL
8FDF: 33 E7          LEAU   B,U
8FE1: A6 42          LDA    ,U+
8FE3: 1F AB          TFR    A,B
8FE5: 44             LSRA
8FE6: 44             LSRA
8FE7: 44             LSRA
8FE8: 44             LSRA
8FE9: C4 87          ANDB   #$0F
8FEB: ED A0 38       STD    $10,X
8FEE: 6F 00 30       CLR    $12,X
8FF1: 6F 0A 91       CLR    $13,X
8FF4: A6 E2          LDA    ,U+
8FF6: A7 0A 0C       STA    $24,X
8FF9: A6 48          LDA    ,U+
8FFB: C6 3D          LDB    #$15
8FFD: ED 80          STD    $8,X
8FFF: A6 E6          LDA    ,U
9001: A7 81          STA    $3,X
9003: 86 3C          LDA    #$1E
9005: 0D 6F          TST    $ED
9007: 26 2A          BNE    $900B
9009: 86 B4          LDA    #$3C
900B: 97 07          STA    $2F
900D: 0C 65          INC    $ED
900F: A6 86          LDA    ,Y
9011: 44             LSRA
9012: 44             LSRA
9013: 44             LSRA
9014: 1F AB          TFR    A,B
9016: 54             LSRB
9017: D7 F1          STB    $D9
9019: 84 89          ANDA   #$01
901B: 8A 2A          ORA    #$02
901D: D6 77          LDB    $FF
901F: C1 25          CMPB   #$07
9021: 25 B6          BCS    $9057
9023: D6 D9          LDB    $FB
9025: C1 88          CMPB   #$0A
9027: 25 06          BCS    $9057
9029: 0D 5B          TST    $D3
902B: 26 2C          BNE    $9031
902D: 0C 5B          INC    $D3
902F: 8A B2          ORA    #$90
9031: D6 7D          LDB    $FF
9033: C1 33          CMPB   #$11
9035: 25 A2          BCS    $9057
9037: D6 D3          LDB    $FB
9039: C1 9C          CMPB   #$14
903B: 25 32          BCS    $9057
903D: 0D 5C          TST    $D4
903F: 26 26          BNE    $9045
9041: 0C 56          INC    $D4
9043: 8A 82          ORA    #$A0
9045: A7 06          STA    ,X
9047: D6 D3          LDB    $FB
9049: C1 96          CMPB   #$1E
904B: 26 22          BNE    $9057
904D: 0D 76          TST    $FE
904F: 26 24          BNE    $9057
9051: 0C 57          INC    $D5
9053: A6 A6          LDA    ,X
9055: 8A 32          ORA    #$B0
9057: A7 AC          STA    ,X
9059: C6 98          LDB    #$10
905B: A6 AC          LDA    ,X
905D: 85 89          BITA   #$01
905F: 27 20          BEQ    $9063
9061: C6 72          LDB    #$F0
9063: E7 20          STB    $2,X
9065: E7 84          STB    $6,X
9067: C6 76          LDB    #$5E
9069: 85 89          BITA   #$01
906B: 27 2A          BEQ    $906F
906D: C0 8D          SUBB   #$05
906F: E7 23          STB    $1,X
9071: C0 92          SUBB   #$10
9073: E7 27          STB    $5,X
9075: 39             RTS

9076: 8E A7 BC       LDX    #$2594
9079: CE B8 F8       LDU    #$3070
907C: 86 2A          LDA    #$02
907E: 97 C1          STA    $49
9080: 86 20          LDA    #$02
9082: 97 CA          STA    $48
9084: 4F             CLRA
9085: BD 23 5D       JSR    $A1DF
9088: 30 29          LEAX   $1,X
908A: 0A C1          DEC    $49
908C: 26 DA          BNE    $9080
908E: 0D 88          TST    game_playing_00
9090: 27 1B          BEQ    $90CB
9092: C6 80          LDB    #$02
9094: 8E 12 1A       LDX    #$3098
9097: CE 18 B3       LDU    #$309B
909A: A6 0C          LDA    ,X
909C: 44             LSRA
909D: 44             LSRA
909E: 44             LSRA
909F: 44             LSRA
90A0: A7 E2          STA    ,U+
90A2: A6 02          LDA    ,X+
90A4: 84 2D          ANDA   #$0F
90A6: A7 42          STA    ,U+
90A8: 5A             DECB
90A9: 26 67          BNE    $909A
90AB: 8E 0E B2       LDX    #$269A
90AE: 96 E2          LDA    $6A
90B0: C6 62          LDB    #$40
90B2: 3D             MUL
90B3: 3A             ABX
90B4: CE 12 19       LDU    #$309B
90B7: C6 2D          LDB    #$05
90B9: 0F D8          CLR    $50
90BB: A6 E8          LDA    ,U+
90BD: BD 1D E4       JSR    $956C
90C0: 6F AB 8A 82    CLR    $0800,X					;  [video_address]
90C4: A7 A2          STA    ,X+					;  [video_address]
90C6: 5A             DECB
90C7: 26 DA          BNE    $90BB
90C9: 6F 97          CLR    -$1,X					;  [video_address]
90CB: 39             RTS

90CC: 86 29          LDA    #$01
90CE: 97 A6          STA    $2E
90D0: CE 14 8E       LDU    #$360C
90D3: 96 0C          LDA    $2E
90D5: C6 88          LDB    #$0A
90D7: 3D             MUL
90D8: 8E 19 48       LDX    #$31C0
90DB: 3A             ABX
90DC: B6 19 4E       LDA    $31C6
90DF: 97 C6          STA    $E4
90E1: EC 83          LDD    $1,X
90E3: DD 83          STD    $A1
90E5: 8E B2 22       LDX    #$30A0
90E8: 10 8E 54 14    LDY    #$DC9C
90EC: 7D 19 4D       TST    shoot_ready_flag_31C5
90EF: 26 26          BNE    $90F5
90F1: 10 8E 5E B8    LDY    #$DC9A
90F5: BD 0B C9       JSR    $894B
90F8: 33 6C          LEAU   $4,U
90FA: A6 8A          LDA    $2,X
90FC: 9B CC          ADDA   $E4
90FE: 80 98          SUBA   #$10
9100: A7 20          STA    $2,X
9102: BD 0B 69       JSR    $894B
9105: A6 46          LDA    ,U
9107: 88 68          EORA   #$40
9109: A7 4C          STA    ,U
910B: A6 29          LDA    $1,X
910D: 80 98          SUBA   #$10
910F: A7 23          STA    $1,X
9111: 33 C6          LEAU   $4,U
9113: A6 23          LDA    $1,X
9115: 9B 66          ADDA   $E4
9117: A7 29          STA    $1,X
9119: BD 01 C3       JSR    $894B
911C: A6 EC          LDA    ,U
911E: 88 48          EORA   #$C0
9120: A7 E6          STA    ,U
9122: 33 C6          LEAU   $4,U
9124: A6 20          LDA    $2,X
9126: 90 66          SUBA   $E4
9128: 8B 38          ADDA   #$10
912A: A7 8A          STA    $2,X
912C: BD A1 C3       JSR    $894B
912F: A6 E6          LDA    ,U
9131: 88 02          EORA   #$80
9133: A7 E6          STA    ,U
9135: 33 C6          LEAU   $4,U
9137: 0A 06          DEC    $2E
9139: 2B 8B          BMI    $913E
913B: 7E B8 FB       JMP    $90D3
913E: 8E B8 82       LDX    #$30A0
9141: CE B4 AE       LDU    #$362C
9144: CC 62 02       LDD    #$4080
9147: ED 29          STD    $1,X
9149: 10 8E 54 A8    LDY    #$DC80
914D: 96 A0          LDA    event_sub_state_28
914F: 81 21          CMPA   #$03
9151: 27 8D          BEQ    $9162
9153: 0D C7          TST    $E5
9155: 27 89          BEQ    $9162
9157: C6 2C          LDB    #$04
9159: 0D 56          TST    $DE
915B: 27 29          BEQ    $915E
915D: 58             ASLB
915E: 0A 6D          DEC    $E5
9160: 31 87          LEAY   B,Y
9162: BD 3C 4F       JSR    $BE6D
9165: 33 4A 92       LEAU   $10,U
9168: 96 04          LDA    $2C
916A: 27 92          BEQ    $9186
916C: 0A 04          DEC    $2C
916E: 27 9E          BEQ    $9186
9170: EC 23          LDD    $1,X
9172: C3 9C 20       ADDD   #$1E02
9175: 0D 5C          TST    $DE
9177: 27 2A          BEQ    $917B
9179: C0 90          SUBB   #$18
917B: ED 29          STD    $1,X
917D: 10 8E 54 F4    LDY    #$DCD6
9181: BD 0B C9       JSR    $894B
9184: 33 66          LEAU   $4,U
9186: 39             RTS

9187: 0C D6          INC    $FE
9189: 0F 77          CLR    $FF
918B: D6 C3          LDB    $EB
918D: F0 B9 59       SUBB   $31D1
9190: D1 C5          CMPB   $E7
9192: 2E 80          BGT    $9196
9194: D6 C5          LDB    $E7
9196: D7 69          STB    $EB
9198: 7D 19 4C       TST    $31C4
919B: 26 2E          BNE    $91A3
919D: F6 B9 5C       LDB    $31D4
91A0: F7 13 46       STB    $31C4
91A3: F6 13 F7       LDB    $31D5
91A6: F7 B3 EE       STB    $31C6
91A9: F7 B9 58       STB    $31D0
91AC: 0D FD          TST    $D5
91AE: 27 8C          BEQ    $91B4
91B0: A6 A6          LDA    ,X
91B2: 97 57          STA    $D5
91B4: 0D F5          TST    $D7
91B6: 26 80          BNE    $91BA
91B8: 6F AC          CLR    ,X
91BA: 4F             CLRA
91BB: 5F             CLRB
91BC: 6F 2C          CLR    $4,X
91BE: ED 80          STD    $8,X
91C0: ED 28          STD    $A,X
91C2: ED 8E          STD    $C,X
91C4: ED 2C          STD    $E,X
91C6: 39             RTS

91C7: 0F CE          CLR    $E6
91C9: A6 AA          LDA    $2,Y
91CB: 80 2B          SUBA   #$03
91CD: A1 8A          CMPA   $2,X
91CF: 22 38          BHI    $91EB
91D1: AB A4          ADDA   $6,Y
91D3: 8B 26          ADDA   #$04
91D5: A1 80          CMPA   $2,X
91D7: 25 3A          BCS    $91EB
91D9: A6 A9          LDA    $1,Y
91DB: 80 2B          SUBA   #$03
91DD: A1 89          CMPA   $1,X
91DF: 22 28          BHI    $91EB
91E1: AB A4          ADDA   $6,Y
91E3: 8B 24          ADDA   #$06
91E5: A1 83          CMPA   $1,X
91E7: 25 2A          BCS    $91EB
91E9: 0C 6E          INC    $E6
91EB: 39             RTS

91EC: A6 29          LDA    $1,X
91EE: 91 26          CMPA   $AE
91F0: 22 34          BHI    $9208
91F2: 91 2D          CMPA   $AF
91F4: 25 30          BCS    $9208
91F6: A6 8A          LDA    $8,X
91F8: 5D             TSTB
91F9: 26 8F          BNE    $9202
91FB: 81 18          CMPA   #$30
91FD: 22 8A          BHI    $9201
91FF: 6C 2A          INC    $8,X
9201: 39             RTS

9202: 81 81          CMPA   #$03
9204: 23 20          BLS    $9208
9206: 6A 8A          DEC    $8,X
9208: 39             RTS

9209: 34 98          PSHS   X
920B: 8E 19 48       LDX    #$3160
920E: 86 8A          LDA    #$02
9210: B7 13 A6       STA    $3124
9213: A7 A6          STA    ,X
9215: 4A             DECA
9216: B7 B3 0B       STA    $3123
9219: 0C 5F          INC    $D7
921B: CC 98 D8       LDD    #$B0F0
921E: ED 89          STD    $1,X
9220: 8E CC FE       LDX    #$EE7C
9223: BF 13 02       STX    $3120
9226: 0F 57          CLR    $D5
9228: 0C F3          INC    $DB
922A: 35 18          PULS   X,PC
922C: 8E 19 E8       LDX    #$3160
922F: EC 23          LDD    $1,X
9231: C0 80          SUBB   #$02
9233: C1 32          CMPB   #$10
9235: 22 80          BHI    $9239
9237: 6F AC          CLR    ,X
9239: 96 87          LDA    $0F
923B: 84 29          ANDA   #$01
923D: 27 9C          BEQ    $9253
923F: A6 23          LDA    $1,X
9241: BB B3 A1       ADDA   $3123
9244: ED 23          STD    $1,X
9246: 7A B3 0C       DEC    $3124
9249: 26 80          BNE    $9253
924B: 86 10          LDA    #$38
924D: B7 B9 AC       STA    $3124
9250: 70 13 A1       NEG    $3123
9253: CE 14 6A       LDU    #$3648
9256: 10 BE 19 08    LDY    $3120
925A: 96 87          LDA    $0F
925C: 84 2B          ANDA   #$03
925E: 26 98          BNE    $9270
9260: 31 00          LEAY   $2,Y
9262: A6 26          LDA    ,Y
9264: 81 DD          CMPA   #$FF
9266: 26 86          BNE    $926C
9268: 10 8E 66 F4    LDY    #$EE7C
926C: 10 BF B9 A8    STY    $3120
9270: BD AB C9       JSR    $894B
9273: 7E AE E9       JMP    $8CCB
9276: 0D 82          TST    game_playing_00
9278: 26 2B          BNE    $927D
927A: 7E 2B 57       JMP    $A37F
927D: 96 AC          LDA    $24
927F: 48             ASLA
9280: 8E CC 07       LDX   #table_ee85
9283: AD B4          JSR    [A,X]        ; [jump_table]
9285: 96 A6          LDA    $24
9287: 81 29          CMPA   #$01
9289: 23 8B          BLS    $928E
928B: 7E 70 41       JMP    $5869
928E: 39             RTS

928F: 0C 06          INC    $24
9291: 4F             CLRA
9292: 5F             CLRB
9293: BD 6C B8       JSR    queue_event_4e9a
9296: 0F 9B          CLR    $19
9298: 7F 3C 08       CLR    flip_screen_set_1480
929B: 0F 2A          CLR    $02
929D: 39             RTS

929E: 0D AE          TST    $26
92A0: 10 26 82 2F    LBNE   $9351
92A4: 0C 04          INC    $26
92A6: 8E B6 A4       LDX    #$348C
92A9: CE BC FC       LDU    #$3474
92AC: 86 2C          LDA    #$04
92AE: C6 8B          LDB    #$03
92B0: D7 6A          STB    $48
92B2: E6 00          LDB    ,-X
92B4: E7 E0          STB    ,-U
92B6: 0A CA          DEC    $48
92B8: 26 D0          BNE    $92B2
92BA: 6F 4A          CLR    ,-U
92BC: A7 EA          STA    ,-U
92BE: 4A             DECA
92BF: 26 CF          BNE    $92AE
92C1: CE B6 C2       LDU    #$3440
92C4: D6 23          LDB    $01
92C6: D7 D4          STB    $56
92C8: D6 29          LDB    $01
92CA: D7 DD          STB    $55
92CC: 8E 1C E8       LDX    #$3460
92CF: 4F             CLRA
92D0: 5F             CLRB
92D1: DD 72          STD    $F0
92D3: DD D0          STD    $F2
92D5: 97 76          STA    $F4
92D7: A6 29          LDA    $1,X
92D9: 81 77          CMPA   #$FF
92DB: 27 39          BEQ    $92EE
92DD: D6 79          LDB    $F1
92DF: E1 20          CMPB   $2,X
92E1: 22 89          BHI    $92EE
92E3: 25 25          BCS    $92EC
92E5: DC 70          LDD    $F2
92E7: 10 A3 2B       CMPD   $3,X
92EA: 24 8A          BCC    $92EE
92EC: 8D 7E          BSR    $9344
92EE: 30 8D          LEAX   $5,X
92F0: 0A 77          DEC    $55
92F2: 2A 61          BPL    $92D7
92F4: 0D D6          TST    $F4
92F6: 26 89          BNE    $9303
92F8: 8E 1C D3       LDX    #$345B
92FB: 30 2D          LEAX   $5,X
92FD: A6 89          LDA    $1,X
92FF: 2B D8          BMI    $92FB
9301: 8D C3          BSR    $9344
9303: DC D3          LDD    $F1
9305: ED 43          STD    ,U++
9307: DC DB          LDD    $F3
9309: ED 49          STD    ,U++
930B: 5A             DECB
930C: 86 2D          LDA    #$05
930E: 3D             MUL
930F: 8E 16 42       LDX    #$3460
9312: 3A             ABX
9313: 86 DD          LDA    #$FF
9315: A7 83          STA    $1,X
9317: 0A 7E          DEC    $56
9319: 2A 25          BPL    $92C8
931B: 96 29          LDA    $01
931D: 97 DD          STA    $55
931F: 8E 16 22       LDX    #$3400
9322: 10 8E 16 62    LDY    #$3440
9326: EC 23          LDD    ,Y++
9328: ED A9          STD    ,X++
932A: EC 29          LDD    ,Y++
932C: A7 A8          STA    ,X+
932E: E7 8B          STB    $3,X
9330: CE 11 DF       LDU    #$335D
9333: 86 21          LDA    #$03
9335: 3D             MUL
9336: 33 47          LEAU   B,U
9338: 86 2B          LDA    #$03
933A: BD 1E E2       JSR    $96CA
933D: 30 89          LEAX   $1,X
933F: 0A 77          DEC    $55
9341: 2A 61          BPL    $9326
9343: 39             RTS

9344: A6 A6          LDA    ,X
9346: 97 76          STA    $F4
9348: E6 2A          LDB    $2,X
934A: D7 79          STB    $F1
934C: EC 2B          LDD    $3,X
934E: DD 7A          STD    $F2
9350: 39             RTS

9351: 96 83          LDA    $01
9353: C6 36          LDB    #$14
9355: DD DA          STD    $58
9357: 4C             INCA
9358: 97 7C          STA    $54
935A: BD 1B C4       JSR    $93EC
935D: 8E B5 56       LDX    #$3DDE
9360: 9F 74          STX    $56
9362: 30 0A E6       LEAX   -$3C,X
9365: 96 D6          LDA    $54
9367: C6 2E          LDB    #$06
9369: 3D             MUL
936A: 33 0D          LEAU   B,X
936C: DC 72          LDD    $5A
936E: 10 A3 A6       CMPD   ,X
9371: 22 AB          BHI    $939C
9373: 25 25          BCS    $937C
9375: DC D9          LDD    $5B
9377: 10 A3 29       CMPD   $1,X
937A: 24 A8          BCC    $939C
937C: DC 72          LDD    $5A
937E: ED 4C          STD    ,U
9380: DC 7E          LDD    $5C
9382: ED C0          STD    $2,U
9384: DC 7C          LDD    $5E
9386: ED C6          STD    $4,U
9388: 33 72          LEAU   -$6,U
938A: 96 DD          LDA    $55
938C: BD BC 8E       JSR    $9406
938F: 0A 76          DEC    $54
9391: 27 D6          BEQ    $93E7
9393: 96 76          LDA    $54
9395: 8D D7          BSR    $93EC
9397: BD BC 35       JSR    $941D
939A: 20 58          BRA    $936C
939C: EC AC          LDD    ,X
939E: ED 4C          STD    ,U
93A0: EC 20          LDD    $2,X
93A2: ED C0          STD    $2,U
93A4: EC 26          LDD    $4,X
93A6: ED C6          STD    $4,U
93A8: 33 72          LEAU   -$6,U
93AA: 30 92          LEAX   -$6,X
93AC: 25 2F          BCS    $93B5
93AE: 8D E5          BSR    $941D
93B0: 8C 1A 64       CMPX   #$38E6
93B3: 24 95          BCC    $936C
93B5: CC 85 7D       LDD    #$07FF
93B8: DD 70          STD    $58
93BA: 8E B0 CE       LDX    #$38E6
93BD: CE BC 88       LDU    #$3400
93C0: EC E3          LDD    ,U++
93C2: ED 03          STD    ,X++
93C4: EC E3          LDD    ,U++
93C6: ED 03          STD    ,X++
93C8: EC E9          LDD    ,U++
93CA: ED 09          STD    ,X++
93CC: A6 E8          LDA    ,U+
93CE: 8D BE          BSR    $9406
93D0: 0C 7A          INC    $58
93D2: 96 DA          LDA    $58
93D4: 81 28          CMPA   #$0A
93D6: 26 89          BNE    $93E3
93D8: 0F 70          CLR    $58
93DA: 0F D1          CLR    $59
93DC: 10 8E B1 A6    LDY    #$392E
93E0: 10 9F D4       STY    $56
93E3: 0A 76          DEC    $54
93E5: 26 5B          BNE    $93C0
93E7: 0C 0C          INC    $24
93E9: 0F 91          CLR    $19
93EB: 39             RTS

93EC: 10 8E BB 71    LDY    #$33F9
93F0: C6 25          LDB    #$07
93F2: 3D             MUL
93F3: 31 87          LEAY   B,Y
93F5: EC 23          LDD    ,Y++
93F7: DD 72          STD    $5A
93F9: EC 29          LDD    ,Y++
93FB: DD 74          STD    $5C
93FD: EC 29          LDD    ,Y++
93FF: DD 7C          STD    $5E
9401: A6 26          LDA    ,Y
9403: 97 77          STA    $55
9405: 39             RTS

9406: 10 8E 1C 34    LDY    #$341C
940A: C6 8C          LDB    #$04
940C: 3D             MUL
940D: 31 2D          LEAY   B,Y
940F: DC 74          LDD    $56
9411: ED 23          STD    ,Y++
9413: DC 7A          LDD    $58
9415: 5D             TSTB
9416: 2A 80          BPL    $941A
9418: 80 2A          SUBA   #$02
941A: ED 2C          STD    ,Y
941C: 39             RTS

941D: 0A D0          DEC    $58
941F: 2A 2D          BPL    $9430
9421: 10 9E D4       LDY    $56
9424: 31 8A 46       LEAY   -$3C,Y
9427: 10 9F 7E       STY    $56
942A: C6 81          LDB    #$09
942C: D7 70          STB    $58
942E: 0A D1          DEC    $59
9430: 39             RTS

9431: 0D 9B          TST    $19
9433: 26 27          BNE    $943A
9435: 86 AF          LDA    #$2D
9437: BD 66 9B       JSR    force_queue_sound_event_4eb3
943A: 96 84          LDA    $0C
943C: 84 27          ANDA   #$0F
943E: 81 87          CMPA   #$0F
9440: 26 33          BNE    $9453
9442: CE 6C F0       LDU    #$EED2
9445: 8E A5 97       LDX    #$2715
9448: 86 21          LDA    #$09
944A: 97 C0          STA    $48
944C: 86 22          LDA    #$0A
944E: BD 29 FD       JSR    $A1DF
9451: 20 A3          BRA    $9474
9453: 96 21          LDA    $03
9455: 27 9F          BEQ    $9474
9457: C6 22          LDB    #$0A
9459: BD 2E 8E       JSR    $A606
945C: 1E A1          EXG    A,B
945E: 8E AF 34       LDX    #$2716
9461: ED 85          STD    $7,X		; [video_address]
9463: CC 28 28       LDD    #$0A0A
9466: ED 0B 20 2F    STD    $0807,X		; [video_address]
946A: CE 67 2D       LDU    #$EF05
946D: C6 8E          LDB    #$06
946F: D7 6A          STB    $48
9471: BD 23 5D       JSR    $A1DF
9474: 8E 02 4B       LDX    #$20C9
9477: 7D 1C 0B       TST    $3423
947A: 2A 8A          BPL    $947E
947C: 30 2C          LEAX   $4,X
947E: CE 66 B3       LDU    #$EE91
9481: 86 85          LDA    #$07
9483: BD B4 E8       JSR    $96CA
9486: 86 8E          LDA    #$0C
9488: 97 60          STA    $48
948A: 4F             CLRA
948B: CE C6 8F       LDU    #$EEA7
948E: 33 C4          LEAU   $C,U
9490: 8E CC 3E       LDX    #$EEBC
9493: D6 3B          LDB    $19
9495: 3A             ABX
9496: A6 06          LDA    ,X
9498: 8E 09 CE       LDX    #$2146
949B: 7D 1C 0B       TST    $3423
949E: 2A 8A          BPL    $94A2
94A0: 30 26          LEAX   $4,X
94A2: BD 23 FD       JSR    $A1DF
94A5: 30 99          LEAX   -$5,X
94A7: 96 31          LDA    $19
94A9: 4C             INCA
94AA: A7 09          STA    ,X++
94AC: C6 2B          LDB    #$03
94AE: 3D             MUL
94AF: CE 11 7F       LDU    #$335D
94B2: 33 47          LEAU   B,U
94B4: 86 21          LDA    #$03
94B6: BD 14 E2       JSR    $96CA
94B9: 8E A1 48       LDX    #$29C0
94BC: 86 22          LDA    #$0A
94BE: 97 C0          STA    $48
94C0: CE CC 1A       LDU    #$EE98
94C3: 86 5E          LDA    #$7C
94C5: E6 42          LDB    ,U+
94C7: BD BE EC       JSR    $96C4
94CA: 0A C0          DEC    $48
94CC: 26 DD          BNE    $94C3
94CE: 8E A9 C0       LDX    #$21E2
94D1: 86 92          LDA    #$10
94D3: F6 16 01       LDB    $3423
94D6: 10 2B 28 86    LBMI   $9588
94DA: 27 98          BEQ    $94EC
94DC: C1 3C          CMPB   #$14
94DE: 10 27 22 BB    LBEQ   $957B
94E2: C1 88          CMPB   #$0A
94E4: 25 26          BCS    $94EA
94E6: 86 83          LDA    #$01
94E8: C0 22          SUBB   #$0A
94EA: 20 8A          BRA    $94EE
94EC: C6 38          LDB    #$10
94EE: 1F 8B          TFR    D,U
94F0: 86 23          LDA    #$01
94F2: EF 03          STU    ,X++
94F4: A7 A2          STA    ,X+
94F6: 30 0A 56       LEAX   $7E,X
94F9: 4C             INCA
94FA: 81 82          CMPA   #$0A
94FC: 26 DC          BNE    $94F2
94FE: 1F B8          TFR    U,D
9500: C1 2B          CMPB   #$09
9502: 26 8B          BNE    $950D
9504: 81 32          CMPA   #$10
9506: 26 83          BNE    $9509
9508: 4F             CLRA
9509: 4C             INCA
950A: 5F             CLRB
950B: 20 2E          BRA    $9513
950D: C1 98          CMPB   #$10
950F: 26 23          BNE    $9512
9511: 5F             CLRB
9512: 5C             INCB
9513: ED A3          STD    ,X++
9515: 4F             CLRA
9516: A7 06          STA    ,X
9518: FE 1C A8       LDU    $3420
951B: 8E 09 C0       LDX    #$21E8
951E: 33 40 E8       LEAU   -$36,U
9521: 86 88          LDA    #$0A
9523: 97 6B          STA    $49
9525: 30 84          LEAX   $6,X
9527: 0F 78          CLR    $50
9529: C6 8B          LDB    #$03
952B: A6 EC          LDA    ,U
952D: 44             LSRA
952E: 44             LSRA
952F: 44             LSRA
9530: 44             LSRA
9531: 8D BB          BSR    $956C
9533: A7 A2          STA    ,X+
9535: A6 42          LDA    ,U+
9537: 8D 1B          BSR    $956C
9539: A7 08          STA    ,X+
953B: 5A             DECB
953C: 26 C5          BNE    $952B
953E: 4F             CLRA
953F: A7 A6          STA    ,X
9541: 30 96          LEAX   -$C,X
9543: 86 21          LDA    #$03
9545: BD 14 48       JSR    $96CA
9548: 30 A1 88 0C    LEAX   $0084,X
954C: 0A 61          DEC    $49
954E: 26 5F          BNE    $9527
9550: 8E 14 4C       LDX    #$36CE
9553: BF 16 72       STX    $3450
9556: 86 87          LDA    #$05
9558: 97 07          STA    $2F
955A: 0C AC          INC    $24
955C: CC C6 2A       LDD    #$EEA2
955F: FD 16 42       STD    $3460
9562: BD 2D E3       JSR    $AFC1
9565: 8E 58 D9       LDX    #$DA5B
9568: BF 1C C8       STX    $3440
956B: 39             RTS

956C: 84 27          ANDA   #$0F
956E: 26 80          BNE    $9578
9570: 0D 72          TST    $50
9572: 26 86          BNE    $9578
9574: 86 32          LDA    #$10
9576: 20 80          BRA    $957A
9578: 0C 78          INC    $50
957A: 39             RTS

957B: 86 3A          LDA    #$12
957D: CE 66 48       LDU    #$EEC0
9580: BD B4 48       JSR    $96CA
9583: 7F 16 00       CLR    $3422
9586: 20 4A          BRA    $9550
9588: 8E 0A E1       LDX    #$2269
958B: CE C6 F3       LDU    #$EEDB
958E: 86 86          LDA    #$0E
9590: BD B4 48       JSR    $96CA
9593: 8E 01 40       LDX    #$2362
9596: 86 9E          LDA    #$1C
9598: BD BE 42       JSR    $96CA
959B: 8E 0C 47       LDX    #$246F
959E: CE B0 C4       LDU    #$38E6
95A1: 86 81          LDA    #$03
95A3: BD 87 03       JSR    $A521
95A6: 8E A6 40       LDX    #$2468
95A9: CC 8B 64       LDD    #$03EC
95AC: 97 62          STA    $4A
95AE: CE 78 DC       LDU    #$F0FE
95B1: 86 83          LDA    #$01
95B3: BD 83 EA       JSR    $A1C8
95B6: 30 0A 68       LEAX   $40,X
95B9: 0A C2          DEC    $4A
95BB: 26 DC          BNE    $95B1
95BD: 20 19          BRA    $9550
95BF: BD B4 B0       JSR    $9692
95C2: CC 80 32       LDD    #$0210
95C5: DD F2          STD    $70
95C7: BE 1C 78       LDX    $3450
95CA: A6 0C          LDA    ,X
95CC: 8B 20          ADDA   #$08
95CE: 24 8A          BCC    $95D2
95D0: 6C 23          INC    $1,X
95D2: A7 06          STA    ,X
95D4: A6 26          LDA    $4,X
95D6: 80 8A          SUBA   #$08
95D8: 24 2A          BCC    $95DC
95DA: 6A 8D          DEC    $5,X
95DC: A7 2C          STA    $4,X
95DE: 4D             TSTA
95DF: 26 29          BNE    $95EC
95E1: 30 8A          LEAX   $8,X
95E3: BF 16 72       STX    $3450
95E6: 0A AD          DEC    $2F
95E8: 26 2A          BNE    $95EC
95EA: 0C AC          INC    $24
95EC: 96 27          LDA    $0F
95EE: 84 8B          ANDA   #$03
95F0: 27 23          BEQ    $95F3
95F2: 39             RTS

95F3: 8E 12 82       LDX    #$30A0
95F6: CE B4 28       LDU    #$3600
95F9: 96 91          LDA    $19
95FB: 4C             INCA
95FC: B1 1C 8E       CMPA   $3406
95FF: 27 09          BEQ    $962C
9601: 7D B6 A1       TST    $3423
9604: 2B 04          BMI    $962C
9606: 96 8D          LDA    $0F
9608: 84 2F          ANDA   #$07
960A: 27 89          BEQ    $960D
960C: 39             RTS

960D: 10 BE BC 62    LDY    $3440
9611: 31 A5          LEAY   $7,Y
9613: CC 02 02       LDD    #$2020
9616: ED 83          STD    $1,X
9618: 8D 29          BSR    $961B
961A: 39             RTS

961B: A6 8C          LDA    ,Y
961D: 81 77          CMPA   #$FF
961F: 26 21          BNE    $9624
9621: 10 AE A3       LDY    $1,Y
9624: 10 BF B6 C2    STY    $3440
9628: BD AE 66       JSR    $86EE
962B: 39             RTS

962C: 10 8E 67 83    LDY    #$EF0B
9630: 96 2D          LDA    $0F
9632: 85 92          BITA   #$10
9634: 26 20          BNE    $9638
9636: 31 A7          LEAY   $5,Y
9638: CC 08 F0       LDD    #$2078
963B: 7D 1C 0B       TST    $3423
963E: 2B 8A          BMI    $9642
9640: C6 02          LDB    #$20
9642: ED 83          STD    $1,X
9644: BD A5 36       JSR    $87B4
9647: 39             RTS

9648: 96 27          LDA    $0F
964A: 84 8B          ANDA   #$03
964C: 26 2B          BNE    $9651
964E: BD 1D D1       JSR    $95F3
9651: 0A F3          DEC    chrono_hundredth_second_71
9653: 26 1F          BNE    $9692
9655: 0A F2          DEC    $70
9657: 26 11          BNE    $9692
9659: 0C 91          INC    $19
965B: 96 25          LDA    dsw2_copy_0d
965D: 85 8A          BITA   #$02
965F: 26 2F          BNE    $966E
9661: 96 9B          LDA    $19
9663: 81 20          CMPA   #$02
9665: 25 85          BCS    $966E
9667: 86 29          LDA    #$01
9669: B7 9C 08       STA    flip_screen_set_1480
966C: 97 2A          STA    $02
966E: 96 89          LDA    $01
9670: 91 3B          CMPA   $19
9672: 24 86          BCC    $9678
9674: 0C 06          INC    $24
9676: 20 98          BRA    $9692
9678: 86 2A          LDA    #$02
967A: 97 AC          STA    $24
967C: D6 31          LDB    $19
967E: 58             ASLB
967F: 58             ASLB
9680: 8E 16 A2       LDX    #$3420
9683: 3A             ABX
9684: EE A3          LDU    ,X++
9686: EC 06          LDD    ,X
9688: FF 1C A8       STU    $3420
968B: FD 1C 0A       STD    $3422
968E: 4F             CLRA
968F: BD 6C B8       JSR    queue_event_4e9a
9692: 96 8D          LDA    $0F
9694: 84 21          ANDA   #$03
9696: 26 A9          BNE    $96C3
9698: 8E 01 68       LDX    #$29E0
969B: B6 1C 0A       LDA    $3422
969E: 27 8F          BEQ    $96A7
96A0: 30 AB 82 02    LEAX   $0080,X
96A4: 4A             DECA
96A5: 26 7B          BNE    $96A0
96A7: FE 1C 48       LDU    $3460
96AA: E6 48          LDB    ,U+
96AC: FF 1C E8       STU    $3460
96AF: C1 DD          CMPB   #$FF
96B1: 26 87          BNE    $96B8
96B3: CE CC 80       LDU    #$EEA2
96B6: 20 70          BRA    $96AA
96B8: 7D 1C AB       TST    $3423
96BB: 2A 2A          BPL    $96BF
96BD: 30 82          LEAX   $A,X
96BF: 86 02          LDA    #$20
96C1: 8D 83          BSR    $96C4
96C3: 39             RTS

96C4: E7 A2          STB    ,X+		; [video_address]
96C6: 4A             DECA
96C7: 26 D3          BNE    $96C4
96C9: 39             RTS

96CA: E6 48          LDB    ,U+
96CC: E7 A8          STB    ,X+		; [video_address]
96CE: 4A             DECA
96CF: 26 DB          BNE    $96CA
96D1: 39             RTS

96D2: 96 8E          LDA    $0C
96D4: 84 2D          ANDA   #$0F
96D6: 81 8D          CMPA   #$0F
96D8: 27 20          BEQ    $96E2
96DA: 0D 8B          TST    $03
96DC: 27 2C          BEQ    $96E2
96DE: 4F             CLRA
96DF: BD 6C 91       JSR    force_queue_sound_event_4eb3
96E2: 0F 82          CLR    game_playing_00
96E4: 0F 3B          CLR    $19
96E6: 8E B2 08       LDX    #$3020
96E9: 86 86          LDA    #$0E
96EB: 6F A8          CLR    ,X+
96ED: 4A             DECA
96EE: 26 73          BNE    $96EB
96F0: 39             RTS

96F1: 96 A6          LDA    $24
96F3: 48             ASLA
96F4: 8E CD 97       LDX   #table_ef15
96F7: 6E BE          JMP    [A,X]        ; [jump_table]
96F9: 4F             CLRA
96FA: BD C6 B2       JSR    queue_event_4e9a
96FD: CC 8A 9B       LDD    #$0213
9700: BD 6C 18       JSR    queue_event_4e9a
9703: BD 8D E3       JSR    $AFC1
9706: 7F 96 A8       CLR    flip_screen_set_1480
9709: 0F 91          CLR    $19
970B: 0F 2A          CLR    $02
970D: CC 99 8B       LDD    #$1103
9710: B7 16 A2       STA    $3420
9713: D7 0B          STB    $29
9715: 8E B6 D2       LDX    #$3450
9718: BF 1C 89       STX    $3401
971B: CC 38 24       LDD    #$100C
971E: A7 08          STA    ,X+
9720: 5A             DECB
9721: 26 79          BNE    $971E
9723: CC 20 37       LDD    #$0215
9726: DD F2          STD    $70
9728: CC 2A 08       LDD    #$0280
972B: DD 5A          STD    chrono_second_72
972D: 0C AC          INC    $24
972F: CE CC 80       LDU    #$EEA2
9732: FF B6 32       STU    $3410
9735: 33 C7          LEAU   $5,U
9737: FF 1C 3A       STU    $3412
973A: 39             RTS

973B: 96 25          LDA    dsw2_copy_0d
973D: 85 8A          BITA   #$02
973F: 26 2F          BNE    $974E
9741: 96 9B          LDA    $19
9743: 81 20          CMPA   #$02
9745: 25 85          BCS    $974E
9747: 86 29          LDA    #$01
9749: B7 9C 08       STA    flip_screen_set_1480
974C: 97 2A          STA    $02
974E: 8E AD E3       LDX    #$25C1
9751: 96 9B          LDA    $19
9753: 84 23          ANDA   #$01
9755: 26 81          BNE    $975A
9757: 30 A0 30       LEAX   $18,X
975A: 86 8E          LDA    #$06
975C: 97 60          STA    $48
975E: 86 08          LDA    #$80
9760: CE CD 20       LDU    #$EFA2
9763: BD 83 FD       JSR    $A1DF
9766: 30 0A 51       LEAX   $79,X
9769: 86 8A          LDA    #$02
976B: 97 61          STA    $49
976D: 86 80          LDA    #$08
976F: 97 6A          STA    $48
9771: 86 02          LDA    #$80
9773: BD 83 FD       JSR    $A1DF
9776: 30 0A 10       LEAX   $38,X
9779: 0A C1          DEC    $49
977B: 26 D8          BNE    $976D
977D: 30 00 C9       LEAX   $41,X
9780: 86 24          LDA    #$06
9782: CE 6D B7       LDU    #$EF95
9785: BD 14 48       JSR    $96CA
9788: BD 66 42       JSR    $4ECA
978B: BD 67 A2       JSR    $4F8A
978E: A6 4C          LDA    ,U
9790: 84 25          ANDA   #$07
9792: 27 8F          BEQ    $97A1
9794: CC 23 42       LDD    #$01C0
9797: 0D 01          TST    $29
9799: 26 8A          BNE    $979D
979B: C6 72          LDB    #$5A
979D: DD FA          STD    chrono_second_72
979F: 20 16          BRA    $97D5
97A1: 0A F1          DEC    $73
97A3: 26 12          BNE    $97D5
97A5: 0A F0          DEC    chrono_second_72
97A7: 26 04          BNE    $97D5
97A9: CC 8A C8       LDD    #$0240
97AC: DD 5A          STD    chrono_second_72
97AE: 0D A1          TST    $29
97B0: 10 27 82 2F    LBEQ   $9861
97B4: 8E 16 D2       LDX    #$3450
97B7: 96 31          LDA    $19
97B9: C6 8B          LDB    #$03
97BB: 3D             MUL
97BC: 3A             ABX
97BD: 1F 9B          TFR    X,U
97BF: BC 16 23       CMPX   $3401
97C2: 26 8B          BNE    $97CD
97C4: 86 21          LDA    #$03
97C6: D6 9B          LDB    $19
97C8: CB 39          ADDB   #$11
97CA: BD 1E EC       JSR    $96C4
97CD: 33 CB          LEAU   $3,U
97CF: FF 16 23       STU    $3401
97D2: 7E 1A 43       JMP    $9861
97D5: BD CD 23       JSR    $4FA1
97D8: 84 2D          ANDA   #$05
97DA: 27 80          BEQ    $97E4
97DC: 1F A1          TFR    A,B
97DE: 86 99          LDA    #$11
97E0: 97 07          STA    $25
97E2: 20 93          BRA    $97F5
97E4: BD 6D 08       JSR    $4F8A
97E7: E6 EC          LDB    ,U
97E9: C4 8D          ANDB   #$05
97EB: 27 36          BEQ    $980B
97ED: 0A AD          DEC    $25
97EF: 26 38          BNE    $980B
97F1: 86 88          LDA    #$0A
97F3: 97 07          STA    $25
97F5: B6 B6 A2       LDA    $3420
97F8: C5 29          BITB   #$01
97FA: 27 8B          BEQ    $97FF
97FC: 4C             INCA
97FD: 20 89          BRA    $9800
97FF: 4A             DECA
9800: BD BB 3A       JSR    $99B8
9803: B7 16 02       STA    $3420
9806: 86 95          LDA    #$17
9808: BD 66 3B       JSR    force_queue_sound_event_4eb3
980B: BD 67 89       JSR    $4FA1
980E: 84 8A          ANDA   #$02
9810: 27 54          BEQ    $9888
9812: 86 9A          LDA    #$18
9814: BD 6C 31       JSR    force_queue_sound_event_4eb3
9817: BE 1C 29       LDX    $3401
981A: B6 BC 08       LDA    $3420
981D: 81 A4          CMPA   #$2C
981F: 25 03          BCS    $9842
9821: 80 AF          SUBA   #$2D
9823: 27 24          BEQ    $982B
9825: 2A 9A          BPL    $983F
9827: 86 38          LDA    #$10
9829: 20 9F          BRA    $9842
982B: 96 01          LDA    $29
982D: 81 8B          CMPA   #$03
982F: 27 75          BEQ    $9888
9831: 0C AB          INC    $29
9833: 86 32          LDA    #$10
9835: BE B6 83       LDX    $3401
9838: A7 AA          STA    ,-X
983A: BF BC 29       STX    $3401
983D: 20 C1          BRA    $9888
983F: 7E B5 8B       JMP    $97A9
9842: 0D AB          TST    $29
9844: 26 20          BNE    $9848
9846: 30 9D          LEAX   -$1,X
9848: A7 A8          STA    ,X+
984A: BF BC 29       STX    $3401
984D: 0A A1          DEC    $29
984F: 2A 20          BPL    $9853
9851: 0F AB          CLR    $29
9853: 26 11          BNE    $9888
9855: CC 83 B2       LDD    #$0130
9858: DD 5A          STD    chrono_second_72
985A: 86 A6          LDA    #$2E
985C: B7 1C A8       STA    $3420
985F: 20 05          BRA    $9888
9861: 86 81          LDA    #$03
9863: 97 0B          STA    $29
9865: 0C 9B          INC    $19
9867: 96 31          LDA    $19
9869: 8B 99          ADDA   #$11
986B: B7 1C 08       STA    $3420
986E: 96 91          LDA    $19
9870: 91 23          CMPA   $01
9872: 23 88          BLS    $987E
9874: 0C 06          INC    $24
9876: 0A 9B          DEC    $19
9878: 86 3C          LDA    #$14
987A: 97 FA          STA    chrono_second_72
987C: 20 22          BRA    $9888
987E: 4F             CLRA
987F: BD 6C B8       JSR    queue_event_4e9a
9882: CC 80 31       LDD    #$0213
9885: BD CC 18       JSR    queue_event_4e9a
9888: 86 39          LDA    #$11
988A: CE 67 71       LDU    #$EF59
988D: C6 96          LDB    #$1E
988F: D7 6A          STB    $48
9891: AE 41          LDX    ,--U
9893: A7 A6          STA    ,X					;  [video_address]
9895: C6 92          LDB    #$10
9897: E7 29          STB    $1,X			;  [video_address]
9899: 10 BE BC 3A    LDY    $3412
989D: 31 A9          LEAY   $1,Y
989F: E6 86          LDB    ,Y
98A1: 2A 84          BPL    $98A9
98A3: 10 8E CD 19    LDY    #$EF9B
98A7: 20 DE          BRA    $989F

98A9: 10 BF BC 3A    STY    $3412
98AD: E7 01 80 22    STB    $0800,X					;  [video_address]
98B1: E7 0B 8A 23    STB    $0801,X					;  [video_address]
98B5: BD 1B 25       JSR    $99A7
98B8: 0A 60          DEC    $48
98BA: 26 5D          BNE    $9891
98BC: 8E 0C 0D       LDX    #$2485
98BF: 96 3B          LDA    $19
98C1: 84 83          ANDA   #$01
98C3: 26 21          BNE    $98C8
98C5: 30 0A 94       LEAX   $16,X
98C8: CE 1C D8       LDU    #$3450
98CB: 86 2C          LDA    #$04
98CD: 97 C0          STA    $48
98CF: 86 21          LDA    #$03
98D1: BD 14 48       JSR    $96CA
98D4: 30 AA BF       LEAX   $3D,X
98D7: 0A 60          DEC    $48
98D9: 26 7C          BNE    $98CF
98DB: 30 A1 2E 74    LEAX   $06FC,X
98DF: A6 A6          LDA    ,X		; [video_address]
98E1: 26 BB          BNE    $991C
98E3: CE CC 9E       LDU    #$EEBC
98E6: 86 86          LDA    #$04
98E8: 97 60          STA    $48
98EA: E6 48          LDB    ,U+
98EC: 86 2F          LDA    #$07
98EE: BD 1E E6       JSR    $96C4
98F1: 30 0A BB       LEAX   $39,X
98F4: 0A 6A          DEC    $48
98F6: 26 70          BNE    $98EA
98F8: 8E 0C 09       LDX    #$2481
98FB: 96 31          LDA    $19
98FD: 84 89          ANDA   #$01
98FF: 26 21          BNE    $9904
9901: 30 0A 94       LEAX   $16,X
9904: 96 23          LDA    $01
9906: C6 C2          LDB    #$40
9908: 3D             MUL
9909: 3A             ABX
990A: 96 89          LDA    $01
990C: 4C             INCA
990D: 10 8E AD 02    LDY    #$2520
9911: A7 06          STA    ,X		; [video_address]
9913: 10 AF 23       STY    $1,X		; [video_address]
9916: 30 0A E8       LEAX   -$40,X
9919: 4A             DECA
991A: 26 7D          BNE    $9911
991C: 96 27          LDA    $0F
991E: 84 8B          ANDA   #$03
9920: 26 0C          BNE    $9950
9922: 8E AE A3       LDX    #$2C81
9925: 96 9B          LDA    $19
9927: 84 29          ANDA   #$01
9929: 26 8B          BNE    $992E
992B: 30 A0 3E       LEAX   $16,X
992E: 96 91          LDA    $19
9930: C6 62          LDB    #$40
9932: 3D             MUL
9933: 3A             ABX
9934: FE 16 92       LDU    $3410
9937: E6 E8          LDB    ,U+
9939: 2A 8D          BPL    $9940
993B: CE C6 8A       LDU    #$EEA2
993E: 20 7F          BRA    $9937
9940: FF 16 92       STU    $3410
9943: 86 25          LDA    #$07
9945: BD 14 46       JSR    $96C4
9948: 8E 01 08       LDX    #$2980
994B: 86 08          LDA    #$20
994D: BD 1E 4C       JSR    $96C4
9950: F6 16 A2       LDB    $3420
9953: C0 33          SUBB   #$11
9955: 58             ASLB
9956: 8E 6D 71       LDX    #$EF59
9959: 3A             ABX
995A: EC 0C          LDD    ,X
995C: 10 8E 56 FF    LDY    #$DE77
9960: CE 14 82       LDU    #$3600
9963: 8E 12 82       LDX    #$30A0
9966: 80 81          SUBA   #$03
9968: C0 2B          SUBB   #$03
996A: ED 89          STD    $1,X
996C: B6 1C A8       LDA    $3420
996F: 81 0E          CMPA   #$2C
9971: 25 86          BCS    $9977
9973: CB 21          ADDB   #$03
9975: E7 80          STB    $2,X
9977: BD A1 63       JSR    $894B
997A: A6 4C          LDA    ,U
997C: F6 1C A8       LDB    $3420
997F: C1 0E          CMPB   #$2C
9981: 25 84          BCS    $9989
9983: 8A 29          ORA    #$0B
9985: A7 46          STA    ,U
9987: 20 2C          BRA    $998D
9989: 8A 82          ORA    #$0A
998B: A7 EC          STA    ,U
998D: 96 78          LDA    $F0
998F: 8B 02          ADDA   #$20
9991: 97 72          STA    $F0
9993: 26 2D          BNE    $99A4
9995: BE B6 90       LDX    $3412
9998: 30 29          LEAX   $1,X
999A: A6 0C          LDA    ,X
999C: 2A 2B          BPL    $99A1
999E: 8E 67 B9       LDX    #$EF9B
99A1: BF B6 90       STX    $3412
99A4: 8D 3D          BSR    $99C5
99A6: 39             RTS

99A7: 81 04          CMPA   #$2C
99A9: 25 84          BCS    $99B7
99AB: 1F A1          TFR    A,B
99AD: C0 A4          SUBB   #$2C
99AF: 58             ASLB
99B0: CB B8          ADDB   #$9A
99B2: E7 06          STB    ,X		; [video_address]
99B4: 5C             INCB
99B5: E7 83          STB    $1,X		; [video_address]
99B7: 4C             INCA
99B8: 81 38          CMPA   #$10
99BA: 22 8A          BHI    $99BE
99BC: 86 06          LDA    #$2E
99BE: 81 A7          CMPA   #$2F
99C0: 25 20          BCS    $99C4
99C2: 86 93          LDA    #$11
99C4: 39             RTS

99C5: 0A F3          DEC    chrono_hundredth_second_71
99C7: 26 27          BNE    $99D8
99C9: 0D F8          TST    $70
99CB: 27 23          BEQ    $99D8
99CD: 0A F8          DEC    $70
99CF: 26 25          BNE    $99D8
99D1: 0C A5          INC    $27
99D3: 86 12          LDA    #$30
99D5: BD CC 31       JSR    force_queue_sound_event_4eb3
99D8: 39             RTS

99D9: BD 10 00       JSR    $9888
99DC: 0D 5A          TST    chrono_second_72
99DE: 27 8C          BEQ    $99E4
99E0: 0A 50          DEC    chrono_second_72
99E2: 26 AF          BNE    $9A11
99E4: 0D 05          TST    $27
99E6: 27 AB          BEQ    $9A11
99E8: 8E 1B E8       LDX    #$3360
99EB: CE 1C 78       LDU    #$3450
99EE: 86 84          LDA    #$0C
99F0: BD B4 48       JSR    $96CA
99F3: 4F             CLRA
99F4: BD 6C 2F       JSR    queue_sound_event_4ead
99F7: 0F 31          CLR    $19
99F9: 0C A8          INC    $20
99FB: 8E 18 0B       LDX    #$3023
99FE: BD 1E CB       JSR    $96E9
9A01: BD 0B 53       JSR    $89D1
9A04: 5D             TSTB
9A05: 26 8A          BNE    $9A0F
9A07: 0A 08          DEC    $20
9A09: 86 8B          LDA    #$03
9A0B: 97 0C          STA    $24
9A0D: 20 8A          BRA    $9A11
9A0F: 0F 00          CLR    $22
9A11: 39             RTS

archery_9a12:
9A12: 96 AA          LDA    event_sub_state_28
9A14: 48             ASLA
9A15: 8E 6D 3A       LDX   #table_efb8
9A18: 6E BE          JMP    [A,X]        ; [jump_table]

9A1A: BD 27 87       JSR    $AFAF
9A1D: 8E B9 48       LDX    #$31C0
9A20: 86 62          LDA    #$40
9A22: 6F 02          CLR    ,X+
9A24: 4A             DECA
9A25: 26 79          BNE    $9A22
9A27: 0F 9E          CLR    $B6
9A29: 8E B8 1F       LDX    #$3097
9A2C: 86 21          LDA    #$09
9A2E: 6F 08          CLR    ,X+
9A30: 4A             DECA
9A31: 26 79          BNE    $9A2E
9A33: 4F             CLRA
9A34: BD 6C 2F       JSR    queue_sound_event_4ead
9A37: 0D 42          TST    $6A
9A39: 26 8D          BNE    $9A40
9A3B: 86 0C          LDA    #$24
9A3D: BD C6 25       JSR    queue_sound_event_4ead
9A40: CC 36 94       LDD    #$1416
9A43: FD 11 57       STD    $3375
9A46: CC F2 38       LDD    #$7010
9A49: DD 29          STD    $A1
9A4B: CC 2A 2D       LDD    #$0205
9A4E: DD 38          STD    speed_msb_b0
9A50: 86 DD          LDA    #$FF
9A52: 0D E8          TST    $6A
9A54: 27 20          BEQ    $9A58
9A56: 86 B0          LDA    #$32
9A58: 97 58          STA    $70
9A5A: 8E B9 28       LDX    #$3100
9A5D: 9F 30          STX    $B8
9A5F: CC 20 21       LDD    #$0203
9A62: DD 6A          STD    $E8
9A64: BD BD 62       JSR    $9FE0
9A67: 86 FA          LDA    #$D2
9A69: 97 A7          STA    $2F
9A6B: 8E 0D 7F       LDX    #$2557
9A6E: CE 78 5A       LDU    #$F078
9A71: 86 87          LDA    #$05
9A73: 97 6A          STA    $48
9A75: 4F             CLRA
9A76: BD 23 F7       JSR    $A1DF
9A79: 30 00 B3       LEAX   $3B,X
9A7C: 8E D8 E8       LDX    #$F060
9A7F: 9F 9C          STX    $BE
9A81: 0C AA          INC    event_sub_state_28
9A83: 96 2D          LDA    $0F
9A85: 84 8D          ANDA   #$0F
9A87: 26 29          BNE    $9A8A
9A89: 4C             INCA
9A8A: 97 FA          STA    chrono_second_72
9A8C: BD B5 2D       JSR    $9DA5
9A8F: 86 25          LDA    #$07
9A91: 97 36          STA    $B4
9A93: 97 8A          STA    $A8
9A95: 97 35          STA    $B7
9A97: 8E C6 8A       LDX    #$EEA2
9A9A: 9F 7B          STX    $F3
9A9C: 39             RTS

9A9D: 96 87          LDA    $0F
9A9F: 84 23          ANDA   #$01
9AA1: 26 8B          BNE    $9AAC
9AA3: 96 50          LDA    chrono_second_72
9AA5: 4C             INCA
9AA6: 84 8D          ANDA   #$0F
9AA8: 97 5A          STA    chrono_second_72
9AAA: 27 79          BEQ    $9A9D
9AAC: 0A 58          DEC    $70
9AAE: 27 93          BEQ    $9ACB
9AB0: BD 6D 23       JSR    $4FA1
9AB3: 85 20          BITA   #$02
9AB5: 27 80          BEQ    $9AB9
9AB7: 0C 5B          INC    $73
9AB9: 81 8F          CMPA   #$07
9ABB: 26 22          BNE    $9AC7
9ABD: D6 FB          LDB    $73
9ABF: C1 24          CMPB   #$06
9AC1: 26 86          BNE    $9AC7
9AC3: C6 2A          LDB    #$08
9AC5: D7 F0          STB    chrono_second_72
9AC7: 84 2D          ANDA   #$05
9AC9: 27 91          BEQ    $9AE4
9ACB: 0C 00          INC    event_sub_state_28
9ACD: 86 87          LDA    #$0F
9ACF: 97 0B          STA    $29
9AD1: 0D E8          TST    $6A
9AD3: 26 2D          BNE    $9AE4
9AD5: 8E B7 AA       LDX    #$3528
9AD8: D6 31          LDB    $19
9ADA: 3A             ABX
9ADB: 96 5A          LDA    chrono_second_72
9ADD: A7 0C          STA    ,X
9ADF: 86 06          LDA    #$24
9AE1: BD CC 31       JSR    force_queue_sound_event_4eb3
9AE4: 0D 48          TST    $6A
9AE6: 27 88          BEQ    $9AF2
9AE8: 8E 1D A0       LDX    #$3528
9AEB: D6 31          LDB    $19
9AED: 3A             ABX
9AEE: E6 0C          LDB    ,X
9AF0: 20 20          BRA    $9AF4
9AF2: D6 F0          LDB    chrono_second_72
9AF4: 8E D2 E1       LDX    #$F063
9AF7: 3A             ABX
9AF8: A6 AC          LDA    ,X
9AFA: 97 24          STA    $AC
9AFC: 86 29          LDA    #$01
9AFE: C1 80          CMPB   #$08
9B00: 2D 26          BLT    $9B06
9B02: 86 7D          LDA    #$FF
9B04: C0 2A          SUBB   #$08
9B06: D7 DF          STB    $5D
9B08: 97 83          STA    $AB
9B0A: 8E AD A3       LDX    #$258B
9B0D: CE 78 FB       LDU    #$F073
9B10: 86 27          LDA    #$05
9B12: 97 CA          STA    $48
9B14: 4F             CLRA
9B15: BD 23 5D       JSR    $A1DF
9B18: 86 5B          LDA    #$73
9B1A: 0D 23          TST    $AB
9B1C: 2B 29          BMI    $9B1F
9B1E: 4C             INCA
9B1F: A7 A3          STA    ,X++		;  [video_address_word]
9B21: 96 DF          LDA    $5D
9B23: 6F AB 2A 82    CLR    $0800,X					;  [video_address]
9B27: A7 AC          STA    ,X					;  [video_address]
9B29: 39             RTS

9B2A: BD 27 87       JSR    $AFAF
9B2D: 0D A1          TST    $29
9B2F: 27 2F          BEQ    $9B3E
9B31: 0A AB          DEC    $29
9B33: 26 2B          BNE    $9B3E
9B35: 4F             CLRA
9B36: BD CC 9B       JSR    force_queue_sound_event_4eb3
9B39: 86 AF          LDA    #$27
9B3B: BD 66 9B       JSR    force_queue_sound_event_4eb3
9B3E: 9E 30          LDX    $B8
9B40: A6 23          LDA    $1,X
9B42: 81 C0          CMPA   #$42
9B44: 22 3E          BHI    $9B62
9B46: 4F             CLRA
9B47: 30 A0 08       LEAX   $20,X
9B4A: 4C             INCA
9B4B: 8C 19 68       CMPX   #$3140
9B4E: 26 8B          BNE    $9B53
9B50: 8E 13 82       LDX    #$3100
9B53: 81 26          CMPA   #$04
9B55: 27 84          BEQ    $9B5D
9B57: 6D AC          TST    ,X
9B59: 27 64          BEQ    $9B47
9B5B: 20 2B          BRA    $9B60
9B5D: 8E B9 88       LDX    #$3100
9B60: 9F 9A          STX    $B8
9B62: 0A AD          DEC    $2F
9B64: 26 2F          BNE    $9B73
9B66: BD 1D C8       JSR    $9FE0
9B69: 86 5A          LDA    #$D2
9B6B: 0D F0          TST    $D8
9B6D: 27 8A          BEQ    $9B71
9B6F: 80 3C          SUBA   #$1E
9B71: 97 AD          STA    $2F
9B73: 0D EA          TST    $C8
9B75: 26 9F          BNE    $9B94
9B77: 0D 81          TST    $A9
9B79: 26 E1          BNE    $9BE4
9B7B: 0D 9F          TST    $B7
9B7D: 27 ED          BEQ    $9BE4
9B7F: 0D 96          TST    $B4
9B81: 27 E3          BEQ    $9BE4
9B83: BD 6D 83       JSR    $4FA1
9B86: 84 80          ANDA   #$02
9B88: 27 20          BEQ    $9B92
9B8A: 0C 40          INC    $C8
9B8C: 0F E8          CLR    $C0
9B8E: 0F 49          CLR    $C1
9B90: 0F E0          CLR    $C2
9B92: 20 D2          BRA    $9BE4
9B94: 0D E7          TST    $C5
9B96: 26 CE          BNE    $9BE4
9B98: 0D EF          TST    $C7
9B9A: 26 9F          BNE    $9BB3
9B9C: 86 23          LDA    #$0B
9B9E: BD C6 91       JSR    force_queue_sound_event_4eb3
9BA1: 86 99          LDA    #$1B
9BA3: BD 6C 91       JSR    force_queue_sound_event_4eb3
9BA6: 86 9E          LDA    #$1C
9BA8: BD 66 3B       JSR    force_queue_sound_event_4eb3
9BAB: 0C EF          INC    $C7
9BAD: 0C 28          INC    $A0
9BAF: 0C 8B          INC    $A9
9BB1: 0C 37          INC    $B5
9BB3: BD 6D A8       JSR    $4F8A
9BB6: A6 46          LDA    ,U
9BB8: 84 2A          ANDA   #$02
9BBA: 27 AE          BEQ    $9BE2
9BBC: 0C EE          INC    $C6
9BBE: 0A 4B          DEC    $C3
9BC0: 26 24          BNE    $9BC8
9BC2: 86 87          LDA    #$05
9BC4: 97 E1          STA    $C3
9BC6: 0C 46          INC    $C4
9BC8: 96 EA          LDA    $C2
9BCA: 8B 8A          ADDA   #$02
9BCC: 81 22          CMPA   #$0A
9BCE: 27 8C          BEQ    $9BD4
9BD0: 97 E0          STA    $C2
9BD2: 20 92          BRA    $9BE4
9BD4: 0F E0          CLR    $C2
9BD6: 0C 43          INC    $C1
9BD8: 96 E9          LDA    $C1
9BDA: 81 82          CMPA   #$0A
9BDC: 26 2E          BNE    $9BE4
9BDE: 0F 49          CLR    $C1
9BE0: 0C E2          INC    $C0
9BE2: 0C 47          INC    $C5
9BE4: 0D FA          TST    $D8
9BE6: 26 BA          BNE    $9C20
9BE8: 8E 0A 19       LDX    #$2291
9BEB: CE D8 55       LDU    #$F07D
9BEE: 86 8D          LDA    #$05
9BF0: 97 6A          STA    $48
9BF2: 4F             CLRA
9BF3: BD 83 FD       JSR    $A1DF
9BF6: CE B2 E8       LDU    #$30C0
9BF9: 8E AA 59       LDX    #$22D1
9BFC: A6 E8          LDA    ,U+
9BFE: 26 8A          BNE    $9C02
9C00: 86 32          LDA    #$10
9C02: 6F 0B 2A 22    CLR    $0800,X					;  [video_address]
9C06: A7 02          STA    ,X+					;  [video_address]
9C08: A6 E8          LDA    ,U+
9C0A: 6F 01 20 28    CLR    $0800,X					;  [video_address]
9C0E: A7 08          STA    ,X+					;  [video_address]
9C10: 86 09          LDA    #$2B
9C12: 6F 0B 2A 22    CLR    $0800,X					;  [video_address]
9C16: A7 02          STA    ,X+					;  [video_address]
9C18: A6 E8          LDA    ,U+
9C1A: 6F 01 20 28    CLR    $0800,X					;  [video_address]
9C1E: A7 0C          STA    ,X					;  [video_address]
9C20: 0D 53          TST    chrono_hundredth_second_71
9C22: 27 90          BEQ    $9C36
9C24: 0A 53          DEC    chrono_hundredth_second_71
9C26: 26 8C          BNE    $9C36
9C28: C6 1F          LDB    #$37
9C2A: D7 3E          STB    $B6
9C2C: 86 99          LDA    #$B1
9C2E: BD C6 91       JSR    force_queue_sound_event_4eb3
9C31: 86 7D          LDA    #$FF
9C33: BD 6C 91       JSR    force_queue_sound_event_4eb3
9C36: 8E B3 28       LDX    #$3100
9C39: CE BE 88       LDU    #$3600
9C3C: 6D AC          TST    ,X
9C3E: 27 DC          BEQ    $9C94
9C40: 6A 27          DEC    $5,X
9C42: 26 92          BNE    $9C54
9C44: A6 26          LDA    $4,X
9C46: A7 87          STA    $5,X
9C48: A6 29          LDA    $1,X
9C4A: 4A             DECA
9C4B: A7 29          STA    $1,X
9C4D: 81 C8          CMPA   #$40
9C4F: 22 21          BHI    $9C54
9C51: BD 1C A9       JSR    $9E2B
9C54: 10 8E 72 11    LDY    #$F093
9C58: EC 29          LDD    $1,X
9C5A: 9F 78          STX    $F0
9C5C: 6D 20          TST    $8,X
9C5E: 8E B9 42       LDX    #$3160
9C61: ED 83          STD    $1,X
9C63: 0D FA          TST    $D8
9C65: 27 8F          BEQ    $9C74
9C67: 86 C5          LDA    #$ED
9C69: A7 8A          STA    $2,X
9C6B: 10 8E F4 16    LDY    #$DC9E
9C6F: BD AB 69       JSR    $894B
9C72: 20 81          BRA    $9C77
9C74: BD AA 1F       JSR    $889D
9C77: 33 60          LEAU   $8,U
9C79: 9E 78          LDX    $F0
9C7B: 6D 20          TST    $8,X
9C7D: 27 9D          BEQ    $9C94
9C7F: EC 23          LDD    $1,X
9C81: 30 88          LEAX   $A,X
9C83: AB 3D          ADDA   -$1,X
9C85: EB 06          ADDB   ,X
9C87: ED 29          STD    $1,X
9C89: 10 8E 56 67    LDY    #$DE4F
9C8D: BD 01 C3       JSR    $894B
9C90: 33 66          LEAU   $4,U
9C92: 30 94          LEAX   -$A,X
9C94: 30 AA A2       LEAX   $20,X
9C97: 8C 19 68       CMPX   #$3140
9C9A: 26 28          BNE    $9C3C
9C9C: 8E 18 28       LDX    #$30A0
9C9F: CE 14 62       LDU    #$3640
9CA2: 6D 06          TST    ,X
9CA4: 26 28          BNE    $9CB0
9CA6: 0D 2B          TST    $A9
9CA8: 26 69          BNE    $9CEB
9CAA: 0D 3C          TST    $B4
9CAC: 27 15          BEQ    $9CEB
9CAE: 20 B9          BRA    $9CE1
9CB0: BD E2 A5       JSR    $C027
9CB3: 1F AB          TFR    A,B
9CB5: DB 2F          ADDB   $AD
9CB7: D7 85          STB    $AD
9CB9: D0 24          SUBB   $AC
9CBB: 25 20          BCS    $9CC5
9CBD: D7 25          STB    $AD
9CBF: E6 23          LDB    $1,X
9CC1: DB 29          ADDB   $AB
9CC3: E7 23          STB    $1,X
9CC5: AB 80          ADDA   $2,X
9CC7: A7 2A          STA    $2,X
9CC9: 81 84          CMPA   #$0C
9CCB: 25 39          BCS    $9CDE
9CCD: 81 65          CMPA   #$ED
9CCF: 25 32          BCS    $9CE1
9CD1: 0D 38          TST    $BA
9CD3: 26 21          BNE    $9CD8
9CD5: BD 1C CB       JSR    $9E49
9CD8: 96 8A          LDA    $A2
9CDA: 81 70          CMPA   #$F8
9CDC: 25 2B          BCS    $9CE1
9CDE: BD 17 A6       JSR    $9F84
9CE1: 8E B2 22       LDX    #$30A0
9CE4: 10 8E 5C CD    LDY    #$DE4F
9CE8: BD A1 C3       JSR    $894B
9CEB: 0D DA          TST    $F2
9CED: 27 AD          BEQ    $9D14
9CEF: 0A D0          DEC    $F2
9CF1: 26 86          BNE    $9CF7
9CF3: 96 D7          LDA    $F5
9CF5: 20 91          BRA    $9D0A
9CF7: 96 27          LDA    $0F
9CF9: 84 8B          ANDA   #$03
9CFB: 26 3F          BNE    $9D14
9CFD: 9E 7B          LDX    $F3
9CFF: A6 A2          LDA    ,X+
9D01: 2A 87          BPL    $9D08
9D03: 8E CC 80       LDX    #$EEA2
9D06: 20 75          BRA    $9CFF
9D08: 9F DB          STX    $F3
9D0A: 8E A5 B0       LDX    #$2D98
9D0D: C6 8C          LDB    #$04
9D0F: A7 A2          STA    ,X+		; [video_address]
9D11: 5A             DECB
9D12: 26 79          BNE    $9D0F
9D14: B6 13 82       LDA    $3100
9D17: BA 19 08       ORA    $3120
9D1A: 26 C8          BNE    $9D5C
9D1C: D6 8C          LDB    $A4
9D1E: C1 80          CMPB   #$08
9D20: 26 18          BNE    $9D5C
9D22: 0D 5A          TST    $D8
9D24: 26 16          BNE    $9D5A
9D26: DC 1A          LDD    $98
9D28: 10 83 8C 08    CMPD   #$0480
9D2C: 26 04          BNE    $9D5A
9D2E: 0C 50          INC    $D8
9D30: 8E 17 CA       LDX    #$3548
9D33: D6 3B          LDB    $19
9D35: 3A             ABX
9D36: A6 06          LDA    ,X
9D38: 81 2A          CMPA   #$02
9D3A: 26 89          BNE    $9D3D
9D3C: 4C             INCA
9D3D: 8B 8B          ADDA   #$03
9D3F: 9B BA          ADDA   $98
9D41: 19             DAA
9D42: 97 1A          STA    $98
9D44: 86 27          LDA    #$05
9D46: 97 26          STA    $A4
9D48: BD B7 68       JSR    $9FE0
9D4B: 86 2B          LDA    #$03
9D4D: 97 3C          STA    $B4
9D4F: 97 95          STA    $B7
9D51: 4A             DECA
9D52: 97 2A          STA    $A8
9D54: 86 88          LDA    #$AA
9D56: 97 AD          STA    $2F
9D58: 20 2A          BRA    $9D5C
9D5A: 0C A0          INC    event_sub_state_28
9D5C: 8E 0B CB       LDX    #$2343
9D5F: CC 26 A2       LDD    #$0480
9D62: 97 D6          STA    $54
9D64: 0F 73          CLR    $51
9D66: 96 2A          LDA    $A8
9D68: 2A 29          BPL    $9D6B
9D6A: 4F             CLRA
9D6B: 27 0A          BEQ    $9D8F
9D6D: 81 89          CMPA   #$01
9D6F: 27 3A          BEQ    $9D89
9D71: 85 83          BITA   #$01
9D73: 27 20          BEQ    $9D77
9D75: 0C D3          INC    $51
9D77: 44             LSRA
9D78: 97 78          STA    $50
9D7A: 86 6B          LDA    #$E3
9D7C: 8D 36          BSR    $9D9C
9D7E: 30 00 E2       LEAX   -$40,X
9D81: 0A D2          DEC    $50
9D83: 26 D5          BNE    $9D7C
9D85: 0D D3          TST    $51
9D87: 27 2E          BEQ    $9D8F
9D89: 86 6C          LDA    #$E4
9D8B: 8D 27          BSR    $9D9C
9D8D: 20 80          BRA    $9D97
9D8F: 0D 76          TST    $54
9D91: 27 90          BEQ    $9DA5
9D93: 86 32          LDA    #$10
9D95: 8D 87          BSR    $9D9C
9D97: 30 A0 E8       LEAX   -$40,X
9D9A: 20 7B          BRA    $9D8F
9D9C: A7 AC          STA    ,X					;  [video_address]
9D9E: E7 01 2A 22    STB    $0800,X					;  [video_address]
9DA2: 0A D6          DEC    $54
9DA4: 39             RTS

9DA5: 0D 5A          TST    $D8
9DA7: 27 2B          BEQ    $9DAC
9DA9: BD 28 9D       JSR    $A015
9DAC: 8E 19 48       LDX    #$31C0
9DAF: CE 14 42       LDU    #$3660
9DB2: 86 8A          LDA    #$08
9DB4: 97 DD          STA    $FF
9DB6: 10 8E F6 79    LDY    #$DE51
9DBA: BD 01 63       JSR    $894B
9DBD: 6D 0C          TST    ,X
9DBF: 2B 28          BMI    $9DCB
9DC1: 33 DE          LEAU   -$4,U
9DC3: 30 26          LEAX   $4,X
9DC5: 0A 7D          DEC    $FF
9DC7: 26 D9          BNE    $9DBA
9DC9: 20 9E          BRA    $9DE1
9DCB: 6C AC          INC    ,X
9DCD: 9E 36          LDX    $BE
9DCF: E6 A2          LDB    ,X+
9DD1: 96 8D          LDA    $0F
9DD3: 84 21          ANDA   #$03
9DD5: 26 8A          BNE    $9DDF
9DD7: 6D AC          TST    ,X
9DD9: 2A 8A          BPL    $9DDD
9DDB: 30 35          LEAX   -$3,X
9DDD: 9F 36          STX    $BE
9DDF: E7 E6          STB    ,U
9DE1: 8E B3 32       LDX    #$31B0
9DE4: CC 4A 84       LDD    #$6806
9DE7: ED 29          STD    $1,X
9DE9: CE BE B4       LDU    #$363C
9DEC: 10 8E 56 C3    LDY    #$DE4B
9DF0: 0D 97          TST    $B5
9DF2: 27 80          BEQ    $9DF6
9DF4: 31 00          LEAY   $2,Y
9DF6: BD 2D 3B       JSR    $AF13
9DF9: 33 D0          LEAU   -$8,U
9DFB: 0D 9E          TST    $B6
9DFD: 27 86          BEQ    $9E0D
9DFF: 0A 94          DEC    $B6
9E01: CC F2 52       LDD    #$70D0
9E04: ED 23          STD    $1,X
9E06: 10 8E F6 A3    LDY    #$DE8B
9E0A: BD 01 27       JSR    $890F
9E0D: 8E BA E8       LDX    #$3260
9E10: 10 8E 5C D1    LDY    #$DE53
9E14: CE 14 E6       LDU    #$3664
9E17: 86 21          LDA    #$09
9E19: 97 C0          STA    $48
9E1B: EC 89          LDD    ,Y++
9E1D: ED 89          STD    $1,X
9E1F: BD AB 69       JSR    $894B
9E22: 31 A0          LEAY   $2,Y
9E24: 33 66          LEAU   $4,U
9E26: 0A CA          DEC    $48
9E28: 26 D9          BNE    $9E1B
9E2A: 39             RTS

9E2B: 0C D5          INC    $FD
9E2D: 0A 20          DEC    $A8
9E2F: 0F 8B          CLR    $A9
9E31: 86 8A          LDA    #$08
9E33: 90 DF          SUBA   $FD
9E35: 97 36          STA    $B4
9E37: 27 2D          BEQ    $9E3E
9E39: 86 E8          LDA    #$60
9E3B: BD 66 9B       JSR    force_queue_sound_event_4eb3
9E3E: 86 A8          LDA    #$20
9E40: 6F A2          CLR    ,X+
9E42: 4A             DECA
9E43: 26 D9          BNE    $9E40
9E45: 30 0A 62       LEAX   -$20,X
9E48: 39             RTS

9E49: 4F             CLRA
9E4A: BD C6 85       JSR    queue_sound_event_4ead
9E4D: 0F A5          CLR    $2D
9E4F: 0C 98          INC    $BA
9E51: 9E 3A          LDX    $B8
9E53: 6C 2C          INC    $E,X
9E55: 96 23          LDA    $A1
9E57: A0 29          SUBA   $1,X
9E59: 10 27 89 AA    LBEQ   $9FDF
9E5D: 81 A8          CMPA   #$20
9E5F: 10 22 23 FE    LBHI   $9FDF
9E63: 4A             DECA
9E64: A7 2B          STA    $9,X
9E66: 6C 8A          INC    $8,X
9E68: 4C             INCA
9E69: 97 76          STA    $FE
9E6B: 80 38          SUBA   #$10
9E6D: 2A 89          BPL    $9E70
9E6F: 40             NEGA
9E70: C6 21          LDB    #$03
9E72: BD 24 24       JSR    $A606
9E75: D7 D6          STB    $54
9E77: C0 2F          SUBB   #$07
9E79: E7 82          STB    $A,X
9E7B: 96 D6          LDA    $FE
9E7D: 80 98          SUBA   #$10
9E7F: 40             NEGA
9E80: 97 E8          STA    $CA
9E82: 86 8A          LDA    #$08
9E84: D6 E4          LDB    $C6
9E86: C1 84          CMPB   #$06
9E88: 23 17          BLS    $9EC9
9E8A: C0 92          SUBB   #$1A
9E8C: 2A 29          BPL    $9E8F
9E8E: 50             NEGB
9E8F: C1 31          CMPB   #$13
9E91: 22 B4          BHI    $9EC9
9E93: 8E CD E2       LDX    #$EFC0
9E96: 3D             MUL
9E97: 30 A3          LEAX   D,X
9E99: 96 42          LDA    $CA
9E9B: 2A 2A          BPL    $9E9F
9E9D: 40             NEGA
9E9E: 5C             INCB
9E9F: 81 2C          CMPA   #$0E
9EA1: 22 A4          BHI    $9EC9
9EA3: 5F             CLRB
9EA4: 81 20          CMPA   #$02
9EA6: 25 83          BCS    $9EA9
9EA8: 4C             INCA
9EA9: 81 8D          CMPA   #$05
9EAB: 25 29          BCS    $9EAE
9EAD: 4A             DECA
9EAE: 81 8F          CMPA   #$07
9EB0: 25 23          BCS    $9EB3
9EB2: 4A             DECA
9EB3: 81 29          CMPA   #$0B
9EB5: 25 83          BCS    $9EB8
9EB7: 4C             INCA
9EB8: 44             LSRA
9EB9: 24 89          BCC    $9EBC
9EBB: 5C             INCB
9EBC: A6 AE          LDA    A,X
9EBE: 5D             TSTB
9EBF: 26 26          BNE    $9EC5
9EC1: 44             LSRA
9EC2: 44             LSRA
9EC3: 44             LSRA
9EC4: 44             LSRA
9EC5: 84 8D          ANDA   #$0F
9EC7: 20 29          BRA    $9ECA
9EC9: 4F             CLRA
9ECA: 97 A5          STA    $2D
9ECC: 81 22          CMPA   #$0A
9ECE: 2D 8C          BLT    $9ED4
9ED0: C6 36          LDB    #$14
9ED2: D7 F3          STB    chrono_hundredth_second_71
9ED4: 96 0F          LDA    $2D
9ED6: 8E 72 A0       LDX    #$F088
9ED9: A6 0E          LDA    A,X
9EDB: 0D F0          TST    $D8
9EDD: 27 9A          BEQ    $9EF1
9EDF: 9E 9A          LDX    $B8
9EE1: A6 8B          LDA    $9,X
9EE3: 81 20          CMPA   #$02
9EE5: 25 9F          BCS    $9F04
9EE7: 0F F1          CLR    $D9
9EE9: 81 82          CMPA   #$0A
9EEB: 22 3F          BHI    $9F04
9EED: 0C 51          INC    $D9
9EEF: 20 25          BRA    $9EF8
9EF1: 9B 1B          ADDA   $99
9EF3: 19             DAA
9EF4: 97 BB          STA    $99
9EF6: 24 85          BCC    $9EFF
9EF8: 96 B0          LDA    $98
9EFA: 8B 89          ADDA   #$01
9EFC: 19             DAA
9EFD: 97 10          STA    $98
9EFF: BD B2 B0       JSR    $9092
9F02: 20 80          BRA    $9F06
9F04: 6F 2A          CLR    $8,X
9F06: 8E B3 94       LDX    #$31BC
9F09: 30 8C          LEAX   $4,X
9F0B: 6D 29          TST    $1,X
9F0D: 26 72          BNE    $9F09
9F0F: 96 E8          LDA    $CA
9F11: 2B 95          BMI    $9F2A
9F13: 81 21          CMPA   #$03
9F15: 2E 86          BGT    $9F1B
9F17: 48             ASLA
9F18: 4C             INCA
9F19: 20 A1          BRA    $9F44
9F1B: 80 2C          SUBA   #$04
9F1D: 97 DD          STA    $55
9F1F: C6 21          LDB    #$03
9F21: BD 24 84       JSR    $A606
9F24: DB 77          ADDB   $55
9F26: CB 84          ADDB   #$06
9F28: 20 34          BRA    $9F46
9F2A: 40             NEGA
9F2B: 81 2B          CMPA   #$03
9F2D: 2E 8D          BGT    $9F34
9F2F: 48             ASLA
9F30: 4C             INCA
9F31: 40             NEGA
9F32: 20 92          BRA    $9F44
9F34: 80 26          SUBA   #$04
9F36: 97 DD          STA    $5F
9F38: C6 2B          LDB    #$03
9F3A: BD 2E 2E       JSR    $A606
9F3D: DB D7          ADDB   $5F
9F3F: CB 24          ADDB   #$06
9F41: 50             NEGB
9F42: 20 80          BRA    $9F46
9F44: 1F AB          TFR    A,B
9F46: CB 4A          ADDB   #$C8
9F48: E7 2A          STB    $2,X
9F4A: 96 4E          LDA    $C6
9F4C: 81 2E          CMPA   #$06
9F4E: 22 8A          BHI    $9F52
9F50: 86 24          LDA    #$06
9F52: 81 AD          CMPA   #$2F
9F54: 25 20          BCS    $9F58
9F56: 86 AD          LDA    #$2F
9F58: 8B A4          ADDA   #$8C
9F5A: A7 89          STA    $1,X
9F5C: 86 A0          LDA    #$88
9F5E: A7 0C          STA    ,X
9F60: 86 1E          LDA    #$3C
9F62: 97 70          STA    $F2
9F64: D6 0F          LDB    $2D
9F66: 5C             INCB
9F67: 54             LSRB
9F68: 8E D8 0A       LDX    #$F082
9F6B: A6 AD          LDA    B,X
9F6D: 97 7D          STA    $F5
9F6F: 10 9E 9A       LDY    $B8
9F72: 6D AA          TST    $8,Y
9F74: 27 05          BEQ    $9F9D
9F76: 4F             CLRA
9F77: BD 66 9B       JSR    force_queue_sound_event_4eb3
9F7A: 86 81          LDA    #$09
9F7C: BD 66 3B       JSR    force_queue_sound_event_4eb3
9F7F: 86 28          LDA    #$0A
9F81: BD CC 31       JSR    force_queue_sound_event_4eb3
9F84: 0F 82          CLR    $A0
9F86: 0F 38          CLR    $BA
9F88: 0D 9C          TST    $B4
9F8A: 27 8A          BEQ    $9F8E
9F8C: 0C 9F          INC    $B7
9F8E: CC F8 32       LDD    #$7010
9F91: DD 23          STD    $A1
9F93: CE 12 E1       LDU    #$30C3
9F96: 86 8E          LDA    #$0C
9F98: 6F E8          CLR    ,U+
9F9A: 4A             DECA
9F9B: 26 D3          BNE    $9F98
9F9D: 8E B8 68       LDX    #$30E0
9FA0: 6F A6          CLR    ,X
9FA2: 96 AF          LDA    $2D
9FA4: 10 8E 72 0A    LDY    #$F088
9FA8: A6 8E          LDA    A,Y
9FAA: 1F 01          TFR    A,B
9FAC: C4 27          ANDB   #$0F
9FAE: 44             LSRA
9FAF: 44             LSRA
9FB0: 44             LSRA
9FB1: 44             LSRA
9FB2: 0D 5A          TST    $D8
9FB4: 27 2C          BEQ    $9FC4
9FB6: CC 83 28       LDD    #$0100
9FB9: 0D 51          TST    $D9
9FBB: 26 29          BNE    $9FBE
9FBD: 4F             CLRA
9FBE: ED 0C          STD    ,X
9FC0: 6F 20          CLR    $2,X
9FC2: 20 80          BRA    $9FC6
9FC4: ED 23          STD    $1,X
9FC6: 1F 90          TFR    X,Y
9FC8: 8E 0D 10       LDX    #$2598
9FCB: C6 2C          LDB    #$04
9FCD: 0F D8          CLR    $50
9FCF: A6 82          LDA    ,Y+
9FD1: BD 17 EE       JSR    $956C
9FD4: 6F AB 8A 82    CLR    $0800,X					;  [video_address]
9FD8: A7 A8          STA    ,X+					;  [video_address]
9FDA: 5A             DECB
9FDB: 26 DA          BNE    $9FCF
9FDD: 6F 97          CLR    -$1,X		;  [video_address]
9FDF: 39             RTS

9FE0: 8E 13 82       LDX    #$3100
9FE3: 6D A6          TST    ,X
9FE5: 27 88          BEQ    $9FF1
9FE7: 30 A0 08       LEAX   $20,X
9FEA: 8C B9 68       CMPX   #$3140
9FED: 26 7C          BNE    $9FE3
9FEF: 20 01          BRA    $A014
9FF1: 96 26          LDA    $A4
9FF3: 81 2A          CMPA   #$08
9FF5: 27 9F          BEQ    $A014
9FF7: 0C 8C          INC    $A4
9FF9: CC 20 78       LDD    #$A8F0
9FFC: ED 29          STD    $1,X
9FFE: 6C 0C          INC    ,X
A000: 86 20          LDA    #$02
A002: A7 86          STA    $4,X
A004: A7 27          STA    $5,X
A006: 4C             INCA
A007: A7 2E          STA    $6,X
A009: 9F 33          STX    $BB
A00B: 0F 9D          CLR    $B5
A00D: 86 A0          LDA    #$28
A00F: 97 E6          STA    $C4
A011: BD D2 A5       JSR    $5027
A014: 39             RTS

A015: CE B4 A6       LDU    #$3624
A018: 10 8E 54 34    LDY    #$DCBC
A01C: 8E 1D C0       LDX    #$3548
A01F: D6 3B          LDB    $19
A021: 3A             ABX
A022: A6 06          LDA    ,X
A024: C6 2A          LDB    #$08
A026: 3D             MUL
A027: 31 8D          LEAY   B,Y
A029: 8E BC 88       LDX    #$3400
A02C: CC 5B 08       LDD    #$7380
A02F: ED 23          STD    $1,X
A031: BD 05 1C       JSR    $879E
A034: C6 B2          LDB    #$90
A036: E7 80          STB    $2,X
A038: 31 0C          LEAY   $4,Y
A03A: 33 40 38       LEAU   $10,U
A03D: BD 00 15       JSR    $889D
A040: BD B2 10       JSR    $9092
A043: 0D FE          TST    $DC
A045: 26 8E          BNE    $A053
A047: 86 85          LDA    #$AD
A049: BD C6 3B       JSR    force_queue_sound_event_4eb3
A04C: 86 D7          LDA    #$FF
A04E: BD C6 91       JSR    force_queue_sound_event_4eb3
A051: 0C 5E          INC    $DC
A053: 39             RTS

A054: BD 8D 2D       JSR    $AFAF
A057: 0F 9E          CLR    $B6
A059: BD 15 24       JSR    $9DAC
A05C: 7F 1E B5       CLR    $363D
A05F: 4F             CLRA
A060: BD 6C 31       JSR    force_queue_sound_event_4eb3
A063: 8E 17 2A       LDX    #$3508
A066: D6 9B          LDB    $19
A068: 3A             ABX
A069: DC 10          LDD    $98
A06B: 10 83 2C 08    CMPD   #$0480
A06F: 25 25          BCS    $A078
A071: 6C 06          INC    ,X
A073: 6C AA 62       INC    $40,X
A076: 20 81          BRA    $A07B
A078: 6F A0 C8       CLR    $40,X
A07B: BD 57 22       JSR    $7F0A
A07E: BD DC 44       JSR    $5466
A081: CC 02 A2       LDD    #$8020
A084: DD 83          STD    $A1
A086: 0C A4          INC    $26
A088: 86 20          LDA    #$08
A08A: 8E B8 00       LDX    #$3028
A08D: 7E 1E 63       JMP    $96EB
A090: 39             RTS

A091: 96 AA          LDA    event_sub_state_28
A093: 8E D2 B4       LDX   #table_f096
A096: 48             ASLA
A097: AD BE          JSR    [A,X]        ; [jump_table]
A099: 96 84          LDA    $0C
A09B: 84 27          ANDA   #$0F
A09D: 81 87          CMPA   #$0F
A09F: 26 21          BNE    $A0A4
A0A1: 7E DA EB       JMP    $5869
A0A4: 96 21          LDA    $03
A0A6: 27 81          BEQ    $A0AB
A0A8: 7E 54 A8       JMP    $7C20
A0AB: 39             RTS

A0AC: 7F 3C 08       CLR    flip_screen_set_1480
A0AF: D6 2D          LDB    $0F
A0B1: C4 81          ANDB   #$03
A0B3: CE CC 80       LDU    #$EEA2
A0B6: FF B6 48       STU    $3460
A0B9: CC 88 8E       LDD    #$0006
A0BC: CE 1C D0       LDU    #$3458
A0BF: A7 E2          STA    ,U+
A0C1: 8B 88          ADDA   #$0A
A0C3: 5A             DECB
A0C4: 26 DB          BNE    $A0BF
A0C6: 4F             CLRA
A0C7: BD 66 B2       JSR    queue_event_4e9a
A0CA: 0C A0          INC    event_sub_state_28
A0CC: 39             RTS

A0CD: 8E A8 88       LDX    #$2000
A0D0: CC 2D 29       LDD    #$0FAB
A0D3: E7 AB 2A 82    STB    $0800,X					;  [video_address]
A0D7: A7 A8          STA    ,X+					;  [video_address]
A0D9: 8C AB 08       CMPX   #$2380
A0DC: 26 DD          BNE    $A0D3
; protection to crash if coin 4 was set??
A0DE: 12             NOP			; bootleg_hack   LDA    system_1680
A0DF: 12             NOP			; bootleg_hack   ANDA   #$20
A0E0: 12             NOP			; bootleg_hack   LBEQ   $A25D
A0E1: 12             NOP
A0E2: 12             NOP
A0E3: 12             NOP
A0E4: 12             NOP
A0E5: 12             NOP
A0E6: 12             NOP
A0E7: BD 89 C4       JSR    $A1EC
A0EA: 8E AC A8       LDX    #$2480
A0ED: CE 6F 20       LDU    #$E7A8
A0F0: 86 02          LDA    #$20
A0F2: 97 CB          STA    $49
A0F4: D6 08          LDB    event_sub_state_2a
A0F6: 86 87          LDA    #$05
A0F8: 97 60          STA    $48
A0FA: A6 48          LDA    ,U+
A0FC: A7 AC          STA    ,X					;  [video_address]
A0FE: E7 01 2A 22    STB    $0800,X					;  [video_address]
A102: 30 0A E2       LEAX   -$40,X
A105: 0A CA          DEC    $48
A107: 26 D9          BNE    $A0FA
A109: 30 01 89 69    LEAX   $0141,X
A10D: 0A C1          DEC    $49
A10F: 26 C7          BNE    $A0F6
A111: 8E A6 42       LDX    #$24C0
A114: CE CE 81       LDU    #$EC03
A117: 86 2F          LDA    #$07
A119: 97 D9          STA    $51
A11B: A6 E8          LDA    ,U+
A11D: 97 D8          STA    $50
A11F: 86 02          LDA    #$20
A121: 97 CA          STA    $48
A123: 96 08          LDA    event_sub_state_2a
A125: BD 23 5D       JSR    $A1DF
A128: 30 A0 A8       LEAX   $20,X
A12B: 33 E0 C8       LEAU   -$20,U
A12E: 0A D8          DEC    $50
A130: 26 CF          BNE    $A11F
A132: 33 4A 02       LEAU   $20,U
A135: 0A D3          DEC    $51
A137: 26 CA          BNE    $A11B
A139: C6 08          LDB    #$80
A13B: 8E 06 E8       LDX    #$2EC0
A13E: 86 A8          LDA    #$20
A140: BD B4 46       JSR    $96C4
A143: C6 AF          LDB    #$8D
A145: 8E AD 83       LDX    #$2F01
A148: 86 39          LDA    #$11
A14A: BD 1E EC       JSR    $96C4
A14D: 5F             CLRB
A14E: 8E A7 30       LDX    #$2F12
A151: 86 8F          LDA    #$0D
A153: BD B4 E6       JSR    $96C4
A156: 12             NOP           ; bootleg_hack  LDA    system_1680
A157: 12             NOP
A158: 12             NOP
A159: 12             NOP
A15A: 12             NOP
A15B: 12             NOP
A15C: 12             NOP
A15D: 12             NOP
A15E: 12             NOP
A15F: 12             NOP
A160: 12             NOP
A161: 12             NOP
A162: 16 83 0B       LBRA   $A28E
A165: 12             NOP
A166: 12             NOP
A167: 12             NOP
A168: 8E 0D 8F       LDX    #$2507
A16B: CE D8 C4       LDU    #$F0EC
A16E: 86 9A          LDA    #$12
A170: 97 6A          STA    $48
A172: 4F             CLRA
A173: 8D 48          BSR    $A1DF
A175: 86 81          LDA    #$03
A177: 97 61          STA    $49
A179: 8E AD 18       LDX    #$2590
A17C: CE 10 6E       LDU    #$38E6
A17F: 10 8E CC 1A    LDY    #$EE98
A183: 0F 72          CLR    $50
A185: C6 81          LDB    #$03
A187: D7 79          STB    $51
A189: E6 28          LDB    ,Y+
A18B: A6 EC          LDA    ,U
A18D: 44             LSRA
A18E: 44             LSRA
A18F: 44             LSRA
A190: 44             LSRA
A191: BD 17 EE       JSR    $956C
A194: E7 AB 8A 82    STB    $0800,X					;  [video_address]
A198: A7 A8          STA    ,X+					;  [video_address]
A19A: A6 48          LDA    ,U+
A19C: BD BD E4       JSR    $956C
A19F: E7 AB 2A 82    STB    $0800,X					;  [video_address]
A1A3: A7 A2          STA    ,X+					;  [video_address]
A1A5: 0A D3          DEC    $51
A1A7: 26 CA          BNE    $A18B
A1A9: 6F 0C          CLR    ,X					;  [video_address]
A1AB: E7 A1 20 88    STB    $0800,X					;  [video_address]
A1AF: 30 37          LEAX   -$B,X
A1B1: 86 81          LDA    #$03
A1B3: 97 6A          STA    $48
A1B5: 1F 1A          TFR    B,A
A1B7: 8D 0E          BSR    $A1DF
A1B9: 30 00 CA       LEAX   $42,X
A1BC: 0A 61          DEC    $49
A1BE: 26 4B          BNE    $A183
A1C0: 8E 07 0A       LDX    #$2588
A1C3: 86 21          LDA    #$03
A1C5: CE 72 7C       LDU    #$F0FE
A1C8: 97 61          STA    $49
A1CA: CC 08 2A       LDD    #$8002
A1CD: D7 C0          STB    $48
A1CF: 8D 2C          BSR    $A1DF
A1D1: 30 0A BC       LEAX   $3E,X
A1D4: 0A 6B          DEC    $49
A1D6: 26 70          BNE    $A1CA
A1D8: 0C 00          INC    event_sub_state_28
A1DA: 39             RTS

A1DB: 97 60          STA    $48
A1DD: 86 48          LDA    #$C0		; original LDA    #$A0
A1DF: A7 AB 2A 82    STA    $0800,X					;  [video_address]
A1E3: E6 E2          LDB    ,U+
A1E5: E7 02          STB    ,X+					;  [video_address]
A1E7: 0A 60          DEC    $48
A1E9: 26 7C          BNE    $A1DF
A1EB: 39             RTS

A1EC: CC 68 48       LDD    #$40C0
A1EF: DD 08          STD    event_sub_state_2a
A1F1: 8E A3 A1       LDX    #$2123
A1F4: CE D2 1C       LDU    #$F09E
A1F7: C6 20          LDB    #$08
A1F9: D7 C1          STB    $49
A1FB: 86 20          LDA    #$08
A1FD: 97 C0          STA    $48
A1FF: 86 E2          LDA    #$C0
A201: BD 23 5D       JSR    $A1DF
A204: 30 AA BA       LEAX   $38,X
A207: 0A 61          DEC    $49
A209: 26 78          BNE    $A1FB
A20B: 30 A1 D6 80    LEAX   -$01F8,X
A20F: C6 2A          LDB    #$08
A211: D7 CB          STB    $49
A213: 5F             CLRB
A214: 86 32          LDA    #$10
A216: 97 CA          STA    $48
A218: 86 E8          LDA    #$C0
A21A: A7 01 20 28    STA    $0800,X					;  [video_address]
A21E: E7 08          STB    ,X+					;  [video_address]
A220: 5C             INCB
A221: 0A CA          DEC    $48
A223: 26 D7          BNE    $A21A
A225: 30 0A B2       LEAX   $30,X
A228: 0A 61          DEC    $49
A22A: 26 60          BNE    $A214
A22C: 30 A1 75 F5    LEAX   -$0283,X
A230: 86 20          LDA    #$02
A232: 97 D2          STA    $50
A234: 86 26          LDA    #$04
A236: 97 CA          STA    $48
A238: 86 E8          LDA    #$C0
A23A: BD 29 F7       JSR    $A1DF
A23D: 30 00 B4       LEAX   $3C,X
A240: 0A 72          DEC    $50
A242: 26 72          BNE    $A234
A244: 30 AB 83 7E    LEAX   $01FC,X
A248: 86 2A          LDA    #$02
A24A: 97 D8          STA    $50
A24C: 86 2B          LDA    #$03
A24E: 97 C0          STA    $48
A250: 86 E2          LDA    #$C0
A252: BD 23 FD       JSR    $A1DF
A255: 30 0A BF       LEAX   $3D,X
A258: 0A 78          DEC    $50
A25A: 26 78          BNE    $A24C
A25C: 39             RTS

A25D: CC C8 48       LDD    #$40C0		; original  LDD    #$20A0
A260: DD 08          STD    event_sub_state_2a
A262: 8E A2 81       LDX    #$20A3
A265: CE 73 86       LDU    #$F104
A268: 86 24          LDA    #$0C
A26A: 97 D8          STA    $50
A26C: 86 2F          LDA    #$07
A26E: BD 29 F9       JSR    $A1DB
A271: 30 0A BB       LEAX   $39,X
A274: 0A 72          DEC    $50
A276: 26 76          BNE    $A26C
A278: 8E 09 22       LDX    #$21AA
A27B: 86 20          LDA    #$08
A27D: 97 D8          STA    $50
A27F: 86 36          LDA    #$14
A281: BD 23 59       JSR    $A1DB
A284: 30 AA AE       LEAX   $2C,X
A287: 0A 78          DEC    $50
A289: 26 7C          BNE    $A27F
A28B: 7E 88 C2       JMP    $A0EA
A28E: 8E AE E2       LDX    #$26C0
A291: CE 69 22       LDU    #$EBA0
A294: 86 21          LDA    #$03
A296: 97 D3          STA    $51
A298: A6 E8          LDA    ,U+
A29A: 97 D8          STA    $50
A29C: 86 08          LDA    #$20
A29E: 97 C0          STA    $48
A2A0: 96 08          LDA    event_sub_state_2a
A2A2: BD 23 FD       JSR    $A1DF
A2A5: 30 0A A2       LEAX   $20,X
A2A8: 33 E0 68       LEAU   -$20,U
A2AB: 0A 78          DEC    $50
A2AD: 26 65          BNE    $A29C
A2AF: 33 EA 02       LEAU   $20,U
A2B2: 0A D3          DEC    $51
A2B4: 26 C0          BNE    $A298
A2B6: C6 02          LDB    #$80
A2B8: 8E 06 4A       LDX    #$2EC2
A2BB: 86 23          LDA    #$0B
A2BD: BD 1E 4C       JSR    $96C4
A2C0: C6 AF          LDB    #$8D
A2C2: 8E AD 21       LDX    #$2F03
A2C5: 86 8B          LDA    #$09
A2C7: BD BE EC       JSR    $96C4
A2CA: 5F             CLRB
A2CB: 8E 07 38       LDX    #$2F10
A2CE: 86 85          LDA    #$0D
A2D0: BD B4 46       JSR    $96C4
A2D3: 7E 83 4A       JMP    $A168
A2D6: 8E A4 E8       LDX    #$26C0
A2D9: CE 79 70       LDU    #$F1F8
A2DC: 86 2B          LDA    #$03
A2DE: 97 D9          STA    $51
A2E0: A6 E2          LDA    ,U+
A2E2: 97 D2          STA    $50
A2E4: 86 02          LDA    #$20
A2E6: 97 CA          STA    $48
A2E8: 96 02          LDA    event_sub_state_2a
A2EA: BD 29 F7       JSR    $A1DF
A2ED: 30 00 A8       LEAX   $20,X
A2F0: 33 EA 62       LEAU   -$20,U
A2F3: 0A 72          DEC    $50
A2F5: 26 6F          BNE    $A2E4
A2F7: 33 E0 08       LEAU   $20,U
A2FA: 0A D9          DEC    $51
A2FC: 26 CA          BNE    $A2E0
A2FE: D6 A3          LDB    $2B
A300: 8E 0C 43       LDX    #$2EC1
A303: 86 2E          LDA    #$0C
A305: BD 14 46       JSR    $96C4
A308: 8E 07 8A       LDX    #$2F02
A30B: 86 23          LDA    #$0B
A30D: BD 1E 4C       JSR    $96C4
A310: F7 0D CA       STB    $2F48
A313: F7 0D 6E       STB    $2F4C
A316: 5F             CLRB
A317: 8E 07 39       LDX    #$2F11
A31A: 86 85          LDA    #$0D
A31C: BD BE 4C       JSR    $96C4
A31F: B6 34 A2       LDA    system_1680
A322: 85 02          BITA   #$80
A324: 26 31          BNE    $A339
A326: CE 70 73       LDU    #$F25B
A329: 8E AE 41       LDX    #$26C9
A32C: 86 2C          LDA    #$04
A32E: BD 1E E8       JSR    $96CA
A331: 8E A5 8B       LDX    #$2709
A334: 86 26          LDA    #$04
A336: BD 14 E2       JSR    $96CA
A339: 39             RTS

A33A: 8E BE EC       LDX    #$36C4
A33D: CE BC D0       LDU    #$3458
A340: BD 87 D7       JSR    $A555
A343: 6D 7D          TST    -$1,U
A345: 2A 85          BPL    $A34E
A347: 0C 00          INC    event_sub_state_28
A349: CC 8A 10       LDD    #$0298
A34C: DD 58          STD    $70
A34E: 96 87          LDA    $0F
A350: 84 21          ANDA   #$03
A352: 26 95          BNE    $A36B
A354: 8E 0F 85       LDX    #$2D07
A357: FE 1C 48       LDU    $3460
A35A: E6 48          LDB    ,U+
A35C: 2A 2D          BPL    $A363
A35E: CE 66 80       LDU    #$EEA2
A361: 20 75          BRA    $A35A
A363: FF 16 42       STU    $3460
A366: 86 90          LDA    #$12
A368: BD BE 4C       JSR    $96C4
A36B: 39             RTS

A36C: 8D C8          BSR    $A34E
A36E: 0A F9          DEC    chrono_hundredth_second_71
A370: 26 2E          BNE    $A37E
A372: 0A F2          DEC    $70
A374: 26 2A          BNE    $A37E
A376: 0C A0          INC    $22
A378: 0F 00          CLR    event_sub_state_28
A37A: 0F A2          CLR    event_sub_state_2a
A37C: 0F 03          CLR    $2B
A37E: 39             RTS

A37F: 96 06          LDA    $24
A381: 8E 70 E1       LDX   #table_f263
A384: 48             ASLA
A385: AD 14          JSR    [A,X]        ; [jump_table]
A387: 96 24          LDA    $0C
A389: 84 87          ANDA   #$0F
A38B: 81 27          CMPA   #$0F
A38D: 26 8B          BNE    $A392
A38F: 7E 7A 4B       JMP    $5869
A392: 96 81          LDA    $03
A394: 27 21          BEQ    $A399
A396: 7E FE 08       JMP    $7C20
A399: 39             RTS

A39A: 4F             CLRA
A39B: BD 66 B2       JSR    queue_event_4e9a
A39E: 0C AC          INC    $24
A3A0: 7F 36 02       CLR    flip_screen_set_1480
A3A3: CC 22 24       LDD    #$0006
A3A6: CE B6 70       LDU    #$3458
A3A9: A7 48          STA    ,U+
A3AB: 8B 22          ADDA   #$0A
A3AD: 5A             DECB
A3AE: 26 71          BNE    $A3A9
A3B0: 7F 16 81       CLR    $3403
A3B3: CE CC 80       LDU    #$EEA2
A3B6: FF B6 48       STU    $3460
A3B9: 39             RTS

A3BA: 8E A9 22       LDX    #$210A
A3BD: CE 7A 51       LDU    #$F2D9
A3C0: 86 2E          LDA    #$0C
A3C2: BD 14 E8       JSR    $96CA
A3C5: 10 8E 70 45    LDY    #$F26D
A3C9: CE 7A FC       LDU    #$F274
A3CC: 0F 60          CLR    $48
A3CE: 8E A9 A6       LDX    #$2184
A3D1: 96 CA          LDA    $48
A3D3: C6 62          LDB    #$40
A3D5: 3D             MUL
A3D6: 30 09          LEAX   D,X
A3D8: A6 88          LDA    ,Y+
A3DA: BD 1E E2       JSR    $96CA
A3DD: 0C C0          INC    $48
A3DF: 96 6A          LDA    $48
A3E1: 81 85          CMPA   #$07
A3E3: 26 CB          BNE    $A3CE
A3E5: CC 08 0D       LDD    #$8A8F
A3E8: B7 0A 13       STA    $229B
A3EB: B7 0B 33       STA    $231B
A3EE: F7 A9 B9       STB    $219B
A3F1: 86 A9          LDA    #$2B
A3F3: B7 00 39       STA    $221B
A3F6: 10 8E DA E8    LDY    #$F2C0
A3FA: 0F C0          CLR    $48
A3FC: 8E 0B 8A       LDX    #$2302
A3FF: 86 25          LDA    #$07
A401: A7 06          STA    ,X		; [video_address]
A403: 30 AA E2       LEAX   -$40,X
A406: 4A             DECA
A407: 26 D0          BNE    $A401
A409: CE B0 88       LDU    #$3800
A40C: A6 88          LDA    ,Y+
A40E: C6 A8          LDB    #$20
A410: 3D             MUL
A411: 33 49          LEAU   D,U
A413: 8E 03 BB       LDX    #$2199
A416: 96 CA          LDA    $48
A418: C6 68          LDB    #$40
A41A: 3D             MUL
A41B: 30 A3          LEAX   D,X
A41D: E6 8A          LDB    $2,X		; [video_address]
A41F: C1 32          CMPB   #$10
A421: 27 9B          BEQ    $A43C
A423: 33 63          LEAU   $1,U
A425: C6 80          LDB    #$02
A427: 0F 78          CLR    $50
A429: A6 48          LDA    ,U+
A42B: BD BD 44       JSR    $956C
A42E: A7 08          STA    ,X+		; [video_address]
A430: 5A             DECB
A431: 26 74          BNE    $A429
A433: 30 23          LEAX   $1,X
A435: 86 80          LDA    #$02
A437: BD BE E2       JSR    $96CA
A43A: 20 86          BRA    $A44A
A43C: C6 2D          LDB    #$05
A43E: 0F D8          CLR    $50
A440: A6 E2          LDA    ,U+
A442: BD 17 4E       JSR    $956C
A445: A7 02          STA    ,X+		; [video_address]
A447: 5A             DECB
A448: 26 DE          BNE    $A440
A44A: 30 9E          LEAX   -$A,X
A44C: 86 2B          LDA    #$03
A44E: BD 1E E8       JSR    $96CA
A451: 0C CA          INC    $48
A453: 96 6A          LDA    $48
A455: 81 85          CMPA   #$07
A457: 26 98          BNE    $A409
A459: 86 04          LDA    #$8C
A45B: B7 0A F5       STA    $22DD
A45E: 86 81          LDA    #$09
A460: CE CC 1A       LDU    #$EE98
A463: 97 72          STA    $50
A465: 8E AB 00       LDX    #$2982
A468: E6 E8          LDB    ,U+
A46A: 86 94          LDA    #$1C
A46C: BD BE 4C       JSR    $96C4
A46F: 30 AA 06       LEAX   $24,X
A472: 0A D2          DEC    $50
A474: 26 D0          BNE    $A468
A476: 8E A6 CA       LDX    #$24E2
A479: CC 88 8D       LDD    #$0005
A47C: D7 78          STB    $50
A47E: 4C             INCA
A47F: A7 A6          STA    ,X		; [video_address]
A481: 4C             INCA
A482: A7 0A 73       STA    $51,X		; [video_address]
A485: 30 0B 82 A8    LEAX   $0080,X
A489: 0A D8          DEC    $50
A48B: 26 D9          BNE    $A47E
A48D: CC 89 88       LDD    #$0100
A490: FD 05 B0       STD    $2732
A493: CE 1A DA       LDU    #$38F8
A496: 8E A6 C0       LDX    #$24E8
A499: 86 8D          LDA    #$05
A49B: 97 79          STA    $51
A49D: BD 2D 97       JSR    $A51F
A4A0: 30 AA 53       LEAX   -$2F,X
A4A3: BD 87 3D       JSR    $A51F
A4A6: 30 0A 87       LEAX   -$51,X
A4A9: 0A D9          DEC    $51
A4AB: 26 D8          BNE    $A49D
A4AD: 8E AC CF       LDX    #$2447
A4B0: CE D0 45       LDU    #$F2C7
A4B3: 86 30          LDA    #$12
A4B5: BD 14 48       JSR    $96CA
A4B8: 8E 04 48       LDX    #$2CC0
A4BB: 86 22          LDA    #$0A
A4BD: 97 C0          STA    $48
A4BF: CE D0 D7       LDU    #$F2F5
A4C2: 86 C2          LDA    #$40
A4C4: E6 E2          LDB    ,U+
A4C6: BD 14 EC       JSR    $96C4
A4C9: 0A C0          DEC    $48
A4CB: 26 DD          BNE    $A4C2
A4CD: 0C AC          INC    $24
A4CF: 8E 02 A2       LDX    #$2080
A4D2: FE B6 42       LDU    $3460
A4D5: C6 F8          LDB    #$7A
A4D7: 86 08          LDA    #$20
A4D9: 97 C0          STA    $48
A4DB: 8D 1A          BSR    $A50F
A4DD: 30 89          LEAX   $1,X
A4DF: 0A 6A          DEC    $48
A4E1: 26 7A          BNE    $A4DB
A4E3: 30 3D          LEAX   -$1,X
A4E5: 86 8F          LDA    #$0D
A4E7: 97 60          STA    $48
A4E9: 8D AC          BSR    $A50F
A4EB: 30 A0 68       LEAX   $40,X
A4EE: 0A C0          DEC    $48
A4F0: 26 D5          BNE    $A4E9
A4F2: 30 0A E2       LEAX   -$40,X
A4F5: 86 9D          LDA    #$1F
A4F7: 97 60          STA    $48
A4F9: 30 97          LEAX   -$1,X
A4FB: 8D 3A          BSR    $A50F
A4FD: 0A C0          DEC    $48
A4FF: 26 DA          BNE    $A4F9
A501: 86 8E          LDA    #$0C
A503: 97 6A          STA    $48
A505: 30 0A 42       LEAX   -$40,X
A508: 8D 2D          BSR    $A50F
A50A: 0A C0          DEC    $48
A50C: 26 DF          BNE    $A505
A50E: 39             RTS

A50F: A6 E2          LDA    ,U+
A511: 2A 87          BPL    $A518
A513: CE CC 80       LDU    #$EEA2
A516: 20 75          BRA    $A50F
A518: E7 AC          STB    ,X					;  [video_address]
A51A: A7 01 20 28    STA    $0800,X					;  [video_address]
A51E: 39             RTS

A51F: 86 23          LDA    #$01
A521: 97 CB          STA    $49
A523: 0F 72          CLR    $50
A525: C6 81          LDB    #$03
A527: A6 EC          LDA    ,U
A529: 44             LSRA
A52A: 44             LSRA
A52B: 44             LSRA
A52C: 44             LSRA
A52D: BD 1D E4       JSR    $956C
A530: A7 A2          STA    ,X+		;  [video_address]
A532: A6 42          LDA    ,U+
A534: BD B7 EE       JSR    $956C
A537: A7 A8          STA    ,X+		;  [video_address]
A539: 5A             DECB
A53A: 26 63          BNE    $A527
A53C: 4F             CLRA
A53D: A7 0C          STA    ,X		;  [video_address]
A53F: 30 34          LEAX   -$A,X
A541: 86 81          LDA    #$03
A543: BD B4 E8       JSR    $96CA
A546: 30 0B 28 A9    LEAX   $0081,X
A54A: 0A C1          DEC    $49
A54C: 26 FD          BNE    $A523
A54E: 39             RTS

A54F: CE 16 7A       LDU    #$3458
A552: 8E B4 C4       LDX    #$36E6
A555: C6 84          LDB    #$06
A557: 6D EC          TST    ,U
A559: 2B A9          BMI    $A57C
A55B: 26 35          BNE    $A57A
A55D: A6 0C          LDA    ,X
A55F: 8B 2A          ADDA   #$08
A561: 24 80          BCC    $A565
A563: 6C 23          INC    $1,X
A565: A7 06          STA    ,X
A567: A6 2A          LDA    $2,X
A569: 80 80          SUBA   #$08
A56B: 24 2A          BCC    $A56F
A56D: 6A 8B          DEC    $3,X
A56F: A7 20          STA    $2,X
A571: 4D             TSTA
A572: 26 8A          BNE    $A57C
A574: 86 DD          LDA    #$FF
A576: A7 46          STA    ,U
A578: 20 2A          BRA    $A57C
A57A: 6A 4C          DEC    ,U
A57C: 30 2C          LEAX   $4,X
A57E: 33 C9          LEAU   $1,U
A580: 5A             DECB
A581: 26 56          BNE    $A557
A583: 39             RTS

A584: 8D EB          BSR    $A54F
A586: 8D 90          BSR    $A59A
A588: 6D 77          TST    -$1,U
A58A: 2A 8A          BPL    $A58E
A58C: 0C 0C          INC    $24
A58E: 86 F9          LDA    #$71
A590: B7 16 80       STA    $3402
A593: CC 21 12       LDD    #$0330
A596: FD B6 28       STD    $3400
A599: 39             RTS

A59A: 96 87          LDA    $0F
A59C: 84 2B          ANDA   #$03
A59E: 26 A4          BNE    $A5CC
A5A0: BD 86 4D       JSR    $A4CF
A5A3: 8E 0E 62       LDX    #$2C40
A5A6: FE B6 48       LDU    $3460
A5A9: E6 4C          LDB    ,U
A5AB: 2A 2D          BPL    $A5B2
A5AD: CE 66 2A       LDU    #$EEA2
A5B0: 20 D5          BRA    $A5A9
A5B2: 86 A2          LDA    #$20
A5B4: BD B4 46       JSR    $96C4
A5B7: 8E 01 AA       LDX    #$2982
A5BA: B6 BC 2B       LDA    $3403
A5BD: C6 C8          LDB    #$40
A5BF: 3D             MUL
A5C0: 30 A9          LEAX   D,X
A5C2: E6 42          LDB    ,U+
A5C4: FF 16 E2       STU    $3460
A5C7: 86 34          LDA    #$1C
A5C9: BD 1E 4C       JSR    $96C4
A5CC: 39             RTS

A5CD: 8D 43          BSR    $A59A
A5CF: 7A 16 20       DEC    $3402
A5D2: 26 A2          BNE    $A5F4
A5D4: 7C 16 81       INC    $3403
A5D7: 86 58          LDA    #$70
A5D9: B7 BC 8A       STA    $3402
A5DC: 86 21          LDA    #$09
A5DE: CE 66 BA       LDU    #$EE98
A5E1: 97 D2          STA    $50
A5E3: 8E 0B A0       LDX    #$2982
A5E6: E6 42          LDB    ,U+
A5E8: 86 34          LDA    #$1C
A5EA: BD 1E EC       JSR    $96C4
A5ED: 30 00 AC       LEAX   $24,X
A5F0: 0A 72          DEC    $50
A5F2: 26 70          BNE    $A5E6
A5F4: B6 16 81       LDA    $3403
A5F7: 81 2F          CMPA   #$07
A5F9: 26 8A          BNE    $A5FD
A5FB: 0C 0C          INC    $24
A5FD: 39             RTS

A5FE: 0C AA          INC    $22
A600: 8E 12 A6       LDX    #$3024
A603: 7E B4 CB       JMP    $96E9
A606: 6F 60          CLR    ,-S
A608: 6F CA          CLR    ,-S
A60A: 6C 6C          INC    ,S
A60C: 58             ASLB
A60D: 24 73          BCC    $A60A
A60F: 56             RORB
A610: E7 43          STB    $1,S
A612: 5F             CLRB
A613: A0 43          SUBA   $1,S
A615: 24 84          BCC    $A61D
A617: AB 49          ADDA   $1,S
A619: 1C 76          ANDCC  #$FE
A61B: 20 2A          BRA    $A61F
A61D: 1A 89          ORCC   #$01
A61F: 59             ROLB
A620: 64 43          LSR    $1,S
A622: 6A 66          DEC    ,S
A624: 26 CF          BNE    $A613
A626: 6F 62          CLR    ,S+
A628: 6F C8          CLR    ,S+
A62A: 39             RTS

A62B: 0F 77          CLR    $5F
A62D: 0F D6          CLR    $5E
A62F: 0F 7F          CLR    $5D
A631: 59             ROLB
A632: 49             ROLA
A633: 59             ROLB
A634: 49             ROLA
A635: 59             ROLB
A636: 49             ROLA
A637: 59             ROLB
A638: 49             ROLA
A639: 59             ROLB
A63A: 49             ROLA
A63B: 0A 75          DEC    $5D
A63D: 0A D5          DEC    $5D
A63F: 0A 7F          DEC    $5D
A641: 0A DF          DEC    $5D
A643: 9F 79          STX    $5B
A645: 27 B6          BEQ    $A67B
A647: 2B 20          BMI    $A651
A649: 0C D5          INC    $5D
A64B: 08 74          ASL    $5C
A64D: 09 D3          ROL    $5B
A64F: 2A DA          BPL    $A649
A651: 10 93 D9       CMPD   $5B
A654: 25 24          BCS    $A65C
A656: 93 D9          SUBD   $5B
A658: 1A 29          ORCC   #$01
A65A: 20 8A          BRA    $A65E
A65C: 1C D6          ANDCC  #$FE
A65E: 09 D7          ROL    $5F
A660: 09 7C          ROL    $5E
A662: 0A DF          DEC    $5D
A664: 27 24          BEQ    $A66C
A666: 04 D9          LSR    $5B
A668: 06 74          ROR    $5C
A66A: 20 6D          BRA    $A651
A66C: 9E 76          LDX    $5E
A66E: 1C 76          ANDCC  #$FE
A670: 46             RORA
A671: 56             RORB
A672: 46             RORA
A673: 56             RORB
A674: 46             RORA
A675: 56             RORB
A676: 46             RORA
A677: 56             RORB
A678: 46             RORA
A679: 56             RORB
A67A: 39             RTS

A67B: 1A 29          ORCC   #$01
A67D: 39             RTS

A67E: BD C7 A8       JSR    $4F8A
A681: A6 46          LDA    ,U
A683: 39             RTS

A684: BD 84 FC       JSR    $A67E
A687: 81 29          CMPA   #$01
A689: 27 99          BEQ    $A69C
A68B: 81 2C          CMPA   #$04
A68D: 27 85          BEQ    $A69C
A68F: BD 6D 83       JSR    $4FA1
A692: 81 80          CMPA   #$02
A694: 27 06          BEQ    $A6BA
A696: 4F             CLRA
A697: 5F             CLRB
A698: FD 1B F0       STD    $3378
A69B: 39             RTS

A69C: 7D 1B F1       TST    $3379
A69F: 26 36          BNE    $A6B5
A6A1: F6 B1 FA       LDB    $3378
A6A4: 26 2B          BNE    $A6AF
A6A6: 7C B1 50       INC    $3378
A6A9: C6 A8          LDB    #$20
A6AB: F7 1B 51       STB    $3379
A6AE: 39             RTS

A6AF: C6 2A          LDB    #$08
A6B1: F7 B1 FB       STB    $3379
A6B4: 39             RTS

A6B5: 7A B1 FB       DEC    $3379
A6B8: 4F             CLRA
A6B9: 39             RTS

A6BA: 7F BB 50       CLR    $3378
A6BD: 7F BB F1       CLR    $3379
A6C0: 39             RTS

A6C1: E6 02          LDB    ,X+
A6C3: E1 82          CMPB   ,Y+
A6C5: 27 87          BEQ    $A6CC
A6C7: 25 20          BCS    $A6D1
A6C9: 86 89          LDA    #$01
A6CB: 39             RTS

A6CC: 4A             DECA
A6CD: 26 7A          BNE    $A6C1
A6CF: 4F             CLRA
A6D0: 39             RTS

A6D1: 86 7D          LDA    #$FF
A6D3: 39             RTS

pole_vault_a6d4:
A6D4: 96 0A          LDA    event_sub_state_28
A6D6: 48             ASLA
A6D7: 8E DA D7       LDX   #table_f2ff
A6DA: 6E 1E          JMP    [A,X]        ; [jump_table]

A6DC: 96 02          LDA    event_sub_state_2a
A6DE: 48             ASLA
A6DF: 8E D1 2F       LDX   #table_f30d
A6E2: 6E 14          JMP    [A,X]        ; [jump_table]
A6E4: CC 23 82       LDD    #$0100
A6E7: BD 66 B2       JSR    queue_event_4e9a
A6EA: CC 8A 27       LDD    #$020F
A6ED: BD C6 12       JSR    queue_event_4e9a
A6F0: C6 32          LDB    #$10
A6F2: BD CC B8       JSR    queue_event_4e9a
A6F5: C6 93          LDB    #$11
A6F7: BD 66 B2       JSR    queue_event_4e9a
A6FA: 8E BC C0       LDX    #$34E8
A6FD: 96 91          LDA    $19
A6FF: 48             ASLA
A700: EC A4          LDD    A,X
A702: DD 4A          STD    $C8
A704: 8E 17 8A       LDX    #$3508
A707: 96 31          LDA    $19
A709: C6 A8          LDB    #$20
A70B: 3D             MUL
A70C: 30 A3          LEAX   D,X
A70E: EC 09          LDD    ,X++
A710: FD 16 AF       STD    $342D
A713: A6 A2          LDA    ,X+
A715: B7 B6 AD       STA    $342F
A718: A6 AC          LDA    ,X
A71A: B7 BC 7E       STA    $3456
A71D: 96 40          LDA    $C8
A71F: 84 23          ANDA   #$01
A721: 26 AC          BNE    $A751
A723: DC 41          LDD    $63
A725: 48             ASLA
A726: 48             ASLA
A727: 48             ASLA
A728: 48             ASLA
A729: 97 C0          STA    $48
A72B: DA 60          ORB    $48
A72D: 96 EA          LDA    $62
A72F: DD 6A          STD    $48
A731: 10 83 87 A4    CMPD   #$0586
A735: 25 8F          BCS    $A744
A737: 96 61          LDA    $49
A739: 8B 11          ADDA   #$99
A73B: 19             DAA
A73C: 25 2A          BCS    $A740
A73E: 0A C0          DEC    $48
A740: 97 6B          STA    $49
A742: 20 C3          BRA    $A785
A744: 96 6B          LDA    $49
A746: 8B 17          ADDA   #$95
A748: 19             DAA
A749: 25 8A          BCS    $A74D
A74B: 0A 60          DEC    $48
A74D: 97 C1          STA    $49
A74F: 20 16          BRA    $A785
A751: 96 4A          LDA    $C8
A753: 84 20          ANDA   #$02
A755: 26 C3          BNE    $A798
A757: FC 1C 06       LDD    $342E
A75A: 48             ASLA
A75B: 48             ASLA
A75C: 48             ASLA
A75D: 48             ASLA
A75E: 97 C0          STA    $48
A760: DA 6A          ORB    $48
A762: B6 B6 0F       LDA    $342D
A765: DD CA          STD    $48
A767: 10 83 2D 0D    CMPD   #$0585
A76B: 25 25          BCS    $A77A
A76D: 96 C1          LDA    $49
A76F: 8B 23          ADDA   #$01
A771: 19             DAA
A772: 24 80          BCC    $A776
A774: 0C 6A          INC    $48
A776: 97 CB          STA    $49
A778: 20 23          BRA    $A785
A77A: 96 C1          LDA    $49
A77C: 8B 2D          ADDA   #$05
A77E: 19             DAA
A77F: 24 20          BCC    $A783
A781: 0C CA          INC    $48
A783: 97 6B          STA    $49
A785: DC CA          LDD    $48
A787: B7 1C 05       STA    $342D
A78A: 54             LSRB
A78B: 54             LSRB
A78C: 54             LSRB
A78D: 54             LSRB
A78E: F7 BC 0C       STB    $342E
A791: 96 CB          LDA    $49
A793: 84 2D          ANDA   #$0F
A795: B7 B6 AD       STA    $342F
A798: 10 8E AB 62    LDY    #$23EA
A79C: 6F 81 80 88    CLR    $0800,Y					;  [video_address]
A7A0: B6 16 AF       LDA    $342D
A7A3: A7 83          STA    ,Y++					;  [video_address]
A7A5: B7 B0 F0       STA    $3272
A7A8: CC 28 88       LDD    #$0000
A7AB: ED 81 20 88    STD    $0800,Y					;  [video_address_word]
A7AF: FC 16 0C       LDD    $342E
A7B2: ED 26          STD    ,Y					;  [video_address_word]
A7B4: FD 10 F1       STD    $3273
A7B7: 10 8E 0E 52    LDY    #$26DA
A7BB: B6 1C 05       LDA    $342D
A7BE: C6 02          LDB    #$8A
A7C0: ED 83          STD    ,Y++		;  [video_address_word]
A7C2: FC B6 0C       LDD    $342E
A7C5: ED 26          STD    ,Y			;  [video_address]
A7C7: CC 28 28       LDD    #$0000
A7CA: ED 21 2F D6    STD    $07FE,Y  ;  [video_address_word]
A7CE: ED 21 2A 22    STD    $0800,Y	;  [video_address_word]
A7D2: 10 8E 16 0F    LDY    #$342D
A7D6: E6 22          LDB    ,Y+
A7D8: 86 22          LDA    #$0A
A7DA: 3D             MUL
A7DB: EB 88          ADDB   ,Y+
A7DD: 86 82          LDA    #$0A
A7DF: 3D             MUL
A7E0: EB 86          ADDB   ,Y
A7E2: 89 82          ADCA   #$00
A7E4: 83 23 67       SUBD   #$01E5
A7E7: C1 4D          CMPB   #$65
A7E9: 24 81          BCC    $A7F4
A7EB: 1F B0          TFR    B,A
A7ED: C6 8D          LDB    #$05
A7EF: BD 84 24       JSR    $A606
A7F2: 20 80          BRA    $A7F6
A7F4: C0 72          SUBB   #$50
A7F6: F7 B6 04       STB    $342C
A7F9: C6 60          LDB    #$E8
A7FB: F7 1C 19       STB    $3431
A7FE: CC 8F DA       LDD    #$07F8
A801: 10 8E B6 11    LDY    #$3433
A805: E7 23          STB    ,Y++
A807: 4A             DECA
A808: 26 D3          BNE    $A805
A80A: 10 8E 1C 18    LDY    #$3430
A80E: 86 F8          LDA    #$70
A810: A7 86          STA    ,Y
A812: A7 A0          STA    $2,Y
A814: C6 82          LDB    #$A0
A816: FB B6 04       ADDB   $342C
A819: C0 8A          SUBB   #$02
A81B: E7 04          STB    $C,Y
A81D: E7 A6          STB    $E,Y
A81F: C0 2C          SUBB   #$0E
A821: E7 A4          STB    $6,Y
A823: E7 08          STB    $A,Y
A825: B6 B6 AE       LDA    $342C
A828: 47             ASRA
A829: 97 C0          STA    $48
A82B: D0 60          SUBB   $48
A82D: E7 AC          STB    $4,Y
A82F: E7 0A          STB    $8,Y
A831: FC B6 B2       LDD    $3430
A834: FD 10 C3       STD    $3241
A837: FC 1C 1A       LDD    $3432
A83A: FD BA 49       STD    $3261
A83D: 7F BA C8       CLR    $3240
A840: 7F 10 E2       CLR    $3260
A843: CC 22 22       LDD    #$0000
A846: FD B6 D9       STD    $34F1
A849: 86 82          LDA    #$0A
A84B: B7 1C 64       STA    $344C
A84E: 10 8E 05 3A    LDY    #$2718
A852: CC 60 C0       LDD    #$E2E2
A855: ED 23          STD    ,Y++		; [video_address_word]
A857: A7 8C          STA    ,Y		; [video_address]
A859: 31 21 8F D6    LEAY   $07FE,Y
A85D: CC 08 08       LDD    #$8080
A860: ED 86          STD    ,Y			; [video_address_word]
A862: A7 A0          STA    $2,Y		; [video_address]
A864: 96 48          LDA    $6A
A866: 4C             INCA
A867: C6 AB          LDB    #$83
A869: 4A             DECA
A86A: 27 8C          BEQ    $A870
A86C: E7 88          STB    ,Y+		; [video_address]
A86E: 20 71          BRA    $A869
A870: 86 05          LDA    #$27
A872: BD CC 91       JSR    force_queue_sound_event_4eb3
A875: 8E B0 F2       LDX    #$3270
A878: 6F AC          CLR    ,X
A87A: 6F 89          CLR    $1,X
A87C: BD EC ED       JSR    $C465
A87F: 0C 08          INC    event_sub_state_2a
A881: 39             RTS

A882: BD CD 83       JSR    $4FA1
A885: 85 87          BITA   #$05
A887: 26 0D          BNE    $A8AE
A889: BD DF 17       JSR    $579F
A88C: B6 1C 7A       LDA    $34F2
A88F: 81 30          CMPA   #$12
A891: 27 96          BEQ    $A8A7
A893: B1 16 6E       CMPA   $344C
A896: 26 8C          BNE    $A8A6
A898: 7C 1C C4       INC    $344C
A89B: 7C 1C 64       INC    $344C
A89E: 7C BC 6E       INC    $344C
A8A1: 86 BA          LDA    #$38
A8A3: BD 6C 91       JSR    force_queue_sound_event_4eb3
A8A6: 39             RTS

A8A7: 0F 02          CLR    event_sub_state_2a
A8A9: 86 8D          LDA    #$05
A8AB: 97 00          STA    event_sub_state_28
A8AD: 39             RTS

A8AE: 8E B8 82       LDX    #$30A0
A8B1: 86 86          LDA    #$04
A8B3: A7 27          STA    $5,X
A8B5: 0F 38          CLR    $BA
A8B7: 0F E7          CLR    $CF
A8B9: DC 40          LDD    $C8
A8BB: 84 2B          ANDA   #$03
A8BD: C4 76          ANDB   #$FE
A8BF: DD EA          STD    $C8
A8C1: CC 82 82       LDD    #$0000
A8C4: FD 10 2A       STD    $32A8
A8C7: 0F E3          CLR    $CB
A8C9: 7F BA A8       CLR    $3220
A8CC: CC 2B 89       LDD    #$0301
A8CF: FD 16 72       STD    $3450
A8D2: 0F A8          CLR    event_sub_state_2a
A8D4: 0C 0A          INC    event_sub_state_28
A8D6: 39             RTS

A8D7: BD 7F B7       JSR    $579F
A8DA: B6 BC DA       LDA    $34F2
A8DD: 81 D8          CMPA   #$50
A8DF: 27 44          BEQ    $A947
A8E1: 8E B2 22       LDX    #$30A0
A8E4: 10 8E 71 95    LDY    #$F317
A8E8: 96 40          LDA    current_level_68
A8EA: C6 8F          LDB    #$07
A8EC: BD 8E 8E       JSR    $A606
A8EF: C1 21          CMPB   #$03
A8F1: 25 80          BCS    $A8F5
A8F3: C6 21          LDB    #$03
A8F5: F7 B6 D5       STB    $3457
A8F8: 58             ASLB
A8F9: 58             ASLB
A8FA: 31 2D          LEAY   B,Y
A8FC: EC 89          LDD    ,Y++
A8FE: DD D8          STD    $50
A900: EC 83          LDD    ,Y++
A902: DD D0          STD    $52
A904: BD 92 96       JSR    $B014
A907: BD 71 9A       JSR    $59B2
A90A: BD D0 93       JSR    $58BB
A90D: CC 8B 88       LDD    #$0300
A910: BD 6C 18       JSR    queue_event_4e9a
A913: 8E 12 82       LDX    #$30A0
A916: EC 83          LDD    $1,X
A918: 8B 30          ADDA   #$18
A91A: CB CB          ADDB   #$43
A91C: FD 1C A1       STD    $3429
A91F: 10 8E D1 01    LDY    #$F383
A923: BD 92 B4       JSR    $B096
A926: 8E B0 68       LDX    #$3240
A929: BD D8 BD       JSR    $5035
A92C: BD 99 F9       JSR    $B171
A92F: 8E 10 42       LDX    #$3260
A932: BD D2 17       JSR    $5035
A935: BD 33 F3       JSR    $B171
A938: 8E 1A A8       LDX    #$3220
A93B: BD 78 1D       JSR    $5035
A93E: BD D3 AD       JSR    $5B8F
A941: BD 31 E2       JSR    $B360
A944: 4D             TSTA
A945: 27 8B          BEQ    $A950
A947: 0C 00          INC    event_sub_state_28
A949: 0C A0          INC    event_sub_state_28
A94B: 0C 00          INC    event_sub_state_28
A94D: 0C A0          INC    event_sub_state_28
A94F: 39             RTS

A950: 7D 10 E2       TST    $3260
A953: 27 17          BEQ    $A98A
A955: BD CD 23       JSR    $4FA1
A958: 84 2A          ANDA   #$02
A95A: 27 A6          BEQ    $A98A
A95C: 0C 00          INC    event_sub_state_28
A95E: 86 89          LDA    #$01
A960: B7 16 A7       STA    $3425
A963: 96 92          LDA    speed_msb_b0
A965: C6 88          LDB    #$0A
A967: 3D             MUL
A968: DB 99          ADDB   $B1
A96A: C0 8F          SUBB   #$07
A96C: 2A 2A          BPL    $A970
A96E: C6 8F          LDB    #$07
A970: C1 2A          CMPB   #$08
A972: 25 80          BCS    $A976
A974: C6 2A          LDB    #$08
A976: 50             NEGB
A977: CB 22          ADDB   #$0A
A979: F7 BC AC       STB    $3424
A97C: CC 21 88       LDD    #$0900
A97F: FD 16 05       STD    $3427
A982: B6 B6 0B       LDA    $3429
A985: B7 B6 A9       STA    $342B
A988: 0F 27          CLR    $0F
A98A: 39             RTS

A98B: 96 02          LDA    event_sub_state_2a
A98D: 48             ASLA
A98E: 8E 7B 33       LDX   #table_f311
A991: 6E 14          JMP    [A,X]        ; [jump_table]
A993: BD 93 2B       JSR    $B109
A996: 96 8D          LDA    $0F
A998: 46             RORA
A999: 25 C9          BCS    $A9DC
A99B: 8E 18 88       LDX    #$30A0
A99E: BD D0 99       JSR    $58BB
A9A1: BD 31 E2       JSR    $B360
A9A4: 4D             TSTA
A9A5: 27 8B          BEQ    $A9B0
A9A7: 0F 02          CLR    event_sub_state_2a
A9A9: 0C A0          INC    event_sub_state_28
A9AB: 0C 00          INC    event_sub_state_28
A9AD: 0C A0          INC    event_sub_state_28
A9AF: 39             RTS

A9B0: B6 16 A9       LDA    $342B
A9B3: 90 83          SUBA   $A1
A9B5: F6 B6 A7       LDB    $3425
A9B8: 3D             MUL
A9B9: 1F 10          TFR    B,A
A9BB: F6 1C 0C       LDB    $3424
A9BE: BD 2E 24       JSR    $A606
A9C1: 50             NEGB
A9C2: FB B6 09       ADDB   $342B
A9C5: F7 B6 AB       STB    $3429
A9C8: 10 8E BC 88    LDY    #$3400
A9CC: BD 98 1E       JSR    $B096
A9CF: 7C 16 07       INC    $3425
A9D2: B6 B6 06       LDA    $3424
A9D5: B1 B6 A7       CMPA   $3425
A9D8: 24 2A          BCC    $A9DC
A9DA: 0C A2          INC    event_sub_state_2a
A9DC: 39             RTS

A9DD: 8E B8 28       LDX    #$30A0
A9E0: CC 22 83       LDD    #$0001
A9E3: FD 16 05       STD    $3427
A9E6: 10 8E DB 0F    LDY    #$F327
A9EA: 86 8D          LDA    #$05
A9EC: B7 1C C2       STA    $344A
A9EF: B6 10 40       LDA    $3262
A9F2: B0 B6 08       SUBA   $342A
A9F5: B7 B6 C9       STA    $344B
A9F8: 25 24          BCS    $AA06
A9FA: C6 8C          LDB    #$04
A9FC: A1 88          CMPA   ,Y+
A9FE: 25 8E          BCS    $AA06
AA00: 7C 16 C8       INC    $344A
AA03: 5A             DECB
AA04: 26 D4          BNE    $A9FC
AA06: 86 BE          LDA    #$3C
AA08: B7 1C AE       STA    $3426
AA0B: CC 2C 08       LDD    #$0420
AA0E: FD BC 6A       STD    $3448
AA11: CC 82 82       LDD    #$0000
AA14: FD 11 F8       STD    $337A
AA17: FD 1B 54       STD    $337C
AA1A: FD BB 56       STD    $337E
AA1D: EC 89          LDD    $1,X
AA1F: CB 66          ADDB   #$44
AA21: FD B6 AB       STD    $3429
AA24: 8E 12 22       LDX    #$30A0
AA27: A6 A0 38       LDA    $10,X
AA2A: C6 82          LDB    #$0A
AA2C: 3D             MUL
AA2D: EB 00 99       ADDB   $11,X
AA30: 86 28          LDA    #$0A
AA32: 3D             MUL
AA33: EB AA 30       ADDB   $12,X
AA36: C1 AA          CMPB   #$28
AA38: 25 24          BCS    $AA46
AA3A: C1 28          CMPB   #$A0
AA3C: 24 24          BCC    $AA4A
AA3E: 50             NEGB
AA3F: CB 82          ADDB   #$A0
AA41: 57             ASRB
AA42: 57             ASRB
AA43: 57             ASRB
AA44: 20 24          BRA    $AA4C
AA46: C6 9C          LDB    #$1E
AA48: 20 2A          BRA    $AA4C
AA4A: C6 89          LDB    #$01
AA4C: F7 1C AC       STB    $3424
AA4F: 7F 16 07       CLR    $3425
AA52: 8E 71 09       LDX    #$F32B
AA55: F6 B6 D5       LDB    $3457
AA58: B6 1C C3       LDA    $344B
AA5B: A0 AD          SUBA   B,X
AA5D: 27 87          BEQ    $AA6E
AA5F: 2A 27          BPL    $AA66
AA61: 8B 8E          ADDA   #$0C
AA63: 2A 23          BPL    $AA66
AA65: 4F             CLRA
AA66: B7 B6 63       STA    $344B
AA69: 7F BC DE       CLR    $3456
AA6C: 20 2E          BRA    $AA74
AA6E: B7 BC 69       STA    $344B
AA71: 7C B6 D4       INC    $3456
AA74: B6 16 C9       LDA    $344B
AA77: 47             ASRA
AA78: 47             ASRA
AA79: BB BC AC       ADDA   $3424
AA7C: 81 36          CMPA   #$1E
AA7E: 25 8A          BCS    $AA82
AA80: 86 3C          LDA    #$1E
AA82: B7 B6 06       STA    $3424
AA85: 86 85          LDA    #$07
AA87: BD 66 9B       JSR    force_queue_sound_event_4eb3
AA8A: 0C A2          INC    event_sub_state_2a
AA8C: 0F 27          CLR    $0F
AA8E: 39             RTS

AA8F: 86 39          LDA    #$1B
AA91: BD CC 31       JSR    force_queue_sound_event_4eb3
AA94: 86 3E          LDA    #$1C
AA96: BD CC 9B       JSR    force_queue_sound_event_4eb3
AA99: 0F A2          CLR    event_sub_state_2a
AA9B: 0C 00          INC    event_sub_state_28
AA9D: 39             RTS

AA9E: 8E B8 92       LDX    #$30B0
AAA1: 10 8E B1 52    LDY    #$3370
AAA5: BD 24 43       JSR    $A6C1
AAA8: 4D             TSTA
AAA9: 27 A2          BEQ    $AAD5
AAAB: 96 E0          LDA    $C8
AAAD: 85 8C          BITA   #$04
AAAF: 26 06          BNE    $AAD5
AAB1: 7D B6 C9       TST    $344B
AAB4: 27 3D          BEQ    $AAD5
AAB6: 7A B6 63       DEC    $344B
AAB9: 7C BC A2       INC    $342A
AABC: CE 18 38       LDU    #$30B0
AABF: C6 23          LDB    #$01
AAC1: B6 B6 C9       LDA    $344B
AAC4: 81 30          CMPA   #$12
AAC6: 25 80          BCS    $AACA
AAC8: C6 2A          LDB    #$02
AACA: D7 C0          STB    $48
AACC: BD 79 87       JSR    $510F
AACF: CC 21 22       LDD    #$0300
AAD2: BD CC B8       JSR    queue_event_4e9a
AAD5: 96 8D          LDA    $0F
AAD7: 46             RORA
AAD8: 10 25 88 45    LBCS   $ABA9
AADC: BD 8E F6       JSR    $A67E
AADF: 84 20          ANDA   #$02
AAE1: 26 E0          BNE    $AB45
AAE3: 96 EA          LDA    $C8
AAE5: 85 86          BITA   #$04
AAE7: 26 44          BNE    $AB55
AAE9: 85 98          BITA   #$10
AAEB: 26 40          BNE    $AB55
AAED: 8A 8C          ORA    #$04
AAEF: F6 16 05       LDB    $3427
AAF2: C1 87          CMPB   #$05
AAF4: 24 20          BCC    $AAF8
AAF6: 8A 02          ORA    #$80
AAF8: 97 E0          STA    $C8
AAFA: 4F             CLRA
AAFB: BD 66 9B       JSR    force_queue_sound_event_4eb3
AAFE: 86 83          LDA    #$0B
AB00: BD 6C 31       JSR    force_queue_sound_event_4eb3
AB03: B6 16 05       LDA    $3427
AB06: 81 81          CMPA   #$03
AB08: 27 20          BEQ    $AB12
AB0A: 81 8C          CMPA   #$04
AB0C: 27 24          BEQ    $AB1A
AB0E: 86 B4          LDA    #$3C
AB10: 27 2D          BEQ    $AB21
AB12: B6 B6 06       LDA    $3424
AB15: B0 B6 A7       SUBA   $3425
AB18: 20 2B          BRA    $AB1D
AB1A: B6 BC 0D       LDA    $3425
AB1D: 48             ASLA
AB1E: 40             NEGA
AB1F: 8B 78          ADDA   #$5A
AB21: 97 46          STA    $C4
AB23: B6 16 04       LDA    $3426
AB26: 2B 85          BMI    $AB2F
AB28: B6 1C AF       LDA    $3427
AB2B: 81 2D          CMPA   #$05
AB2D: 25 8F          BCS    $AB36
AB2F: CC 22 22       LDD    #$0000
AB32: DD 32          STD    speed_msb_b0
AB34: DD 90          STD    $B2
AB36: FC B1 52       LDD    $337A
AB39: 47             ASRA
AB3A: 56             RORB
AB3B: FD 1B 52       STD    $337A
AB3E: 86 89          LDA    #$01
AB40: B7 16 A4       STA    $3426
AB43: 20 32          BRA    $AB55
AB45: 96 4A          LDA    $C8
AB47: 85 2C          BITA   #$04
AB49: 27 82          BEQ    $AB55
AB4B: 0A EC          DEC    $C4
AB4D: 0A 4C          DEC    $C4
AB4F: 26 26          BNE    $AB55
AB51: 0C 46          INC    $C4
AB53: 0C E6          INC    $C4
AB55: 7A B6 A4       DEC    $3426
AB58: 27 3B          BEQ    $AB6D
AB5A: 2A C5          BPL    $ABA9
AB5C: 96 E0          LDA    $C8
AB5E: 85 8C          BITA   #$04
AB60: 26 65          BNE    $ABA9
AB62: FC B1 58       LDD    $337A
AB65: C3 82 83       ADDD   #$0001
AB68: FD 1B F2       STD    $337A
AB6B: 20 14          BRA    $ABA9
AB6D: B6 BC AF       LDA    $3427
AB70: 81 26          CMPA   #$04
AB72: 22 B7          BHI    $ABA9
AB74: 26 28          BNE    $AB80
AB76: 96 4A          LDA    $C8
AB78: 85 2C          BITA   #$04
AB7A: 27 A5          BEQ    $ABA9
AB7C: 85 A8          BITA   #$80
AB7E: 27 A1          BEQ    $ABA9
AB80: 86 DD          LDA    #$FF
AB82: B7 B6 05       STA    $3427
AB85: 86 8B          LDA    #$09
AB87: B0 1C 00       SUBA   $3428
AB8A: B7 BC 00       STA    $3428
AB8D: B6 BC AD       LDA    $3425
AB90: 26 20          BNE    $AB94
AB92: 86 83          LDA    #$01
AB94: B7 16 A6       STA    $3424
AB97: 7F 1C 0D       CLR    $3425
AB9A: 10 8E 1C 28    LDY    #$3400
AB9E: EC 29          LDD    ,Y++
ABA0: ED 8A D8       STD    $5A,Y
ABA3: 10 8C 16 A6    CMPY   #$3424
ABA7: 26 DD          BNE    $AB9E
ABA9: 96 40          LDA    $C8
ABAB: 85 20          BITA   #$08
ABAD: 27 82          BEQ    $ABB9
ABAF: 85 62          BITA   #$40
ABB1: 26 95          BNE    $ABCA
ABB3: 10 8E D1 01    LDY    #$F383
ABB7: 20 26          BRA    $ABC7
ABB9: BD 39 81       JSR    $B109
ABBC: 96 27          LDA    $0F
ABBE: 46             RORA
ABBF: 10 25 23 21    LBCS   $AD66
ABC3: 10 8E 16 82    LDY    #$3400
ABC7: BD 98 BE       JSR    $B096
ABCA: 96 87          LDA    $0F
ABCC: 46             RORA
ABCD: 10 25 89 B7    LBCS   $AD66
ABD1: 7C B6 A7       INC    $3425
ABD4: 96 EA          LDA    $C8
ABD6: 84 92          ANDA   #$10
ABD8: 10 26 88 15    LBNE   $AC79
ABDC: 8E 18 28       LDX    #$30A0
ABDF: 96 EA          LDA    $C8
ABE1: 84 86          ANDA   #$04
ABE3: 27 44          BEQ    $AC4B
ABE5: BD CD 23       JSR    $4FA1
ABE8: 84 2D          ANDA   #$05
ABEA: 27 87          BEQ    $ABFB
ABEC: 7C 1C DD       INC    $3455
ABEF: B6 16 77       LDA    $3455
ABF2: 81 86          CMPA   #$04
ABF4: 26 27          BNE    $ABFB
ABF6: 7F B6 7D       CLR    $3455
ABF9: 0C 29          INC    $A1
ABFB: 7A 1C 61       DEC    $3449
ABFE: 26 BD          BNE    $AC35
AC00: B6 16 CA       LDA    $3448
AC03: 81 24          CMPA   #$06
AC05: 25 94          BCS    $AC1D
AC07: 81 2F          CMPA   #$07
AC09: 27 A2          BEQ    $AC35
AC0B: 96 89          LDA    $A1
AC0D: 8B 90          ADDA   #$18
AC0F: B1 10 83       CMPA   $32A1
AC12: 25 8B          BCS    $AC1D
AC14: 81 82          CMPA   #$A0
AC16: 25 87          BCS    $AC1D
AC18: 7C 1C C1       INC    $3449
AC1B: 20 30          BRA    $AC35
AC1D: 7C BC C0       INC    $3448
AC20: 86 02          LDA    #$20
AC22: B7 B6 6B       STA    $3449
AC25: B6 B6 CA       LDA    $3448
AC28: 48             ASLA
AC29: 10 8E 7B 07    LDY    #$F32F
AC2D: EC 2E          LDD    A,Y
AC2F: AB 23          ADDA   $1,X
AC31: EB 80          ADDB   $2,X
AC33: ED 23          STD    $1,X
AC35: CC 85 84       LDD    #$0706
AC38: FD 1B FD       STD    $3375
AC3B: BD E8 0F       JSR    $C027
AC3E: 9B 2A          ADDA   $A2
AC40: DB 83          ADDB   $A1
AC42: 1E 0B          EXG    A,B
AC44: DD 83          STD    $A1
AC46: B6 B6 60       LDA    $3448
AC49: 20 94          BRA    $AC67
AC4B: B6 1C 0F       LDA    $3427
AC4E: 81 8B          CMPA   #$03
AC50: 25 20          BCS    $AC54
AC52: 86 81          LDA    #$03
AC54: 97 6A          STA    $48
AC56: 10 8E DB 07    LDY    #$F32F
AC5A: 48             ASLA
AC5B: EC 8E          LDD    A,Y
AC5D: BB BC C9       ADDA   $3441
AC60: FB 16 C0       ADDB   $3442
AC63: DD 83          STD    $A1
AC65: 96 CA          LDA    $48
AC67: C6 2F          LDB    #$07
AC69: 3D             MUL
AC6A: 10 8E F2 DD    LDY    #$DAF5
AC6E: 31 2D          LEAY   B,Y
AC70: CE 14 9E       LDU    #$361C
AC73: BD A4 CC       JSR    $86EE
AC76: BD 31 50       JSR    $B378
AC79: BD 3A B7       JSR    $B23F
AC7C: BD 9A 7C       JSR    $B2F4
AC7F: 96 EA          LDA    $C8
AC81: 85 92          BITA   #$10
AC83: 26 73          BNE    $ACD6
AC85: 8E B2 22       LDX    #$30A0
AC88: BD 78 BD       JSR    $5035
AC8B: 10 8E DB B7    LDY    #$F33F
AC8F: C6 29          LDB    #$0B
AC91: A6 1A 81       LDA    [$03,X]		; [video_address]
AC94: A1 82          CMPA   ,Y+
AC96: 27 87          BEQ    $AC9D
AC98: 5A             DECB
AC99: 26 71          BNE    $AC94
AC9B: 20 5D          BRA    $AD12
AC9D: 96 40          LDA    $C8
AC9F: 8A 32          ORA    #$10
ACA1: 97 4A          STA    $C8
ACA3: 10 8E D1 C8    LDY    #$F34A
ACA7: C6 2C          LDB    #$04
ACA9: A6 10 8B       LDA    [$03,X]		; [video_address]
ACAC: A1 88          CMPA   ,Y+
ACAE: 27 8D          BEQ    $ACB5
ACB0: 5A             DECB
ACB1: 26 7B          BNE    $ACAC
ACB3: 20 2A          BRA    $ACBD
ACB5: 86 83          LDA    #$01
ACB7: 97 E3          STA    $CB
ACB9: 86 D1          LDA    #$59
ACBB: 97 89          STA    $A1
ACBD: 4F             CLRA
ACBE: BD C6 91       JSR    force_queue_sound_event_4eb3
ACC1: 86 B4          LDA    #$36
ACC3: 0D EB          TST    $C9
ACC5: 27 80          BEQ    $ACC9
ACC7: 86 1F          LDA    #$37
ACC9: BD C6 3B       JSR    force_queue_sound_event_4eb3
ACCC: DC 89          LDD    $A1
ACCE: 80 8E          SUBA   #$06
ACD0: FD 10 83       STD    $3201
ACD3: 7F 10 42       CLR    $3260
ACD6: 7A B6 79       DEC    $3451
ACD9: 26 A0          BNE    $AD03
ACDB: 8E 18 88       LDX    #$30A0
ACDE: EC 89          LDD    $1,X
ACE0: BB 16 D2       ADDA   $3450
ACE3: CB 20          ADDB   #$02
ACE5: ED 83          STD    $1,X
ACE7: 10 8E F3 A5    LDY    #$DB2D
ACEB: CE 1E 34       LDU    #$361C
ACEE: BD 0E CC       JSR    $86EE
ACF1: BD 31 FA       JSR    $B378
ACF4: B6 16 D2       LDA    $3450
ACF7: 81 D5          CMPA   #$FD
ACF9: 27 80          BEQ    $AD03
ACFB: 7A 1C 78       DEC    $3450
ACFE: 86 8C          LDA    #$04
AD00: B7 16 D3       STA    $3451
AD03: F6 16 72       LDB    $3450
AD06: C1 7F          CMPB   #$FD
AD08: 26 20          BNE    $AD12
AD0A: 85 80          BITA   #$08
AD0C: 27 2C          BEQ    $AD12
AD0E: 85 A8          BITA   #$20
AD10: 27 6E          BEQ    $AD5E
AD12: B6 B6 06       LDA    $3424
AD15: B1 B6 A7       CMPA   $3425
AD18: 26 64          BNE    $AD66
AD1A: 96 40          LDA    $C8
AD1C: 85 68          BITA   #$40
AD1E: 27 8D          BEQ    $AD25
AD20: B6 16 C8       LDA    $344A
AD23: 20 20          BRA    $AD27
AD25: 86 8B          LDA    #$09
AD27: B1 1C 00       CMPA   $3428
AD2A: 26 80          BNE    $AD34
AD2C: 96 E0          LDA    $C8
AD2E: 8A 80          ORA    #$08
AD30: 8A 26          ORA    #$04
AD32: 97 4A          STA    $C8
AD34: B6 16 A5       LDA    $3427
AD37: 81 D7          CMPA   #$FF
AD39: 26 84          BNE    $AD47
AD3B: B6 1C 00       LDA    $3428
AD3E: 4A             DECA
AD3F: B7 16 05       STA    $3427
AD42: 86 96          LDA    #$14
AD44: B7 16 A6       STA    $3424
AD47: 7C 1C 0F       INC    $3427
AD4A: 7C BC 00       INC    $3428
AD4D: 7F BC AD       CLR    $3425
AD50: B6 16 A5       LDA    $3427
AD53: 81 26          CMPA   #$04
AD55: 26 84          BNE    $AD5D
AD57: D6 E0          LDB    $C8
AD59: C8 C8          EORB   #$40
AD5B: D7 E0          STB    $C8
AD5D: 39             RTS

AD5E: 0D 43          TST    $CB
AD60: 27 20          BEQ    $AD64
AD62: 0C AA          INC    event_sub_state_28
AD64: 0C 0A          INC    event_sub_state_28
AD66: 39             RTS

AD67: 96 E1          LDA    $C9
AD69: 85 89          BITA   #$01
AD6B: 26 00          BNE    $AD95
AD6D: 8E BA A8       LDX    #$3220
AD70: 86 20          LDA    #$02
AD72: A7 8F          STA    $D,X
AD74: BD A1 05       JSR    $8387
AD77: 10 8E 18 13    LDY    #$309B
AD7B: CC 28 28       LDD    #$0000
AD7E: ED 29          STD    ,Y++
AD80: FC 16 AF       LDD    $342D
AD83: ED 83          STD    ,Y++
AD85: B6 B6 AD       LDA    $342F
AD88: A7 8C          STA    ,Y
AD8A: BD DC 4E       JSR    $5466
AD8D: 96 40          LDA    $C8
AD8F: 84 DF          ANDA   #$FD
AD91: 97 4A          STA    $C8
AD93: 0C 0A          INC    event_sub_state_28
AD95: 0C AA          INC    event_sub_state_28
AD97: 39             RTS

AD98: 86 29          LDA    #$01
AD9A: 97 43          STA    $CB
AD9C: 8E 18 28       LDX    #$30A0
AD9F: BD 72 17       JSR    $5035
ADA2: A6 1A 21       LDA    [$03,X]		; [video_address]
ADA5: C6 85          LDB    #$07
ADA7: 8E DB 66       LDX    #$F34E
ADAA: A1 08          CMPA   ,X+
ADAC: 27 2D          BEQ    $ADB3
ADAE: 5A             DECB
ADAF: 26 DB          BNE    $ADAA
ADB1: 20 80          BRA    $ADB5
ADB3: 0C E9          INC    $CB
ADB5: 96 4A          LDA    $C8
ADB7: 85 29          BITA   #$01
ADB9: 27 EE          BEQ    $AE21
ADBB: 10 8E 1B 08    LDY    #$3380
ADBF: 86 2D          LDA    #$0F
ADC1: D6 9B          LDB    $19
ADC3: 3D             MUL
ADC4: 31 89          LEAY   D,Y
ADC6: 96 E8          LDA    $6A
ADC8: C6 2D          LDB    #$05
ADCA: 3D             MUL
ADCB: 31 83          LEAY   D,Y
ADCD: 6D AA          TST    $2,Y
ADCF: 26 36          BNE    $ADE5
ADD1: EC B9          LDD    -$5,Y
ADD3: ED 86          STD    ,Y
ADD5: EC BF          LDD    -$3,Y
ADD7: ED 0A          STD    $2,Y
ADD9: A6 B7          LDA    -$1,Y
ADDB: A7 0C          STA    $4,Y
ADDD: EC AA          LDD    $2,Y
ADDF: 10 83 22 82    CMPD   #$0000
ADE3: 27 1E          BEQ    $AE21
ADE5: B6 B6 AE       LDA    $342C
ADE8: 4A             DECA
ADE9: 81 9D          CMPA   #$15
ADEB: 24 2D          BCC    $ADF2
ADED: C6 8D          LDB    #$05
ADEF: 3D             MUL
ADF0: 20 25          BRA    $ADF9
ADF2: 80 96          SUBA   #$14
ADF4: C6 20          LDB    #$02
ADF6: 3D             MUL
ADF7: CB 4C          ADDB   #$64
ADF9: 1F 10          TFR    B,A
ADFB: C6 2B          LDB    #$03
ADFD: BD 2E 8E       JSR    $A606
AE00: 1F BA          TFR    B,A
AE02: C6 88          LDB    #$0A
AE04: BD 84 84       JSR    $A606
AE07: 48             ASLA
AE08: 48             ASLA
AE09: 48             ASLA
AE0A: 48             ASLA
AE0B: 97 B1          STA    $99
AE0D: 1F 10          TFR    B,A
AE0F: C6 28          LDB    #$0A
AE11: BD 24 84       JSR    $A606
AE14: 97 BA          STA    $98
AE16: 58             ASLB
AE17: 58             ASLB
AE18: 58             ASLB
AE19: 58             ASLB
AE1A: DA 10          ORB    $98
AE1C: D7 B0          STB    $98
AE1E: BD F7 28       JSR    $7F0A
AE21: 8E B0 A2       LDX    #$3220
AE24: 6D A6          TST    ,X
AE26: 27 85          BEQ    $AE2F
AE28: 86 29          LDA    #$01
AE2A: A7 85          STA    $D,X
AE2C: BD AB 0F       JSR    $8387
AE2F: 96 EA          LDA    $C8
AE31: 8A 80          ORA    #$02
AE33: 97 EA          STA    $C8
AE35: 86 01          LDA    #$83
AE37: 8E 07 3F       LDX    #$2F17
AE3A: D6 E2          LDB    $6A
AE3C: 5C             INCB
AE3D: A7 0D          STA    B,X	; [video_address]
AE3F: 86 A0          LDA    #$82
AE41: BD CC 31       JSR    force_queue_sound_event_4eb3
AE44: 86 DD          LDA    #$FF
AE46: BD CC 9B       JSR    force_queue_sound_event_4eb3
AE49: 7F BC DE       CLR    $3456
AE4C: 0C 00          INC    event_sub_state_28
AE4E: 39             RTS

AE4F: 96 EA          LDA    $C8
AE51: 8A 83          ORA    #$01
AE53: 97 EA          STA    $C8
AE55: 8E B6 6A       LDX    #$34E8
AE58: 96 31          LDA    $19
AE5A: 48             ASLA
AE5B: DE E0          LDU    $C8
AE5D: EF 0E          STU    A,X
AE5F: 8E 17 2A       LDX    #$3508
AE62: 96 9B          LDA    $19
AE64: C6 02          LDB    #$20
AE66: 3D             MUL
AE67: 30 A3          LEAX   D,X
AE69: FC BC A5       LDD    $342D
AE6C: ED A9          STD    ,X++
AE6E: B6 BC 0D       LDA    $342F
AE71: A7 02          STA    ,X+
AE73: B6 16 74       LDA    $3456
AE76: A7 06          STA    ,X
AE78: 96 8A          LDA    $A2
AE7A: 80 98          SUBA   #$10
AE7C: B1 1A EA       CMPA   $3262
AE7F: 24 30          BCC    $AE93
AE81: 8B A2          ADDA   #$20
AE83: B1 10 40       CMPA   $3262
AE86: 25 89          BCS    $AE93
AE88: B6 1A EA       LDA    $3262
AE8B: 8B 3E          ADDA   #$16
AE8D: 97 2A          STA    $A2
AE8F: 86 23          LDA    #$01
AE91: 97 49          STA    $CB
AE93: B6 16 74       LDA    $3456
AE96: 27 BE          BEQ    $AED4
AE98: 10 8E B0 DA    LDY    #$3852
AE9C: 8E 1C A5       LDX    #$342D
AE9F: 86 21          LDA    #$03
AEA1: BD 24 43       JSR    $A6C1
AEA4: 4D             TSTA
AEA5: 2A A6          BPL    $AECB
AEA7: 10 8E DB E2    LDY    #$F36A
AEAB: B6 1C 7E       LDA    $3456
AEAE: 81 8D          CMPA   #$05
AEB0: 25 20          BCS    $AEB4
AEB2: 86 86          LDA    #$04
AEB4: A6 84          LDA    A,Y
AEB6: B7 B6 CE       STA    $34E6
AEB9: 7C BC 6F       INC    $34E7
AEBC: 8E DB D0       LDX    #$F358
AEBF: A6 A2          LDA    ,X+
AEC1: BD CC 31       JSR    force_queue_sound_event_4eb3
AEC4: A6 A2          LDA    ,X+
AEC6: 4D             TSTA
AEC7: 26 D0          BNE    $AEC1
AEC9: 20 81          BRA    $AED4
AECB: 7F 1C 7E       CLR    $3456
AECE: 7F BC C4       CLR    $34E6
AED1: 7F B6 65       CLR    $34E7
AED4: 86 23          LDA    #$01
AED6: B7 B0 48       STA    $3260
AED9: 0F A0          CLR    event_sub_state_28
AEDB: 0F 02          CLR    event_sub_state_2a
AEDD: 0C AE          INC    $26
AEDF: 39             RTS

AEE0: 96 21          LDA    $03
AEE2: C6 88          LDB    #$0A
AEE4: BD 84 84       JSR    $A606
AEE7: F7 0F 35       STB    $271D
AEEA: B7 AF 36       STA    $271E
AEED: 86 82          LDA    #$0A
AEEF: 1F AB          TFR    A,B
AEF1: FD AD 9F       STD    $2F1D
AEF4: 39             RTS

AEF5: 10 8E B2 B3    LDY    #$309B
AEF9: CC 9E 97       LDD    #$161F
AEFC: ED 89          STD    ,Y++
AEFE: CC AD 3E       LDD    #$251C
AF01: ED 26          STD    ,Y
AF03: 39             RTS

AF04: BD AB 8D       JSR    $890F
AF07: 0C 31          INC    $19
AF09: A6 CC          LDA    $4,U
AF0B: 84 D8          ANDA   #$F0
AF0D: 9A 91          ORA    $19
AF0F: A7 66          STA    $4,U
AF11: 20 87          BRA    $AF18
AF13: BD AB 69       JSR    $894B
AF16: 0C 9B          INC    $19
AF18: A6 EC          LDA    ,U
AF1A: 84 78          ANDA   #$F0
AF1C: 9A 31          ORA    $19
AF1E: A7 4C          STA    ,U
AF20: 0A 3B          DEC    $19
AF22: 39             RTS

AF23: 96 4B          LDA    current_event_69
AF25: 81 86          CMPA   #$04
AF27: 27 2D          BEQ    $AF2E
AF29: BD DA 07       JSR    $528F
AF2C: 20 22          BRA    $AF38
AF2E: 8E BB A8       LDX    #$338A
AF31: 96 9B          LDA    $19
AF33: C6 2D          LDB    #$0F
AF35: 3D             MUL
AF36: 30 09          LEAX   D,X
AF38: 10 8E B0 88    LDY    #$3800
AF3C: 86 08          LDA    #$20
AF3E: D6 E1          LDB    current_event_69
AF40: 3D             MUL
AF41: 31 29          LEAY   D,Y
AF43: 10 9F 73       STY    $51
AF46: 31 2A 38       LEAY   $10,Y
AF49: CE BB E8       LDU    #$3360
AF4C: 96 31          LDA    $19
AF4E: C6 8B          LDB    #$03
AF50: 3D             MUL
AF51: 33 47          LEAU   B,U
AF53: 86 21          LDA    #$03
AF55: 97 D2          STA    $50
AF57: BD 7A 23       JSR    $520B
AF5A: 5D             TSTB
AF5B: 27 02          BEQ    $AF87
AF5D: EC 2C          LDD    ,Y
AF5F: ED 0A          STD    $8,Y
AF61: EC A0          LDD    $2,Y
AF63: ED 08          STD    $A,Y
AF65: EC A6          LDD    $4,Y
AF67: ED 04          STD    $C,Y
AF69: EC AE          LDD    $6,Y
AF6B: ED 06          STD    $E,Y
AF6D: EC 0C          LDD    ,X
AF6F: ED 86          STD    ,Y
AF71: EC 80          LDD    $2,X
AF73: ED 00          STD    $2,Y
AF75: A6 86          LDA    $4,X
AF77: A7 0C          STA    $4,Y
AF79: EC 4C          LDD    ,U
AF7B: ED 0D          STD    $5,Y
AF7D: A6 CA          LDA    $2,U
AF7F: A7 05          STA    $7,Y
AF81: 31 BA          LEAY   -$8,Y
AF83: 0A 72          DEC    $50
AF85: 26 52          BNE    $AF57
AF87: 96 78          LDA    $50
AF89: 4C             INCA
AF8A: 81 8C          CMPA   #$04
AF8C: 24 35          BCC    $AFAB
AF8E: 10 8E 11 D6    LDY    #$33F4
AF92: 6D 22          TST    ,Y+
AF94: 26 2D          BNE    $AFA5
AF96: A1 BC          CMPA   -$2,Y
AF98: 22 2B          BHI    $AF9D
AF9A: 4C             INCA
AF9B: 20 D1          BRA    $AF96
AF9D: 81 8C          CMPA   #$04
AF9F: 24 28          BCC    $AFAB
AFA1: A7 BD          STA    -$1,Y
AFA3: 20 24          BRA    $AFAB
AFA5: 10 8C B1 DF    CMPY   #$33F7
AFA9: 26 6F          BNE    $AF92
AFAB: BD 7F 2B       JSR    $5703
AFAE: 39             RTS

AFAF: 34 32          PSHS   X
AFB1: 8E B4 82       LDX    #$3600
AFB4: CC DA 7A       LDD    #$F8F8
AFB7: ED A9          STD    ,X++
AFB9: 8C BE 00       CMPX   #$3688
AFBC: 26 DE          BNE    $AFB4
AFBE: 35 98          PULS   X
AFC0: 39             RTS

AFC1: 34 92          PSHS   X
AFC3: 8E 14 E2       LDX    #$36C0
AFC6: CC 82 28       LDD    #$0000
AFC9: ED 09          STD    ,X++
AFCB: 8C 1F 28       CMPX   #$3700
AFCE: 26 7E          BNE    $AFC6
AFD0: 35 32          PULS   X
AFD2: 39             RTS

AFD3: C6 02          LDB    #$20
AFD5: 7E 2D 62       JMP    $AFE0
AFD8: C6 08          LDB    #$20
AFDA: 96 87          LDA    $0F
AFDC: 84 24          ANDA   #$0C
AFDE: 44             LSRA
AFDF: 44             LSRA
AFE0: A7 82          STA    ,Y+		; [video_address]
AFE2: 5A             DECB
AFE3: 26 D9          BNE    $AFE0
AFE5: 39             RTS

AFE6: C6 81          LDB    #$03
AFE8: 96 27          LDA    $0F
AFEA: 84 84          ANDA   #$0C
AFEC: 44             LSRA
AFED: 44             LSRA
AFEE: A7 28          STA    ,Y+
AFF0: 5A             DECB
AFF1: 26 79          BNE    $AFEE
AFF3: 39             RTS

AFF4: A6 A2          LDA    ,X+
AFF6: C6 88          LDB    #$0A
AFF8: 3D             MUL
AFF9: EB 08          ADDB   ,X+
AFFB: 86 22          LDA    #$0A
AFFD: 3D             MUL
AFFE: EB 08          ADDB   ,X+
B000: 86 28          LDA    #$0A
B002: 3D             MUL
B003: EB A2          ADDB   ,X+
B005: 89 82          ADCA   #$00
B007: 39             RTS

B008: A6 A8          LDA    ,X+
B00A: A7 28          STA    ,Y+
B00C: 6F 81 8F 77    CLR    $07FF,Y
B010: 5A             DECB
B011: 26 77          BNE    $B008
B013: 39             RTS

B014: 34 32          PSHS   X
B016: 86 8B          LDA    #$09
B018: 97 60          STA    $48
B01A: 33 00 38       LEAU   $10,X
B01D: BD D8 17       JSR    $509F
B020: 8E 12 32       LDX    #$30B0
B023: 10 8E 12 D2    LDY    #$3050
B027: BD 8E E9       JSR    $A6C1
B02A: 81 89          CMPA   #$01
B02C: 26 20          BNE    $B036
B02E: DC D8          LDD    $50
B030: DD 92          STD    speed_msb_b0
B032: DC D0          LDD    $52
B034: DD 90          STD    $B2
B036: 35 92          PULS   X
B038: 39             RTS

B039: 96 87          LDA    $0F
B03B: 85 2B          BITA   #$03
B03D: 26 DE          BNE    $B095
B03F: 7D 16 D4       TST    $34F6
B042: 26 86          BNE    $B048
B044: 85 25          BITA   #$07
B046: 26 CF          BNE    $B095
B048: 96 89          LDA    $A1
B04A: 97 C0          STA    $48
B04C: FC 1C 7D       LDD    $34F5
B04F: 5D             TSTB
B050: 27 3B          BEQ    $B06B
B052: 10 8E F8 61    LDY    #$DA43
B056: BB B6 DE       ADDA   $34F6
B059: 97 29          STA    $A1
B05B: 5A             DECB
B05C: 26 2A          BNE    $B060
B05E: C6 77          LDB    #$FF
B060: C1 DB          CMPB   #$F9
B062: 26 93          BNE    $B075
B064: 10 8E 58 BD    LDY    #$DA3F
B068: 5F             CLRB
B069: 20 82          BRA    $B075
B06B: 96 89          LDA    $A1
B06D: 80 8B          SUBA   #$03
B06F: C6 24          LDB    #$06
B071: 10 8E 58 1D    LDY    #$DA3F
B075: FD B6 77       STD    $34F5
B078: CE 1E 94       LDU    #$361C
B07B: 8E 18 88       LDX    #$30A0
B07E: BD 0E CC       JSR    $86EE
B081: CE B4 DA       LDU    #$3658
B084: 10 8E 58 C5    LDY    #$DA47
B088: 96 60          LDA    $48
B08A: 80 83          SUBA   #$0B
B08C: A7 29          STA    $1,X
B08E: BD 01 2D       JSR    $890F
B091: 96 CA          LDA    $48
B093: A7 23          STA    $1,X
B095: 39             RTS

B096: 86 88          LDA    #$0A
B098: 97 60          STA    $48
B09A: CE BE 04       LDU    #$362C
B09D: 8E BC C8       LDX    #$3440
B0A0: A6 82          LDA    ,Y+
B0A2: BB B6 0B       ADDA   $3429
B0A5: A7 83          STA    $1,X
B0A7: F6 1C 02       LDB    $342A
B0AA: 96 40          LDA    $C8
B0AC: 84 68          ANDA   #$40
B0AE: 26 8C          BNE    $B0B4
B0B0: E0 82          SUBB   ,Y+
B0B2: 20 86          BRA    $B0B8
B0B4: EB 82          ADDB   ,Y+
B0B6: C0 8A          SUBB   #$08
B0B8: E7 2A          STB    $2,X
B0BA: C6 C8          LDB    #$40
B0BC: 96 E0          LDA    $C8
B0BE: 84 C8          ANDA   #$40
B0C0: 27 2B          BEQ    $B0CB
B0C2: A6 22          LDA    ,Y+
B0C4: 80 24          SUBA   #$06
B0C6: 40             NEGA
B0C7: 8B 2E          ADDA   #$06
B0C9: 20 8A          BRA    $B0CD
B0CB: A6 88          LDA    ,Y+
B0CD: 81 8F          CMPA   #$07
B0CF: 25 2E          BCS    $B0DD
B0D1: 80 8E          SUBA   #$0C
B0D3: 40             NEGA
B0D4: F6 16 C0       LDB    $3442
B0D7: C0 20          SUBB   #$08
B0D9: F7 BC CA       STB    $3442
B0DC: 5F             CLRB
B0DD: 80 8E          SUBA   #$06
B0DF: 40             NEGA
B0E0: 8B C2          ADDA   #$E0
B0E2: 0D 80          TST    $02
B0E4: 27 20          BEQ    $B0E8
B0E6: C8 C2          EORB   #$40
B0E8: DD 61          STD    $49
B0EA: BD 01 63       JSR    $894B
B0ED: DC C1          LDD    $49
B0EF: E7 E3          STB    ,U++
B0F1: A7 43          STA    ,U++
B0F3: 96 6A          LDA    $48
B0F5: 46             RORA
B0F6: 24 85          BCC    $B0FF
B0F8: FA DC 19       ORB    $F491
B0FB: E7 74          STB    -$4,U
B0FD: 20 8D          BRA    $B104
B0FF: FA D6 B0       ORB    $F492
B102: E7 DE          STB    -$4,U
B104: 0A 6A          DEC    $48
B106: 26 1A          BNE    $B0A0
B108: 39             RTS

B109: FC BC AF       LDD    $3427
B10C: 58             ASLB
B10D: 8E 7B E7       LDX    #$F36F
B110: 10 AE 07       LDY    B,X
B113: 81 DD          CMPA   #$FF
B115: 26 87          BNE    $B11C
B117: 8E 1C 74       LDX    #$345C
B11A: 20 8B          BRA    $B11F
B11C: 48             ASLA
B11D: AE 0E          LDX    A,X
B11F: 96 2D          LDA    $0F
B121: 46             RORA
B122: 24 85          BCC    $B12B
B124: CE 16 82       LDU    #$3400
B127: 86 3D          LDA    #$15
B129: 20 83          BRA    $B136
B12B: 30 A0 3D       LEAX   $15,X
B12E: 31 20 37       LEAY   $15,Y
B131: CE B6 97       LDU    #$3415
B134: 86 2B          LDA    #$09
B136: 97 CA          STA    $48
B138: 0F 61          CLR    $49
B13A: E6 28          LDB    ,Y+
B13C: E0 AC          SUBB   ,X
B13E: 27 A0          BEQ    $B168
B140: 2A 21          BPL    $B145
B142: 50             NEGB
B143: 0C 6B          INC    $49
B145: B6 B6 A7       LDA    $3425
B148: 3D             MUL
B149: 34 98          PSHS   X
B14B: BE 1C 0B       LDX    $3423
B14E: 9F C2          STX    $4A
B150: 0F 68          CLR    $4A
B152: 9E C8          LDX    $4A
B154: BD 84 A9       JSR    $A62B
B157: 58             ASLB
B158: F1 1C AC       CMPB   $3424
B15B: 25 2A          BCS    $B15F
B15D: 30 89          LEAX   $1,X
B15F: 1F 32          TFR    X,D
B161: 35 92          PULS   X
B163: 0D 6B          TST    $49
B165: 27 83          BEQ    $B168
B167: 50             NEGB
B168: EB A8          ADDB   ,X+
B16A: E7 48          STB    ,U+
B16C: 0A 60          DEC    $48
B16E: 26 40          BNE    $B138
B170: 39             RTS

B171: 6D 06          TST    ,X
B173: 27 23          BEQ    $B176
B175: 39             RTS

B176: EC 81          LDD    $3,X
B178: C3 28 C8       ADDD   #$0040
B17B: ED 2B          STD    $3,X
B17D: 86 C9          LDA    #$41
B17F: 8C 10 62       CMPX   #$3240
B182: 27 80          BEQ    $B186
B184: 86 51          LDA    #$73
B186: A1 1A 2B       CMPA   [$03,X]		; [video_address]
B189: 27 89          BEQ    $B18C
B18B: 39             RTS

B18C: 6C AC          INC    ,X
B18E: A6 8A          LDA    $2,X
B190: A0 AA 99       SUBA   $1B,X
B193: 8C 10 62       CMPX   #$3240
B196: 26 86          BNE    $B19C
B198: 8B 2B          ADDA   #$03
B19A: 20 8A          BRA    $B19E
B19C: 8B 2D          ADDA   #$05
B19E: A7 8A          STA    $2,X
l_b1a0:
B1A0: 6D A6          TST    ,X
B1A2: 10 27 22 BA    LBEQ   $B23E
B1A6: 10 8E F6 1A    LDY    #$DE32
B1AA: 8C BA 48       CMPX   #$3260
B1AD: 26 85          BNE    $B1BC
B1AF: CE 14 22       LDU    #$3600
B1B2: B6 B6 12       LDA    $3430
B1B5: 80 92          SUBA   #$10
B1B7: A7 29          STA    $1,X
B1B9: BD 01 C3       JSR    $894B
B1BC: CE 1E E0       LDU    #$3668
B1BF: 8C 10 62       CMPX   #$3240
B1C2: 27 81          BEQ    $B1C7
B1C4: CE 14 86       LDU    #$3604
B1C7: B6 1C 18       LDA    $3430
B1CA: A7 89          STA    $1,X
B1CC: BD A0 15       JSR    $889D
B1CF: 33 6A          LEAU   $8,U
B1D1: A6 83          LDA    $1,X
B1D3: 8B 02          ADDA   #$20
B1D5: A7 83          STA    $1,X
B1D7: BD A1 63       JSR    $894B
B1DA: 33 CC          LEAU   $4,U
B1DC: B6 1C BC       LDA    $3434
B1DF: 8C 10 62       CMPX   #$3240
B1E2: 27 81          BEQ    $B1E7
B1E4: B6 16 BA       LDA    $3438
B1E7: A7 29          STA    $1,X
B1E9: BD 01 C3       JSR    $894B
B1EC: 33 6C          LEAU   $4,U
B1EE: B6 BC 14       LDA    $3436
B1F1: 8C B0 C2       CMPX   #$3240
B1F4: 27 21          BEQ    $B1F9
B1F6: B6 B6 12       LDA    $343A
B1F9: A7 89          STA    $1,X
B1FB: BD A1 63       JSR    $894B
B1FE: CE BE 3A       LDU    #$3618
B201: 10 8E 5C 17    LDY    #$DE35
B205: B6 B6 BC       LDA    $343E
B208: 8C 1A C8       CMPX   #$3240
B20B: 26 3E          BNE    $B223
B20D: B6 BC B4       LDA    $343C
B210: CE 14 E6       LDU    #$3664
B213: CB 20          ADDB   #$02
B215: A7 83          STA    $1,X
B217: 6C 2A          INC    $2,X
B219: 6C 8A          INC    $2,X
B21B: BD A1 63       JSR    $894B
B21E: 6A 8A          DEC    $2,X
B220: 6A 20          DEC    $2,X
B222: 39             RTS

B223: A7 23          STA    $1,X
B225: A6 80          LDA    $2,X
B227: B7 1C 17       STA    $343F
B22A: 80 98          SUBA   #$10
B22C: A7 2A          STA    $2,X
B22E: B7 BA 80       STA    $32A2
B231: A6 83          LDA    $1,X
B233: B7 10 83       STA    $32A1
B236: BD 0B 63       JSR    $894B
B239: B6 BC B7       LDA    $343F
B23C: A7 2A          STA    $2,X
B23E: 39             RTS

B23F: 0D E9          TST    $CB
B241: 10 26 82 8C    LBNE   $B2F3
B245: 7D B0 C2       TST    $3240
B248: 10 27 88 2F    LBEQ   $B2F3
B24C: DC 89          LDD    $A1
B24E: CB 98          ADDB   #$10
B250: F0 10 20       SUBB   $32A2
B253: 25 0C          BCS    $B283
B255: C1 A2          CMPB   #$20
B257: 24 02          BCC    $B283
B259: 34 8C          PSHS   B
B25B: 8E DC BB       LDX    #$F493
B25E: F6 BC 6A       LDB    $3448
B261: C0 86          SUBB   #$04
B263: 58             ASLB
B264: 58             ASLB
B265: 58             ASLB
B266: 58             ASLB
B267: 58             ASLB
B268: 3A             ABX
B269: 35 8C          PULS   B
B26B: 50             NEGB
B26C: CB 37          ADDB   #$1F
B26E: 30 0D          LEAX   B,X
B270: E6 A6          LDB    ,X
B272: C1 A3          CMPB   #$21
B274: 27 2F          BEQ    $B283
B276: AB 06          ADDA   ,X
B278: B1 1A 29       CMPA   $32A1
B27B: 24 2E          BCC    $B283
B27D: 96 41          LDA    $C9
B27F: 8A 23          ORA    #$01
B281: 97 4B          STA    $C9
B283: DC 83          LDD    $A1
B285: B1 B0 23       CMPA   $32A1
B288: 24 67          BCC    $B2D9
B28A: CB 87          ADDB   #$0F
B28C: F1 1A 2A       CMPB   $32A2
B28F: 25 6A          BCS    $B2D9
B291: C0 9D          SUBB   #$1F
B293: F1 10 80       CMPB   $32A2
B296: 24 C3          BCC    $B2D9
B298: 8B 37          ADDA   #$1F
B29A: B1 BA 89       CMPA   $32A1
B29D: 25 B2          BCS    $B2D9
B29F: 34 26          PSHS   B
B2A1: F6 B6 CA       LDB    $3448
B2A4: C0 26          SUBB   #$04
B2A6: 8E 76 BB       LDX    #$F493
B2A9: 58             ASLB
B2AA: 58             ASLB
B2AB: 58             ASLB
B2AC: 58             ASLB
B2AD: 58             ASLB
B2AE: 3A             ABX
B2AF: 35 26          PULS   B
B2B1: F0 B0 20       SUBB   $32A2
B2B4: 50             NEGB
B2B5: 96 23          LDA    $A1
B2B7: 5A             DECB
B2B8: AB AD          ADDA   B,X
B2BA: B1 BA 89       CMPA   $32A1
B2BD: 24 92          BCC    $B2D9
B2BF: 96 EA          LDA    $C8
B2C1: 8A A2          ORA    #$20
B2C3: 97 EA          STA    $C8
B2C5: 86 83          LDA    #$01
B2C7: 97 E3          STA    $CB
B2C9: CC 8C 89       LDD    #$0401
B2CC: FD 1A 20       STD    $32A8
B2CF: 4F             CLRA
B2D0: BD 6C 31       JSR    force_queue_sound_event_4eb3
B2D3: 86 34          LDA    #$16
B2D5: BD CC 31       JSR    force_queue_sound_event_4eb3
B2D8: 39             RTS

B2D9: 96 40          LDA    $C8
B2DB: F6 1C 02       LDB    $342A
B2DE: 85 C8          BITA   #$40
B2E0: 26 2B          BNE    $B2EB
B2E2: F0 B6 3E       SUBB   $341C
B2E5: F1 B0 20       CMPB   $32A2
B2E8: 24 FD          BCC    $B2BF
B2EA: 39             RTS

B2EB: FB 1C 34       ADDB   $341C
B2EE: F1 BA 80       CMPB   $32A2
B2F1: 24 4E          BCC    $B2BF
B2F3: 39             RTS

B2F4: 8E 10 22       LDX    #$32A0
B2F7: 96 E0          LDA    $C8
B2F9: 84 A8          ANDA   #$20
B2FB: 27 4A          BEQ    $B35F
B2FD: 6A 81          DEC    $9,X
B2FF: 26 7C          BNE    $B35F
B301: A6 8A          LDA    $8,X
B303: 40             NEGA
B304: AB 23          ADDA   $1,X
B306: 6C 8A          INC    $8,X
B308: A7 29          STA    $1,X
B30A: 86 8B          LDA    #$03
B30C: A7 21          STA    $9,X
B30E: 6C 8A          INC    $2,X
B310: A6 23          LDA    $1,X
B312: 81 F2          CMPA   #$70
B314: 24 31          BCC    $B329
B316: 86 E1          LDA    #$63
B318: A7 29          STA    $1,X
B31A: 96 40          LDA    $C8
B31C: 88 08          EORA   #$20
B31E: 97 40          STA    $C8
B320: 4F             CLRA
B321: BD CC 31       JSR    force_queue_sound_event_4eb3
B324: 86 31          LDA    #$13
B326: BD CC 9B       JSR    force_queue_sound_event_4eb3
B329: 10 8E 56 1D    LDY    #$DE35
B32D: 5F             CLRB
B32E: A6 89          LDA    $1,X
B330: 81 5A          CMPA   #$78
B332: 24 87          BCC    $B339
B334: 81 AA          CMPA   #$88
B336: 24 80          BCC    $B33A
B338: 5C             INCB
B339: 5C             INCB
B33A: D7 C0          STB    $48
B33C: 58             ASLB
B33D: 10 8E 56 17    LDY    #$DE35
B341: 31 27          LEAY   B,Y
B343: CE 14 3A       LDU    #$3618
B346: BD 0B 63       JSR    $894B
B349: EC 89          LDD    $1,X
B34B: 9B 60          ADDA   $48
B34D: 9B C0          ADDA   $48
B34F: D7 6A          STB    $48
B351: C0 92          SUBB   #$10
B353: ED 23          STD    $1,X
B355: CE B4 E6       LDU    #$3664
B358: BD A1 C3       JSR    $894B
B35B: 96 60          LDA    $48
B35D: A7 8A          STA    $2,X
B35F: 39             RTS

B360: 8E 10 02       LDX    #$3280
B363: F6 16 08       LDB    $342A
B366: 86 E2          LDA    #$60
B368: ED 29          STD    $1,X
B36A: BD D8 1D       JSR    $5035
B36D: 4F             CLRA
B36E: C6 DB          LDB    #$53
B370: E1 BA 81       CMPB   [$03,X]		; [video_address]
B373: 26 20          BNE    $B377
B375: 86 83          LDA    #$01
B377: 39             RTS

B378: 34 18          PSHS   Y,X
B37A: 8E BA 28       LDX    #$3200
B37D: DC 29          LDD    $A1
B37F: E7 20          STB    $2,X
B381: F1 B0 20       CMPB   $32A2
B384: 25 2B          BCS    $B38F
B386: 7D B0 48       TST    $3260
B389: 27 8C          BEQ    $B38F
B38B: 86 48          LDA    #$60
B38D: A7 89          STA    $1,X
B38F: 31 06          LEAY   $4,Y
B391: CE B4 DA       LDU    #$3658
B394: BD AB 8D       JSR    $890F
B397: 35 18          PULS   X,Y
B399: 39             RTS

B39A: CE BE 04       LDU    #$362C
B39D: CC 88 70       LDD    #$00F8
B3A0: ED E3          STD    ,U++
B3A2: ED 43          STD    ,U++
B3A4: 11 83 B4 DE    CMPU   #$365C
B3A8: 26 DE          BNE    $B3A0
B3AA: 39             RTS

B3AB: 8E 18 88       LDX    #$30A0
B3AE: CE BE 3E       LDU    #$361C
B3B1: 10 8E 5B DF    LDY    #$D9FD
B3B5: BD 04 6C       JSR    $86EE
B3B8: CC F2 16       LDD    #$DA9E
B3BB: DD 83          STD    $AB
B3BD: EC 89          LDD    $1,X
B3BF: 80 2B          SUBA   #$09
B3C1: FD B0 83       STD    $3201
B3C4: 86 24          LDA    #$06
B3C6: B7 B0 2D       STA    $3205
B3C9: BD 3B F0       JSR    $B378
B3CC: EC 29          LDD    $1,X
B3CE: 8B 90          ADDA   #$18
B3D0: CB 61          ADDB   #$43
B3D2: FD B6 0B       STD    $3429
B3D5: 10 8E 71 AB    LDY    #$F383
B3D9: 7E 38 1E       JMP    $B096

weight_lifting_b3dc:
B3DC: 96 02          LDA    event_sub_state_2a
B3DE: 48             ASLA
B3DF: 8E D7 11       LDX   #table_f533
B3E2: 6E 14          JMP    [A,X]        ; [jump_table]

B3E4: 96 0E          LDA    $2C
B3E6: 8E 77 17       LDX   #table_f53f
B3E9: 48             ASLA
B3EA: 6E 1E          JMP    [A,X]        ; [jump_table]

B3EC: CC 29 88       LDD    #$0100
B3EF: BD 6C B8       JSR    queue_event_4e9a
B3F2: CC 80 2F       LDD    #$020D
B3F5: BD CC 18       JSR    queue_event_4e9a
B3F8: 96 40          LDA    current_level_68
B3FA: C6 8F          LDB    #$07
B3FC: BD 8E 8E       JSR    $A606
B3FF: C1 24          CMPB   #$06
B401: 25 80          BCS    $B405
B403: C6 27          LDB    #$05
B405: F7 B6 C0       STB    $3442
B408: 8E DD DF       LDX    #$F557
B40B: A6 AD          LDA    B,X
B40D: B7 BC B7       STA    $343F
B410: B7 16 B4       STA    $3436
B413: C6 02          LDB    #$20
B415: 3D             MUL
B416: 8E 77 55       LDX    #$F57D
B419: 30 03          LEAX   D,X
B41B: 10 8E 0B E8    LDY    #$2360
B41F: 86 13          LDA    #$31
B421: 97 CB          STA    $49
B423: 86 2A          LDA    #$08
B425: B0 B6 BD       SUBA   $343F
B428: 97 60          STA    $48
B42A: C6 A8          LDB    #$20
B42C: A6 A8          LDA    ,X+
B42E: 81 D0          CMPA   #$58
B430: 26 26          BNE    $B436
B432: 96 CB          LDA    $49
B434: 0C 6B          INC    $49
B436: 80 B2          SUBA   #$30
B438: A7 88          STA    ,Y+	; [video_address]
B43A: 6F 21 2F D7    CLR    $07FF,Y	; [video_address]
B43E: 5A             DECB
B43F: 26 C9          BNE    $B42C
B441: 96 CA          LDA    $48
B443: 4A             DECA
B444: 27 25          BEQ    $B44D
B446: 97 CA          STA    $48
B448: 31 80 A8       LEAY   $20,Y
B44B: 20 F5          BRA    $B42A
B44D: 0D 88          TST    game_playing_00
B44F: 26 2A          BNE    $B459
B451: 96 8D          LDA    $0F
B453: 85 1D          BITA   #$3F
B455: 26 86          BNE    $B45B
B457: 20 2B          BRA    $B45C
B459: 0C A4          INC    $2C
B45B: 39             RTS

B45C: 86 15          LDA    #$3D
B45E: B7 BC 7A       STA    $3458
B461: B7 B6 DB       STA    $3459
B464: B7 16 D8       STA    $345A
B467: 86 2D          LDA    #$05
B469: 97 A4          STA    $2C
B46B: 39             RTS

B46C: 10 8E 7D C7    LDY    #$F54F
B470: CE D7 D1       LDU    #$F553
B473: 96 20          LDA    $02
B475: 48             ASLA
B476: 31 24          LEAY   A,Y
B478: 33 EE          LEAU   A,U
B47A: 8E BE F8       LDX    #$36D0
B47D: EC 0C          LDD    ,X
B47F: 1E AB          EXG    A,B
B481: 10 A3 46       CMPD   ,U
B484: 27 18          BEQ    $B4C0
B486: A3 26          SUBD   ,Y
B488: 1E A1          EXG    A,B
B48A: ED 09          STD    ,X++
B48C: 8C 1E 78       CMPX   #$36F0
B48F: 27 24          BEQ    $B497
B491: EC 06          LDD    ,X
B493: 1E AB          EXG    A,B
B495: 20 6D          BRA    $B486
B497: 8E 1A 2A       LDX    #$3202
B49A: A6 0C          LDA    ,X
B49C: 8B 2C          ADDA   #$04
B49E: A7 0C          STA    ,X
B4A0: 30 AA 92       LEAX   $10,X
B4A3: 8C 10 C0       CMPX   #$32E2
B4A6: 26 70          BNE    $B49A
B4A8: 7D 1A 48       TST    $32C0
B4AB: 26 3A          BNE    $B4BF
B4AD: B6 BA 4A       LDA    $32C2
B4B0: 81 D2          CMPA   #$F0
B4B2: 25 8A          BCS    $B4BC
B4B4: 7C 10 42       INC    $32C0
B4B7: BD 87 87       JSR    $AFAF
B4BA: 20 8B          BRA    $B4BF
B4BC: BD 95 F6       JSR    $BD7E
B4BF: 39             RTS

B4C0: 4F             CLRA
B4C1: 5F             CLRB
B4C2: FD B6 0E       STD    $342C
B4C5: FD B6 AC       STD    $342E
B4C8: CC 03 E8       LDD    #$2B60
B4CB: FD 1C 1C       STD    $3434
B4CE: 86 86          LDA    #$0E
B4D0: B7 16 82       STA    $3400
B4D3: 4F             CLRA
B4D4: BD 6C 31       JSR    force_queue_sound_event_4eb3
B4D7: 86 0C          LDA    #$24
B4D9: BD C6 3B       JSR    force_queue_sound_event_4eb3
B4DC: BD 93 E8       JSR    $BB60
B4DF: 0C 0E          INC    $2C
B4E1: 39             RTS

B4E2: BD 3D FE       JSR    $BFDC
B4E5: BD CD 23       JSR    $4FA1
B4E8: 81 2C          CMPA   #$04
B4EA: 27 8E          BEQ    $B4F2
B4EC: 81 2A          CMPA   #$02
B4EE: 27 D3          BEQ    $B54B
B4F0: 20 1A          BRA    $B52A
B4F2: 10 BE 16 16    LDY    $3434
B4F6: 4F             CLRA
B4F7: BD 87 FB       JSR    $AFD3
B4FA: B6 BC 1E       LDA    $3436
B4FD: 81 8F          CMPA   #$07
B4FF: 27 66          BEQ    $B545
B501: 4C             INCA
B502: B7 B6 14       STA    $3436
B505: 81 85          CMPA   #$07
B507: 26 27          BNE    $B518
B509: B6 BC D7       LDA    $345F
B50C: B7 1C AC       STA    $3424
B50F: CC 20 24       LDD    #$0206
B512: FD B6 0F       STD    $342D
B515: 7F B6 A7       CLR    $3425
B518: 10 BE BC BC    LDY    $3434
B51C: 31 80 C8       LEAY   $40,Y
B51F: 10 BF 16 B6    STY    $3434
B523: 10 BE 16 B6    LDY    $3434
B527: BD 87 F0       JSR    $AFD8
B52A: BD DF B7       JSR    $579F
B52D: B6 BC 7A       LDA    $34F2
B530: 81 36          CMPA   #$14
B532: 27 95          BEQ    $B54B
B534: B1 16 82       CMPA   $3400
B537: 26 23          BNE    $B544
B539: 86 A8          LDA    #$20
B53B: BD 66 9B       JSR    force_queue_sound_event_4eb3
B53E: 7C BC 22       INC    $3400
B541: 7C B6 82       INC    $3400
B544: 39             RTS

B545: BD 37 39       JSR    $B5BB
B548: 7E 9D AB       JMP    $B523
B54B: B6 1C 1E       LDA    $3436
B54E: 81 8F          CMPA   #$07
B550: 27 3A          BEQ    $B56A
B552: 10 8E D7 47    LDY    #$F565
B556: C6 81          LDB    #$03
B558: 3D             MUL
B559: 31 2D          LEAY   B,Y
B55B: EC 89          LDD    ,Y++
B55D: FD BC A5       STD    $342D
B560: A6 86          LDA    ,Y
B562: B7 B6 0D       STA    $342F
B565: 86 A6          LDA    #$24
B567: BD 66 9B       JSR    force_queue_sound_event_4eb3
B56A: 86 2C          LDA    #$A4
B56C: BB 1C BE       ADDA   $3436
B56F: BD 6C 91       JSR    force_queue_sound_event_4eb3
B572: 81 2B          CMPA   #$A9
B574: 27 26          BEQ    $B57A
B576: 81 29          CMPA   #$AB
B578: 26 2D          BNE    $B57F
B57A: 86 22          LDA    #$AA
B57C: BD 66 3B       JSR    force_queue_sound_event_4eb3
B57F: 86 8E          LDA    #$AC
B581: BD CC 31       JSR    force_queue_sound_event_4eb3
B584: 86 DD          LDA    #$FF
B586: BD CC 9B       JSR    force_queue_sound_event_4eb3
B589: 86 96          LDA    #$1E
B58B: 97 05          STA    $2D
B58D: 0C A4          INC    $2C
B58F: 0C 0E          INC    $2C
B591: 39             RTS

B592: BD 3D FE       JSR    $BFDC
B595: BD CD 23       JSR    $4FA1
B598: 81 2C          CMPA   #$04
B59A: 27 97          BEQ    $B5BB
B59C: 81 2A          CMPA   #$02
B59E: 27 C0          BEQ    $B5E8
B5A0: BD 75 1D       JSR    $579F
B5A3: B6 16 D0       LDA    $34F2
B5A6: 81 96          CMPA   #$14
B5A8: 27 16          BEQ    $B5E8
B5AA: B1 BC 28       CMPA   $3400
B5AD: 26 83          BNE    $B5BA
B5AF: 86 02          LDA    #$20
B5B1: BD CC 31       JSR    force_queue_sound_event_4eb3
B5B4: 7C 16 82       INC    $3400
B5B7: 7C 1C 28       INC    $3400
B5BA: 39             RTS

B5BB: B6 1C 05       LDA    $342D
B5BE: 81 8C          CMPA   #$04
B5C0: 27 DA          BEQ    $B5BA
B5C2: 86 87          LDA    #$05
B5C4: 97 6A          STA    $48
B5C6: CE B6 04       LDU    #$342C
B5C9: BD D8 17       JSR    $509F
B5CC: 86 2F          LDA    #$07
B5CE: B0 BC 60       SUBA   $3442
B5D1: C6 C2          LDB    #$40
B5D3: 3D             MUL
B5D4: 10 8E A1 F1    LDY    #$2373
B5D8: 31 83          LEAY   D,Y
B5DA: FC BC 05       LDD    $342D
B5DD: ED 29          STD    ,Y++
B5DF: B6 16 0D       LDA    $342F
B5E2: A7 26          STA    ,Y
B5E4: 7C 16 A6       INC    $3424
B5E7: 39             RTS

B5E8: 86 0C          LDA    #$24
B5EA: BD C6 9B       JSR    force_queue_sound_event_4eb3
B5ED: 7F BC AD       CLR    $3425
B5F0: 0C 0E          INC    $2C
B5F2: 0C AE          INC    $2C
B5F4: 0C 0E          INC    $2C
B5F6: 39             RTS

B5F7: BD 97 F4       JSR    $BFDC
B5FA: 0A A5          DEC    $2D
B5FC: 26 2C          BNE    $B602
B5FE: 0C A4          INC    $2C
B600: 0C 0E          INC    $2C
B602: 39             RTS

B603: BD 9D FE       JSR    $BFDC
B606: 10 8E DD 67    LDY    #$F54F
B60A: CE 7D 7B       LDU    #$F553
B60D: 96 8A          LDA    $02
B60F: 48             ASLA
B610: 31 84          LEAY   A,Y
B612: 33 44          LEAU   A,U
B614: 8E 14 52       LDX    #$36D0
B617: EC AC          LDD    ,X
B619: 1E 01          EXG    A,B
B61B: 10 83 28 88    CMPD   #$0000
B61F: 10 27 22 DF    LBEQ   $B680
B623: E3 86          ADDD   ,Y
B625: 1E 0B          EXG    A,B
B627: ED A9          STD    ,X++
B629: 8C BE 78       CMPX   #$36F0
B62C: 27 2E          BEQ    $B634
B62E: EC 0C          LDD    ,X
B630: 1E AB          EXG    A,B
B632: 20 6D          BRA    $B623
B634: 8E 10 80       LDX    #$3202
B637: A6 AC          LDA    ,X
B639: 80 8C          SUBA   #$04
B63B: A7 AC          STA    ,X
B63D: 30 00 98       LEAX   $10,X
B640: 8C 10 60       CMPX   #$32E2
B643: 26 D0          BNE    $B637
B645: 7D B0 42       TST    $32C0
B648: 27 24          BEQ    $B656
B64A: B6 BA EA       LDA    $32C2
B64D: 44             LSRA
B64E: 44             LSRA
B64F: 81 1E          CMPA   #$3C
B651: 26 84          BNE    $B659
B653: 7F 10 E2       CLR    $32C0
B656: BD 3F 56       JSR    $BD7E
B659: BD C7 29       JSR    $4FA1
B65C: 81 2A          CMPA   #$02
B65E: 27 89          BEQ    $B661
B660: 39             RTS

B661: 7C B6 E2       INC    $3460
B664: 39             RTS

B665: CC 82 82       LDD    #$0000
B668: FD 1C 7A       STD    $34F2
B66B: 0C 04          INC    $2C
B66D: 0D 88          TST    game_playing_00
B66F: 26 2D          BNE    $B680
B671: CC 82 83       LDD    #$0001
B674: B7 16 B4       STA    $3436
B677: F7 1C 05       STB    $342D
B67A: CC 8D 28       LDD    #$0500
B67D: FD BC A6       STD    $342E
B680: 10 8E AF C0    LDY    #$2D42
B684: C6 30          LDB    #$12
B686: 4F             CLRA
B687: BD 87 C8       JSR    $AFE0
B68A: 10 8E 0D 6A    LDY    #$2542
B68E: C6 9A          LDB    #$12
B690: 86 32          LDA    #$10
B692: BD 2D C2       JSR    $AFE0
B695: CE A7 C0       LDU    #$2542
B698: 10 8E 7D D5    LDY    #$F55D
B69C: F6 1C BE       LDB    $3436
B69F: A6 87          LDA    B,Y
B6A1: 97 CA          STA    $48
B6A3: 10 8E D7 03    LDY    #$F581
B6A7: 86 08          LDA    #$20
B6A9: 3D             MUL
B6AA: 31 23          LEAY   D,Y
B6AC: 86 24          LDA    #$0C
B6AE: 90 C0          SUBA   $48
B6B0: 47             ASRA
B6B1: 33 44          LEAU   A,U
B6B3: 96 6A          LDA    $48
B6B5: E6 22          LDB    ,Y+
B6B7: C0 18          SUBB   #$30
B6B9: E7 48          STB    ,U+		; [video_address]
B6BB: 4A             DECA
B6BC: 26 DF          BNE    $B6B5
B6BE: CC AF 37       LDD    #$2715
B6C1: ED 43          STD    ,U++	; [video_address_word]
B6C3: CC 3B 35       LDD    #$1917
B6C6: ED 43          STD    ,U++	; [video_address_word]
B6C8: CC 30 AC       LDD    #$1824
B6CB: ED EC          STD    ,U		; [video_address_word]
B6CD: 10 8E BC 7A    LDY    #$3458
B6D1: B6 B6 B4       LDA    $3436
B6D4: 81 25          CMPA   #$07
B6D6: 10 27 28 A0    LBEQ   $B762
B6DA: A6 2E          LDA    A,Y
B6DC: 5F             CLRB
B6DD: FD BC AC       STD    $3424
B6E0: 48             ASLA
B6E1: C6 88          LDB    #$0A
B6E3: 3D             MUL
B6E4: FD 16 B5       STD    $3437
B6E7: CC 28 29       LDD    #$0001
B6EA: FD BC 0F       STD    $3427
B6ED: 8E BC A4       LDX    #$342C
B6F0: BD E1 FD       JSR    $C37F
B6F3: 4F             CLRA
B6F4: BD 6C 31       JSR    force_queue_sound_event_4eb3
B6F7: 86 0F          LDA    #$27
B6F9: BD C6 3B       JSR    force_queue_sound_event_4eb3
B6FC: CC 28 88       LDD    #$0000
B6FF: FD 16 D0       STD    $34F2
B702: 8E A6 FB       LDX    #$24D9
B705: FC B6 AF       LDD    $342D
B708: ED A9          STD    ,X++		; [video_address_word]
B70A: B6 BC 07       LDA    $342F
B70D: C6 04          LDB    #$8C
B70F: ED A3          STD    ,X++		; [video_address_word]
B711: 6F 06          CLR    ,X		; [video_address_word]
B713: 30 AB 25 7E    LEAX   $07FC,X
B717: CC 28 28       LDD    #$0000
B71A: ED 09          STD    ,X++		; [video_address_word]
B71C: ED A9          STD    ,X++		; [video_address_word]
B71E: A7 0C          STA    ,X		; [video_address_word]
B720: 7F 16 A9       CLR    $342B
B723: 7F 16 1E       CLR    $343C
B726: 7F B6 68       CLR    $3440
B729: 86 9C          LDA    #$14
B72B: B7 1C 12       STA    $343A
B72E: CC A0 3A       LDD    #$2818
B731: FD B6 B2       STD    $3430
B734: 10 8E A6 C1    LDY    #$2443
B738: C6 2D          LDB    #$05
B73A: D7 C0          STB    $48
B73C: 86 27          LDA    #$0F
B73E: C6 8B          LDB    #$03
B740: E7 8B 8A 82    STB    $0800,Y	;  [video_address]
B744: A7 82          STA    ,Y+		;  [video_address]
B746: 0A CA          DEC    $48
B748: 26 DE          BNE    $B740
B74A: CC 88 3C       LDD    #$0014
B74D: FD BC CB       STD    $3443
B750: CC 23 96       LDD    #$0114
B753: FD 16 67       STD    $3445
B756: B6 B6 0C       LDA    $3424
B759: B0 BC E8       SUBA   $3460
B75C: B7 1C AC       STA    $3424
B75F: 0C 0E          INC    $2C
B761: 39             RTS

B762: B6 B6 06       LDA    $3424
B765: 7F B6 A7       CLR    $3425
B768: 7E 9E 68       JMP    $B6E0
B76B: BD 7F B7       JSR    $579F
B76E: B6 BC D0       LDA    $34F2
B771: 27 96          BEQ    $B787
B773: 81 28          CMPA   #$0A
B775: 27 85          BEQ    $B77E
B777: BD 8E 56       JSR    $A67E
B77A: 85 8D          BITA   #$05
B77C: 27 21          BEQ    $B787
B77E: 86 84          LDA    #$0C
B780: B7 16 C0       STA    $3442
B783: 0F 0E          CLR    $2C
B785: 0C A8          INC    event_sub_state_2a
B787: 39             RTS

B788: 8E 18 28       LDX    #$30A0
B78B: BD 71 AA       JSR    $5982
B78E: CC 8B 22       LDD    #$0300
B791: BD CC 18       JSR    queue_event_4e9a
B794: 96 0E          LDA    $2C
B796: 81 80          CMPA   #$02
B798: 10 24 88 08    LBCC   $B81C
B79C: B6 1C B2       LDA    $343A
B79F: 81 36          CMPA   #$14
B7A1: 26 97          BNE    $B7B8
B7A3: BD 75 BD       JSR    $579F
B7A6: B6 B6 6A       LDA    $3442
B7A9: B1 BC 7A       CMPA   $34F2
B7AC: 26 22          BNE    $B7B8
B7AE: 8B 8A          ADDA   #$02
B7B0: B7 16 C0       STA    $3442
B7B3: 86 1A          LDA    #$38
B7B5: BD CC 31       JSR    force_queue_sound_event_4eb3
B7B8: 7A 1C B9       DEC    $3431
B7BB: 26 20          BNE    $B7C5
B7BD: 7A BC B8       DEC    $3430
B7C0: 86 3A          LDA    #$18
B7C2: FD B6 13       STD    $3431
B7C5: 10 8E A6 6B    LDY    #$2443
B7C9: CC 83 8D       LDD    #$0B05
B7CC: BD 87 68       JSR    $AFE0
B7CF: 31 19          LEAY   -$5,Y
B7D1: B6 B6 B2       LDA    $3430
B7D4: C6 2A          LDB    #$08
B7D6: BD 24 2E       JSR    $A606
B7D9: 34 8A          PSHS   A
B7DB: 86 27          LDA    #$0F
B7DD: 5D             TSTB
B7DE: 27 8D          BEQ    $B7E5
B7E0: A7 82          STA    ,Y+		; [video_address]
B7E2: 5A             DECB
B7E3: 20 DA          BRA    $B7DD
B7E5: 35 80          PULS   A
B7E7: 4D             TSTA
B7E8: 27 20          BEQ    $B7F2
B7EA: 4A             DECA
B7EB: CE DE 55       LDU    #$F67D
B7EE: A6 4E          LDA    A,U
B7F0: A7 86          STA    ,Y    ; [video_address]
B7F2: B6 B6 1F       LDA    $343D
B7F5: 81 C4          CMPA   #$46
B7F7: 25 2D          BCS    $B7FE
B7F9: 7D BC B6       TST    $343E
B7FC: 26 2D          BNE    $B803
B7FE: 7D BC 12       TST    $3430
B801: 26 9B          BNE    $B81C
B803: 86 21          LDA    #$03
B805: 97 AE          STA    $2C
B807: 4F             CLRA
B808: BD 66 25       JSR    queue_sound_event_4ead
B80B: 86 A4          LDA    #$8C
B80D: BD C6 25       JSR    queue_sound_event_4ead
B810: 86 DD          LDA    #$FF
B812: BD CC 8F       JSR    queue_sound_event_4ead
B815: 86 83          LDA    #$01
B817: 97 E3          STA    $CB
B819: BD 36 8F       JSR    $BE07
B81C: 96 04          LDA    $2C
B81E: 48             ASLA
B81F: 10 8E D4 0E    LDY   #table_f68c
B823: 6E 94          JMP    [A,Y]        ; [jump_table]
B825: 7A B6 C6       DEC    $3444
B828: 26 0E          BNE    $B850
B82A: B6 BC 6B       LDA    $3443
B82D: BB BC CD       ADDA   $3445
B830: 81 3A          CMPA   #$18
B832: 25 80          BCS    $B836
B834: 86 3A          LDA    #$18
B836: B7 B6 6B       STA    $3443
B839: 7A BC CE       DEC    $3446
B83C: 26 24          BNE    $B84A
B83E: B6 BC 64       LDA    $3446
B841: B7 B6 C6       STA    $3444
B844: 7C 16 C4       INC    $3446
B847: 7C 1C 6D       INC    $3445
B84A: B6 BC 6E       LDA    $3446
B84D: B7 BC CC       STA    $3444
B850: 10 8E A6 C1    LDY    #$2443
B854: CC 29 87       LDD    #$0B05
B857: BD 87 C8       JSR    $AFE0
B85A: 31 B3          LEAY   -$5,Y
B85C: B6 1C B8       LDA    $3430
B85F: C6 2A          LDB    #$08
B861: BD 24 84       JSR    $A606
B864: 34 20          PSHS   A
B866: 86 8D          LDA    #$0F
B868: 5D             TSTB
B869: 27 8D          BEQ    $B870
B86B: A7 88          STA    ,Y+		; [video_address]
B86D: 5A             DECB
B86E: 20 70          BRA    $B868
B870: 35 20          PULS   A
B872: 4D             TSTA
B873: 27 2A          BEQ    $B87D
B875: 4A             DECA
B876: CE 74 55       LDU    #$F67D
B879: A6 4E          LDA    A,U
B87B: A7 8C          STA    ,Y		; [video_address]
B87D: 8E B8 38       LDX    #$30B0
B880: A6 A2          LDA    ,X+
B882: C6 88          LDB    #$0A
B884: 3D             MUL
B885: EB 02          ADDB   ,X+
B887: 86 22          LDA    #$0A
B889: 3D             MUL
B88A: EB 0C          ADDB   ,X
B88C: F1 1C B5       CMPB   $343D
B88F: 25 27          BCS    $B896
B891: F7 B6 BF       STB    $343D
B894: 20 30          BRA    $B8A8
B896: B6 B6 15       LDA    $343D
B899: 81 CE          CMPA   #$46
B89B: 25 23          BCS    $B8A8
B89D: 80 BE          SUBA   #$36
B89F: 97 6A          STA    $48
B8A1: D1 CA          CMPB   $48
B8A3: 24 21          BCC    $B8A8
B8A5: 7C B6 BC       INC    $343E
B8A8: C1 00          CMPB   #$28
B8AA: 25 8A          BCS    $B8AE
B8AC: CB 29          ADDB   #$01
B8AE: F1 BC 18       CMPB   $343A
B8B1: 25 90          BCS    $B8C5
B8B3: 86 02          LDA    #$20
B8B5: BD CC 31       JSR    force_queue_sound_event_4eb3
B8B8: 86 09          LDA    #$21
B8BA: BD C6 9B       JSR    force_queue_sound_event_4eb3
B8BD: B6 BC B2       LDA    $343A
B8C0: 8B 36          ADDA   #$14
B8C2: B7 B6 18       STA    $343A
B8C5: D7 CA          STB    $48
B8C7: B6 1C 0C       LDA    $3424
B8CA: F6 BC 0F       LDB    $3427
B8CD: 3D             MUL
B8CE: FB BC 07       ADDB   $3425
B8D1: D1 CA          CMPB   $48
B8D3: 27 24          BEQ    $B8DB
B8D5: 25 81          BCS    $B8DA
B8D7: 5A             DECB
B8D8: 20 29          BRA    $B8DB
B8DA: 5C             INCB
B8DB: 86 29          LDA    #$01
B8DD: F0 BC AC       SUBB   $3424
B8E0: 2A 26          BPL    $B8E6
B8E2: 4F             CLRA
B8E3: FB 16 06       ADDB   $3424
B8E6: F7 B6 0D       STB    $3425
B8E9: B7 BC AF       STA    $3427
B8EC: 4C             INCA
B8ED: B7 BC A0       STA    $3428
B8F0: BD 9C FF       JSR    $BE7D
B8F3: BD 9E 0A       JSR    $BC28
B8F6: BD 3F 56       JSR    $BD7E
B8F9: B6 BC AD       LDA    $3425
B8FC: B1 1C AC       CMPA   $3424
B8FF: 25 7C          BCS    $B95F
B901: 7D B6 A5       TST    $3427
B904: 27 7B          BEQ    $B95F
B906: B6 B6 03       LDA    $342B
B909: 4C             INCA
B90A: 81 8B          CMPA   #$03
B90C: 26 29          BNE    $B90F
B90E: 4F             CLRA
B90F: B7 16 09       STA    $342B
B912: 0D 82          TST    game_playing_00
B914: 26 28          BNE    $B920
B916: 96 8D          LDA    $0F
B918: 84 17          ANDA   #$3F
B91A: 26 8C          BNE    $B920
B91C: 86 2A          LDA    #$02
B91E: 97 B8          STA    $30
B920: BD 6D 23       JSR    $4FA1
B923: 85 20          BITA   #$02
B925: 27 9B          BEQ    $B940
B927: 86 A6          LDA    #$8E
B929: BD C6 25       JSR    queue_sound_event_4ead
B92C: 86 D7          LDA    #$FF
B92E: BD C6 8F       JSR    queue_sound_event_4ead
B931: 7F B6 A9       CLR    $342B
B934: CC 21 86       LDD    #$0304
B937: FD 1C 0F       STD    $3427
B93A: 7F BC 0D       CLR    $3425
B93D: 0C A4          INC    $2C
B93F: 39             RTS

B940: 7D 16 C2       TST    $3440
B943: 26 2D          BNE    $B954
B945: 86 0F          LDA    #$8D
B947: BD 66 85       JSR    queue_sound_event_4ead
B94A: 86 77          LDA    #$FF
B94C: BD 66 25       JSR    queue_sound_event_4ead
B94F: 86 0A          LDA    #$28
B951: B7 B6 C2       STA    $3440
B954: 7A 16 C2       DEC    $3440
B957: B6 1C 0C       LDA    $3424
B95A: 4A             DECA
B95B: B7 1C 0D       STA    $3425
B95E: 39             RTS

B95F: 7F 16 09       CLR    $342B
B962: 39             RTS

B963: 8E 12 92       LDX    #$30B0
B966: BD 2D DC       JSR    $AFF4
B969: C3 88 8A       ADDD   #$0002
B96C: 10 B3 BC BF    CMPD   $3437
B970: 25 31          BCS    $B985
B972: 7C B6 07       INC    $3425
B975: B6 B6 A7       LDA    $3425
B978: B1 1C AC       CMPA   $3424
B97B: 25 38          BCS    $B98D
B97D: B6 BC AC       LDA    $3424
B980: B7 16 A7       STA    $3425
B983: 20 2A          BRA    $B98D
B985: 7A B6 A7       DEC    $3425
B988: 2A 2B          BPL    $B98D
B98A: 7F BC 0D       CLR    $3425
B98D: BD 36 F5       JSR    $BE7D
B990: BD 9E 45       JSR    $BCC7
B993: BD 9F 5C       JSR    $BD7E
B996: B6 B6 0D       LDA    $3425
B999: B1 BC AC       CMPA   $3424
B99C: 27 36          BEQ    $B9BC
B99E: 7F BC 1B       CLR    $3439
B9A1: 4F             CLRA
B9A2: C6 92          LDB    #$10
B9A4: 8E 06 54       LDX    #$24D6
B9A7: E7 AC          STB    ,X;  [video_address]
B9A9: A7 01 80 28    STA    $0800,X	;  [video_address]
B9AD: E7 00 48       STB    -$40,X;  [video_address]
B9B0: A7 AB 85 42    STA    $07C0,X;  [video_address]
B9B4: E7 AA 02       STB    -$80,X;  [video_address]
B9B7: A7 A1 2F 08    STA    $0780,X;  [video_address]
B9BB: 39             RTS

B9BC: 7C 1C B1       INC    $3439
B9BF: B6 16 1B       LDA    $3439
B9C2: 81 96          CMPA   #$14
B9C4: 27 2A          BEQ    $B9CE
B9C6: 81 AA          CMPA   #$28
B9C8: 27 2C          BEQ    $B9CE
B9CA: 81 B4          CMPA   #$3C
B9CC: 26 27          BNE    $B9DD
B9CE: 86 E9          LDA    #$61
B9D0: BD 6C 31       JSR    force_queue_sound_event_4eb3
B9D3: 86 40          LDA    #$62
B9D5: BD CC 31       JSR    force_queue_sound_event_4eb3
B9D8: 86 4B          LDA    #$63
B9DA: BD C6 9B       JSR    force_queue_sound_event_4eb3
B9DD: B6 BC B1       LDA    $3439
B9E0: 8E 06 54       LDX    #$24D6
B9E3: C6 36          LDB    #$14
B9E5: BD 24 84       JSR    $A606
B9E8: 34 2C          PSHS   B
B9EA: 5D             TSTB
B9EB: 27 38          BEQ    $B9FD
B9ED: 86 6A          LDA    #$E2
B9EF: A7 A6          STA    ,X		;  [video_address]
B9F1: 86 02          LDA    #$80
B9F3: A7 AB 2A 82    STA    $0800,X		;  [video_address]
B9F7: 5A             DECB
B9F8: 30 A0 48       LEAX   -$40,X
B9FB: 20 C5          BRA    $B9EA
B9FD: 35 8C          PULS   B
B9FF: C1 21          CMPB   #$03
BA01: 27 83          BEQ    $BA04
BA03: 39             RTS

BA04: BD 9C 85       JSR    $BE07
BA07: 86 14          LDA    #$3C
BA09: 97 A5          STA    $2D
BA0B: 0C 04          INC    $2C
BA0D: 39             RTS

BA0E: 7A BC 43       DEC    $3461
BA11: 27 AF          BEQ    $BA40
BA13: BD 6D 83       JSR    $4FA1
BA16: 84 85          ANDA   #$07
BA18: 81 2D          CMPA   #$05
BA1A: 26 AB          BNE    $BA3F
BA1C: BD 93 AC       JSR    $BB24
BA1F: CC 22 23       LDD    #$0001
BA22: DD 15          STD    $97
BA24: 97 BB          STA    $99
BA26: BD FD 22       JSR    $7F0A
BA29: 86 39          LDA    #$B1
BA2B: BD 66 9B       JSR    force_queue_sound_event_4eb3
BA2E: 86 01          LDA    #$89
BA30: BD 6C 31       JSR    force_queue_sound_event_4eb3
BA33: 86 93          LDA    #$B1
BA35: BD CC 31       JSR    force_queue_sound_event_4eb3
BA38: 86 D7          LDA    #$FF
BA3A: BD C6 9B       JSR    force_queue_sound_event_4eb3
BA3D: 20 89          BRA    $BA40
BA3F: 39             RTS

BA40: 86 20          LDA    #$02
BA42: 97 A8          STA    event_sub_state_2a
BA44: 39             RTS

BA45: 0A AF          DEC    $2D
BA47: 26 2A          BNE    $BA4B
BA49: 0C A4          INC    $2C
BA4B: 39             RTS

BA4C: 8E 1A A8       LDX    #$3220
BA4F: A6 23          LDA    $1,X
BA51: A1 0A D3       CMPA   $51,X
BA54: 23 02          BLS    $BA76
BA56: B6 B6 14       LDA    $343C
BA59: 47             ASRA
BA5A: 47             ASRA
BA5B: 97 60          STA    $48
BA5D: EC 89          LDD    $1,X
BA5F: 90 6A          SUBA   $48
BA61: 5C             INCB
BA62: ED 83          STD    $1,X
BA64: EC AB 82 23    LDD    $00A1,X
BA68: 90 60          SUBA   $48
BA6A: 5C             INCB
BA6B: ED A1 28 29    STD    $00A1,X
BA6F: BD 9F 5C       JSR    $BD7E
BA72: 7C B6 1E       INC    $343C
BA75: 39             RTS

BA76: 7D B6 14       TST    $343C
BA79: 27 86          BEQ    $BA89
BA7B: 4F             CLRA
BA7C: BD 66 25       JSR    queue_sound_event_4ead
BA7F: 86 27          LDA    #$05
BA81: BD CC 2F       JSR    queue_sound_event_4ead
BA84: 86 24          LDA    #$06
BA86: BD CC 85       JSR    queue_sound_event_4ead
BA89: 0F A4          CLR    $2C
BA8B: 0D E3          TST    $CB
BA8D: 27 8D          BEQ    $BA94
BA8F: 0C 08          INC    event_sub_state_2a
BA91: 0C A8          INC    event_sub_state_2a
BA93: 39             RTS

BA94: 86 28          LDA    #$0A
BA96: B7 B6 49       STA    $3461
BA99: 86 8D          LDA    #$05
BA9B: 97 02          STA    event_sub_state_2a
BA9D: 39             RTS

BA9E: BD 37 80       JSR    $BFA2
BAA1: 0D 82          TST    game_playing_00
BAA3: 27 10          BEQ    $BAD7
BAA5: 8E B1 02       LDX    #$3380
BAA8: BD 7B 3C       JSR    $53B4
BAAB: BD 97 98       JSR    $BFB0
BAAE: 10 8E 11 A2    LDY    #$3380
BAB2: 96 9B          LDA    $19
BAB4: C6 2D          LDB    #$0F
BAB6: 3D             MUL
BAB7: 31 83          LEAY   D,Y
BAB9: 33 A2          LEAU   $A,Y
BABB: 96 42          LDA    $6A
BABD: C6 8D          LDB    #$05
BABF: 3D             MUL
BAC0: 31 87          LEAY   B,Y
BAC2: A6 A1          LDA    $3,Y
BAC4: 97 6A          STA    $48
BAC6: BD D2 B7       JSR    $509F
BAC9: A6 AA          LDA    $2,Y
BACB: 97 60          STA    $48
BACD: BD D8 59       JSR    $50D1
BAD0: A6 03          LDA    $1,Y
BAD2: 97 CA          STA    $48
BAD4: BD 72 55       JSR    $50D7
BAD7: CE 1C 04       LDU    #$342C
BADA: 86 8D          LDA    #$05
BADC: 97 60          STA    $48
BADE: BD D8 BD       JSR    $509F
BAE1: 0C A8          INC    event_sub_state_2a
BAE3: 0C 08          INC    event_sub_state_2a
BAE5: 39             RTS

BAE6: BD 2C DD       JSR    $AEF5
BAE9: BD DC EE       JSR    $5466
BAEC: 0D 28          TST    game_playing_00
BAEE: 27 8E          BEQ    $BAF6
BAF0: 8E 11 02       LDX    #$3380
BAF3: BD 71 96       JSR    $53B4
BAF6: 0C A8          INC    event_sub_state_2a
BAF8: 39             RTS

BAF9: 8E BD 80       LDX    #$3508
BAFC: 96 31          LDA    $19
BAFE: C6 A8          LDB    #$20
BB00: 3D             MUL
BB01: 30 09          LEAX   D,X
BB03: FC 16 0F       LDD    $342D
BB06: ED 03          STD    ,X++
BB08: B6 1C A7       LDA    $342F
BB0B: F6 1C 1E       LDB    $3436
BB0E: ED 09          STD    ,X++
BB10: CC 22 83       LDD    #$0001
BB13: FD 16 05       STD    $3427
BB16: 86 90          LDA    #$12
BB18: FD 1C AC       STD    $3424
BB1B: 0F 06          CLR    $2E
BB1D: 0F A2          CLR    event_sub_state_2a
BB1F: 0F 0A          CLR    event_sub_state_28
BB21: 0C A4          INC    $26
BB23: 39             RTS

BB24: 8E D4 7B       LDX    #$F6F9
BB27: 10 8E 1A 68    LDY    #$32E0
BB2B: C6 20          LDB    #$08
BB2D: A6 08          LDA    ,X+
BB2F: A7 03          STA    $1,Y
BB31: A6 02          LDA    ,X+
BB33: A7 00          STA    $2,Y
BB35: 31 A6          LEAY   $4,Y
BB37: 5A             DECB
BB38: 26 DB          BNE    $BB2D
BB3A: CE BE 28       LDU    #$3600
BB3D: 10 8E 7E CB    LDY    #$F6E9
BB41: 8E B0 62       LDX    #$32E0
BB44: 86 25          LDA    #$07
BB46: 97 CA          STA    $48
BB48: 34 58          PSHS   U,Y,X
BB4A: BD 01 63       JSR    $894B
BB4D: 35 F8          PULS   X,Y,U
BB4F: 30 26          LEAX   $4,X
BB51: 31 A0          LEAY   $2,Y
BB53: 33 66          LEAU   $4,U
BB55: 0A CA          DEC    $48
BB57: 26 C7          BNE    $BB48
BB59: CE BE 0C       LDU    #$3684
BB5C: BD A1 C3       JSR    $894B
BB5F: 39             RTS

BB60: 96 2C          LDA    $0E
BB62: 84 8D          ANDA   #$0F
BB64: C6 2A          LDB    #$08
BB66: 3D             MUL
BB67: 8E DF 01       LDX    #$F729
BB6A: 30 03          LEAX   D,X
BB6C: CE DF 91       LDU    #$F719
BB6F: 10 8E 16 DA    LDY    #$3458
BB73: C6 2A          LDB    #$08
BB75: A6 02          LDA    ,X+
BB77: A6 EE          LDA    A,U
BB79: A7 28          STA    ,Y+
BB7B: 5A             DECB
BB7C: 26 DF          BNE    $BB75
BB7E: 39             RTS

BB7F: CE D8 87       LDU    #$FAA5
BB82: B6 B6 04       LDA    $3426
BB85: 81 85          CMPA   #$07
BB87: 24 23          BCC    $BB94
BB89: CE 72 3B       LDU    #$FAB3
BB8C: 81 2B          CMPA   #$03
BB8E: 24 8C          BCC    $BB94
BB90: CE D8 27       LDU    #$FAA5
BB93: 39             RTS

BB94: 8E 12 42       LDX    #$30C0
BB97: 86 2F          LDA    #$07
BB99: B7 B8 C0       STA    $3048
BB9C: EC E9          LDD    ,U++
BB9E: ED 8B          STD    $3,X
BBA0: 30 2A          LEAX   $8,X
BBA2: 7A B2 6A       DEC    $3048
BBA5: 26 77          BNE    $BB9C
BBA7: 7E E3 3E       JMP    $CB16
BBAA: 39             RTS

BBAB: 8E 19 08       LDX    #$3120
BBAE: B6 BC 05       LDA    $3427
BBB1: 26 90          BNE    $BBC5
BBB3: CE 14 22       LDU    #$3600
BBB6: C6 86          LDB    #$04
BBB8: 10 8E BE 98    LDY    #$3610
BBBC: 8D 3B          BSR    $BBD1
BBBE: CE BE 72       LDU    #$3650
BBC1: C6 8E          LDB    #$0C
BBC3: 20 2A          BRA    $BBCD
BBC5: 8E B3 B2       LDX    #$3130
BBC8: CE 1E F0       LDU    #$3678
BBCB: C6 2C          LDB    #$04
BBCD: 10 8E BE AA    LDY    #$3688
BBD1: 10 BF B2 72    STY    $3050
BBD5: F7 B2 CA       STB    $3048
BBD8: BD 93 78       JSR    $BBF0
BBDB: 30 2C          LEAX   $4,X
BBDD: 7A B8 C0       DEC    $3048
BBE0: 26 D4          BNE    $BBD8
BBE2: 11 B3 12 72    CMPU   $3050
BBE6: 24 85          BCC    $BBEF
BBE8: CC 28 88       LDD    #$0000
BBEB: ED E9          STD    ,U++
BBED: 20 7B          BRA    $BBE2
BBEF: 39             RTS

BBF0: A6 21          LDA    $3,X
BBF2: 27 B1          BEQ    $BC27
BBF4: A7 60          STA    $2,U
BBF6: B6 B2 2A       LDA    $3002
BBF9: 26 9C          BNE    $BC0F
BBFB: A6 2A          LDA    $2,X
BBFD: A7 4C          STA    ,U
BBFF: EC A6          LDD    ,X
BC01: 11 83 B4 52    CMPU   #$3670
BC05: 24 83          BCC    $BC08
BC07: 4C             INCA
BC08: A7 69          STA    $1,U
BC0A: E7 CB          STB    $3,U
BC0C: 33 6C          LEAU   $4,U
BC0E: 39             RTS

BC0F: A6 20          LDA    $2,X
BC11: 88 C2          EORA   #$40
BC13: A7 E6          STA    ,U
BC15: EC 06          LDD    ,X
BC17: 50             NEGB
BC18: 11 83 BE F8    CMPU   #$3670
BC1C: 24 29          BCC    $BC1F
BC1E: 4A             DECA
BC1F: C0 32          SUBB   #$10
BC21: A7 C3          STA    $1,U
BC23: E7 61          STB    $3,U
BC25: 33 C6          LEAU   $4,U
BC27: 39             RTS

BC28: 8E 1C 88       LDX    #$3400
BC2B: 10 8E 1A A8    LDY    #$3220
BC2F: EC A3          LDD    ,X++
BC31: ED 2A D3       STD    $51,Y
BC34: CB 27          ADDB   #$05
BC36: ED 2A 59       STD    chrono_hundredth_second_71,Y
BC39: A6 08          LDA    ,X+
BC3B: CE F5 9D       LDU    #$DDB5
BC3E: 48             ASLA
BC3F: 48             ASLA
BC40: 33 E4          LEAU   A,U
BC42: EF 2A 71       STU    $53,Y
BC45: EF 2A F1       STU    $73,Y
BC48: EC A9          LDD    ,X++
BC4A: ED 20 19       STD    $31,Y
BC4D: CB 8D          ADDB   #$05
BC4F: ED 8A 43       STD    $61,Y
BC52: A6 02          LDA    ,X+
BC54: CE FF 18       LDU    #$DD9A
BC57: C6 2B          LDB    #$03
BC59: 3D             MUL
BC5A: 33 4D          LEAU   B,U
BC5C: EF 80 BB       STU    $33,Y
BC5F: EF 8A 41       STU    $63,Y
BC62: EC 03          LDD    ,X++
BC64: ED 8A C3       STD    $41,Y
BC67: A6 A8          LDA    ,X+
BC69: CE 55 02       LDU    #$DD8A
BC6C: 48             ASLA
BC6D: 48             ASLA
BC6E: 33 4E          LEAU   A,U
BC70: EF 8A C1       STU    $43,Y
BC73: EC A3          LDD    ,X++
BC75: ED 2A A3       STD    $21,Y
BC78: CB 20          ADDB   #$08
BC7A: ED 21 28 B9    STD    $0091,Y
BC7E: A6 08          LDA    ,X+
BC80: CE FF 4F       LDU    #$DDCD
BC83: 48             ASLA
BC84: 33 E4          LEAU   A,U
BC86: EF 2A 0B       STU    $23,Y
BC89: EF 21 88 BB    STU    $0093,Y
BC8D: EC 09          LDD    ,X++
BC8F: ED 8A 33       STD    $11,Y
BC92: CB 8A          ADDB   #$08
BC94: ED 8B 82 03    STD    $0081,Y
BC98: A6 A8          LDA    ,X+
BC9A: CE 55 E5       LDU    #$DDCD
BC9D: 48             ASLA
BC9E: 33 4E          LEAU   A,U
BCA0: EF 8A 91       STU    $13,Y
BCA3: EF 8B 22 01    STU    $0083,Y
BCA7: BD 95 E2       JSR    $BDCA
BCAA: BD 35 46       JSR    $BD6E
BCAD: CE 55 77       LDU    #$DDFF
BCB0: B6 16 A9       LDA    $342B
BCB3: C6 21          LDB    #$03
BCB5: 3D             MUL
BCB6: 33 47          LEAU   B,U
BCB8: EF 0B          STU    $3,Y
BCBA: CE 56 20       LDU    #$DE08
BCBD: F0 BC A3       SUBB   $342B
BCC0: 33 E7          LEAU   B,U
BCC2: EF 2B 22 81    STU    $00A3,Y
BCC6: 39             RTS

BCC7: 8E 1C 28       LDX    #$3400
BCCA: 10 8E 1A 08    LDY    #$3220
BCCE: EC 09          LDD    ,X++
BCD0: ED 8A D3       STD    $51,Y
BCD3: A6 A2          LDA    ,X+
BCD5: CE 5F 37       LDU    #$DDB5
BCD8: 48             ASLA
BCD9: 48             ASLA
BCDA: 33 4E          LEAU   A,U
BCDC: EF 80 DB       STU    $53,Y
BCDF: EC A3          LDD    ,X++
BCE1: ED 2A B3       STD    $31,Y
BCE4: A6 A2          LDA    ,X+
BCE6: CE 5F B2       LDU    #$DD9A
BCE9: C6 8B          LDB    #$03
BCEB: 3D             MUL
BCEC: 33 ED          LEAU   B,U
BCEE: EF 20 11       STU    $33,Y
BCF1: EC 03          LDD    ,X++
BCF3: ED 8A 53       STD    chrono_hundredth_second_71,Y
BCF6: A6 02          LDA    ,X+
BCF8: CE F5 3D       LDU    #$DDB5
BCFB: 48             ASLA
BCFC: 48             ASLA
BCFD: 33 4E          LEAU   A,U
BCFF: EF 8A 51       STU    $73,Y
BD02: EC 03          LDD    ,X++
BD04: ED 8A E3       STD    $61,Y
BD07: A6 A8          LDA    ,X+
BD09: CE 55 12       LDU    #$DD9A
BD0C: C6 2B          LDB    #$03
BD0E: 3D             MUL
BD0F: 33 E7          LEAU   B,U
BD11: EF 2A E1       STU    $63,Y
BD14: EC A3          LDD    ,X++
BD16: ED 2A 69       STD    $41,Y
BD19: 8B 80          ADDA   #$08
BD1B: C0 22          SUBB   #$0A
BD1D: ED 20 A9       STD    $21,Y
BD20: 8B 2A          ADDA   #$08
BD22: ED 2A 33       STD    $11,Y
BD25: CB 8A          ADDB   #$08
BD27: ED 81 28 09    STD    $0081,Y
BD2B: 80 20          SUBA   #$08
BD2D: ED 21 88 B3    STD    $0091,Y
BD31: A6 02          LDA    ,X+
BD33: CE FF A8       LDU    #$DD8A
BD36: 48             ASLA
BD37: 48             ASLA
BD38: 33 EE          LEAU   A,U
BD3A: EF 20 6B       STU    $43,Y
BD3D: CE 55 6D       LDU    #$DDE5
BD40: EF 8A 91       STU    $13,Y
BD43: EF 8A 01       STU    $23,Y
BD46: EF 2B 28 AB    STU    $0083,Y
BD4A: EF 21 28 BB    STU    $0093,Y
BD4E: BD 35 E8       JSR    $BDCA
BD51: BD 3F EC       JSR    $BD6E
BD54: CE FF 7D       LDU    #$DDFF
BD57: B6 1C 03       LDA    $342B
BD5A: C6 8B          LDB    #$03
BD5C: 3D             MUL
BD5D: 33 4D          LEAU   B,U
BD5F: EF 01          STU    $3,Y
BD61: CE 5C 8A       LDU    #$DE08
BD64: F0 16 A9       SUBB   $342B
BD67: 33 ED          LEAU   B,U
BD69: EF 21 88 8B    STU    $00A3,Y
BD6D: 39             RTS

BD6E: EC 20 C3       LDD    -$1F,Y
BD71: 80 87          SUBA   #$05
BD73: CB 23          ADDB   #$01
BD75: ED A3          STD    $1,Y
BD77: CB 20          ADDB   #$08
BD79: ED 21 88 89    STD    $00A1,Y
BD7D: 39             RTS

BD7E: 8E BA 22       LDX    #$3200
BD81: 0F AC          CLR    $2E
BD83: CE 14 3E       LDU    #$361C
BD86: 10 8E DF F1    LDY   #table_f7d9
BD8A: 96 A6          LDA    $2E
BD8C: AD 9E          JSR    [A,Y]        ; [jump_table]
BD8E: 30 00 32       LEAX   $10,X
BD91: 96 AC          LDA    $2E
BD93: 4C             INCA
BD94: 4C             INCA
BD95: 97 AC          STA    $2E
BD97: 81 32          CMPA   #$1A
BD99: 26 63          BNE    $BD86
BD9B: 39             RTS

BD9C: 10 AE 8B       LDY    $3,X
BD9F: BD 8D 31       JSR    $AF13
BDA2: 33 C6          LEAU   $4,U
BDA4: 39             RTS

BDA5: 10 AE 81       LDY    $3,X
BDA8: BD 87 8C       JSR    $AF04
BDAB: 33 60          LEAU   $8,U
BDAD: 39             RTS

BDAE: 10 AE 21       LDY    $3,X
BDB1: BD 0B C9       JSR    $894B
BDB4: 33 66          LEAU   $4,U
BDB6: 39             RTS

BDB7: 10 AE 2B       LDY    $3,X
BDBA: BD 01 27       JSR    $890F
BDBD: 33 C0          LEAU   $8,U
BDBF: 39             RTS

BDC0: 10 AE 81       LDY    $3,X
BDC3: BD 9C 4F       JSR    $BE6D
BDC6: 33 4A 38       LEAU   $10,U
BDC9: 39             RTS

BDCA: 34 B8          PSHS   Y,X
BDCC: 8E 1A A8       LDX    #$3220
BDCF: EC AA 31       LDD    $13,X
BDD2: 83 5F EF       SUBD   #$DDCD
BDD5: 10 8E 75 81    LDY    #$F7A9
BDD9: 31 2D          LEAY   B,Y
BDDB: EC A0 39       LDD    $11,X
BDDE: AB 28          ADDA   ,Y+
BDE0: EB 82          ADDB   ,Y+
BDE2: ED 0A C3       STD    -$1F,X
BDE5: EC 0B 82 AB    LDD    $0083,X
BDE9: 83 55 45       SUBD   #$DDCD
BDEC: 10 8E 7F 21    LDY    #$F7A9
BDF0: 31 87          LEAY   B,Y
BDF2: EC 0B 22 A3    LDD    $0081,X
BDF6: AB 22          ADDA   ,Y+
BDF8: EB 88          ADDB   ,Y+
BDFA: ED 99          STD    -$F,X
BDFC: CE F5 75       LDU    #$DDFD
BDFF: EF 31          STU    -$D,X
BE01: EF 0A 61       STU    -$1D,X
BE04: 35 12          PULS   X,Y
BE06: 39             RTS

BE07: 8E 1A 08       LDX    #$3220
BE0A: EC 00 6B       LDD    $43,X
BE0D: 83 55 02       SUBD   #$DD8A
BE10: 54             LSRB
BE11: 54             LSRB
BE12: 86 84          LDA    #$06
BE14: 3D             MUL
BE15: 10 8E 75 D0    LDY    #$F7F8
BE19: 31 2D          LEAY   B,Y
BE1B: EC A0 69       LDD    $41,X
BE1E: AB 28          ADDA   ,Y+
BE20: EB 82          ADDB   ,Y+
BE22: ED 0A 03       STD    $21,X
BE25: CB 8A          ADDB   #$08
BE27: ED A1 28 19    STD    $0091,X
BE2B: A6 88          LDA    ,Y+
BE2D: 48             ASLA
BE2E: CE 55 EF       LDU    #$DDCD
BE31: 33 44          LEAU   A,U
BE33: EF AA 01       STU    $23,X
BE36: EF 0B 28 BB    STU    $0093,X
BE3A: EC 00 69       LDD    $41,X
BE3D: AB 28          ADDA   ,Y+
BE3F: EB 82          ADDB   ,Y+
BE41: ED 0A 93       STD    $11,X
BE44: CB 2A          ADDB   #$08
BE46: ED 0B 28 A9    STD    $0081,X
BE4A: A6 28          LDA    ,Y+
BE4C: 48             ASLA
BE4D: CE 55 45       LDU    #$DDCD
BE50: 33 E4          LEAU   A,U
BE52: EF 0A 31       STU    $13,X
BE55: EF 0B 82 AB    STU    $0083,X
BE59: BD 35 42       JSR    $BDCA
BE5C: 39             RTS

BE5D: A6 8A          LDA    $2,X
BE5F: 34 20          PSHS   A
BE61: 8B 92          ADDA   #$10
BE63: A7 20          STA    $2,X
BE65: BD 3C EF       JSR    $BE6D
BE68: 35 2A          PULS   A
BE6A: A7 8A          STA    $2,X
BE6C: 39             RTS

BE6D: 96 91          LDA    $19
BE6F: 34 20          PSHS   A
BE71: 8A A2          ORA    #$20
BE73: 97 3B          STA    $19
BE75: BD 04 6C       JSR    $86EE
BE78: 35 2A          PULS   A
BE7A: 97 91          STA    $19
BE7C: 39             RTS

BE7D: 8E 7E 1C       LDX    #$F694
BE80: B6 16 AA       LDA    $3428
BE83: C6 33          LDB    #$11
BE85: 3D             MUL
BE86: 31 09          LEAY   D,X
BE88: F6 1C AF       LDB    $3427
BE8B: 2A 2D          BPL    $BE92
BE8D: 8E BC F8       LDX    #$3470
BE90: 20 27          BRA    $BE97
BE92: 86 93          LDA    #$11
BE94: 3D             MUL
BE95: 30 09          LEAX   D,X
BE97: CE 1C 28       LDU    #$3400
BE9A: 86 99          LDA    #$11
BE9C: 97 60          STA    $48
BE9E: 7E 39 1A       JMP    $B138
BEA1: 8E 7A 94       LDX    #$F816
BEA4: BD 9D B8       JSR    $BF3A
BEA7: 8E D0 0D       LDX    #$F825
BEAA: BD 37 63       JSR    $BF4B
BEAD: FC BC 88       LDD    $3400
BEB0: FD 10 33       STD    $32B1
BEB3: CE FF EF       LDU    #$DDCD
BEB6: B6 B6 2A       LDA    $3402
BEB9: 48             ASLA
BEBA: 33 4E          LEAU   A,U
BEBC: FF 1A 3B       STU    $32B3
BEBF: FC 16 21       LDD    $3403
BEC2: FD B0 83       STD    $32A1
BEC5: CE 5F 4F       LDU    #$DDCD
BEC8: B6 1C 8D       LDA    $3405
BECB: 48             ASLA
BECC: 33 EE          LEAU   A,U
BECE: FF BA 81       STU    $32A3
BED1: 7E 3D E9       JMP    $BF6B
BED4: 8E DA CE       LDX    #$F84C
BED7: BD 97 12       JSR    $BF3A
BEDA: 8E 70 73       LDX    #$F85B
BEDD: BD 37 C3       JSR    $BF4B
BEE0: FC 16 82       LDD    $3400
BEE3: FD 10 63       STD    $3241
BEE6: CE 5F E5       LDU    #$DDCD
BEE9: B6 BC 8A       LDA    $3402
BEEC: 48             ASLA
BEED: 33 4E          LEAU   A,U
BEEF: FF 10 61       STU    $3243
BEF2: FC B6 21       LDD    $3403
BEF5: FD B0 B3       STD    $3231
BEF8: CE F5 45       LDU    #$DDCD
BEFB: B6 1C 2D       LDA    $3405
BEFE: 48             ASLA
BEFF: 33 E4          LEAU   A,U
BF01: FF B0 B1       STU    $3233
BF04: 7E 9D E9       JMP    $BF6B
BF07: 8E D0 19       LDX    #$F831
BF0A: BD 37 12       JSR    $BF3A
BF0D: 8E 70 C8       LDX    #$F840
BF10: BD 9D C9       JSR    $BF4B
BF13: FC 16 22       LDD    $3400
BF16: FD B0 69       STD    $3241
BF19: CE 55 45       LDU    #$DDCD
BF1C: B6 1C 8A       LDA    $3402
BF1F: 48             ASLA
BF20: 33 E4          LEAU   A,U
BF22: FF B0 61       STU    $3243
BF25: FC B6 81       LDD    $3403
BF28: FD 1A B9       STD    $3231
BF2B: CE F5 E5       LDU    #$DDCD
BF2E: B6 BC 27       LDA    $3405
BF31: 48             ASLA
BF32: 33 44          LEAU   A,U
BF34: FF 10 B1       STU    $3233
BF37: 7E 97 43       JMP    $BF6B
BF3A: 10 8E 1A 08    LDY    #$3220
BF3E: EC A9          LDD    $1,Y
BF40: DD 72          STD    $50
BF42: EC 2B 22 83    LDD    $00A1,Y
BF46: DD D0          STD    $52
BF48: 7E 94 A3       JMP    $BC2B
BF4B: 5F             CLRB
BF4C: B6 1C A0       LDA    $3428
BF4F: 44             LSRA
BF50: 59             ROLB
BF51: 86 84          LDA    #$06
BF53: 3D             MUL
BF54: 31 A7          LEAY   B,X
BF56: 5F             CLRB
BF57: B6 1C 0F       LDA    $3427
BF5A: 44             LSRA
BF5B: 59             ROLB
BF5C: 86 2E          LDA    #$06
BF5E: 3D             MUL
BF5F: 30 A7          LEAX   B,X
BF61: 86 84          LDA    #$06
BF63: 97 6A          STA    $48
BF65: CE B6 82       LDU    #$3400
BF68: 7E 99 B0       JMP    $B138
BF6B: DC 78          LDD    $50
BF6D: FD BA A9       STD    $3221
BF70: DC 70          LDD    $52
BF72: FD B0 E3       STD    $32C1
BF75: BD 3F 48       JSR    $BDCA
BF78: BD 95 F6       JSR    $BD7E
BF7B: B6 1C 0D       LDA    $3425
BF7E: 4C             INCA
BF7F: B1 16 06       CMPA   $3424
BF82: 23 85          BLS    $BF8B
BF84: 4F             CLRA
BF85: 7C B6 A5       INC    $3427
BF88: 7C 1C A0       INC    $3428
BF8B: B7 1C 0D       STA    $3425
BF8E: 39             RTS

BF8F: B6 16 D6       LDA    $34F4
BF92: 48             ASLA
BF93: 10 8E DA 92    LDY   #table_f810
BF97: 6E 9E          JMP    [A,Y]        ; [jump_table]
BF99: 8E 7E 1C       LDX    #$F694
BF9C: BD 94 A3       JSR    $BC2B
BF9F: 7E 9F 5C       JMP    $BD7E
BFA2: 8E B6 0E       LDX    #$342C
BFA5: EC 03          LDD    ,X++
BFA7: DD B3          STD    $9B
BFA9: EC 0C          LDD    ,X
BFAB: DD B5          STD    $9D
BFAD: 7E DC EE       JMP    $5466
BFB0: 8E 11 02       LDX    #$3380
BFB3: 96 3B          LDA    $19
BFB5: C6 8D          LDB    #$0F
BFB7: 3D             MUL
BFB8: 30 A3          LEAX   D,X
BFBA: 96 E2          LDA    $6A
BFBC: C6 2D          LDB    #$05
BFBE: 3D             MUL
BFBF: 30 A7          LEAX   B,X
BFC1: A6 81          LDA    $3,X
BFC3: E6 20          LDB    $2,X
BFC5: 58             ASLB
BFC6: 58             ASLB
BFC7: 58             ASLB
BFC8: 58             ASLB
BFC9: D7 C0          STB    $48
BFCB: 9A 60          ORA    $48
BFCD: 97 11          STA    $99
BFCF: A6 23          LDA    $1,X
BFD1: 97 1A          STA    $98
BFD3: BD 5D 28       JSR    $7F0A
BFD6: BD FD 22       JSR    $7F0A
BFD9: 7E F7 82       JMP    $7F0A
BFDC: 10 8E A2 28    LDY    #$2AA0
BFE0: BD 8D 5A       JSR    $AFD8
BFE3: 10 BE 16 B6    LDY    $3434
BFE7: 7E 87 F0       JMP    $AFD8

C000: 86 24          LDA    #$06
C002: 9B F0          ADDA   chrono_second_72
C004: 19             DAA
C005: 97 F0          STA    chrono_second_72
C007: 24 3C          BCC    $C01D
C009: 8B 89          ADDA   #$01
C00B: 19             DAA
C00C: 97 5A          STA    chrono_second_72
C00E: 96 F9          LDA    chrono_hundredth_second_71
C010: 8B 23          ADDA   #$01
C012: 19             DAA
C013: 97 53          STA    chrono_hundredth_second_71
C015: 81 E2          CMPA   #$60
C017: 26 2C          BNE    $C01D
C019: 0F F9          CLR    chrono_hundredth_second_71
C01B: 0C 58          INC    $70
C01D: D6 FB          LDB    $73
C01F: 27 27          BEQ    $C026
C021: 86 87          LDA    #$05
C023: BD 6C B8       JSR    queue_event_4e9a
C026: 39             RTS

C027: 96 27          LDA    $0F
C029: D6 E1          LDB    current_event_69
C02B: 10 8E D0 4A    LDY    #$F8C2
C02F: E6 87          LDB    B,Y
C031: BD 24 84       JSR    $A606
C034: 4D             TSTA
C035: 27 81          BEQ    $C03A
C037: 5F             CLRB
C038: 4F             CLRA
C039: 39             RTS

C03A: 1F 9A          TFR    X,Y
C03C: A6 80 98       LDA    $10,Y
C03F: C6 24          LDB    #$06
C041: BD 24 84       JSR    $A606
C044: D7 68          STB    $4A
C046: C6 88          LDB    #$0A
C048: 3D             MUL
C049: EB 20 99       ADDB   $11,Y
C04C: 1F B0          TFR    B,A
C04E: C6 8E          LDB    #$06
C050: BD 84 84       JSR    $A606
C053: D7 69          STB    $4B
C055: C6 88          LDB    #$0A
C057: 3D             MUL
C058: EB 80 9A       ADDB   $12,Y
C05B: 1F B0          TFR    B,A
C05D: C6 8E          LDB    #$06
C05F: BD 84 24       JSR    $A606
C062: D7 CE          STB    $4C
C064: C6 28          LDB    #$0A
C066: 3D             MUL
C067: EB 80 3B       ADDB   $13,Y
C06A: 1F 10          TFR    B,A
C06C: C6 2E          LDB    #$06
C06E: BD 2E 24       JSR    $A606
C071: D7 CF          STB    $4D
C073: 96 6E          LDA    $4C
C075: C6 88          LDB    #$0A
C077: 3D             MUL
C078: 0F 64          CLR    $4C
C07A: D3 C4          ADDD   $4C
C07C: DD 60          STD    $48
C07E: 96 C3          LDA    $4B
C080: C6 46          LDB    #$64
C082: 3D             MUL
C083: D3 6A          ADDD   $48
C085: DD CA          STD    $48
C087: D6 62          LDB    $4A
C089: 86 60          LDA    #$E8
C08B: 3D             MUL
C08C: D3 60          ADDD   $48
C08E: DD C0          STD    $48
C090: D6 68          LDB    $4A
C092: 86 81          LDA    #$03
C094: 3D             MUL
C095: DB CA          ADDB   $48
C097: D7 60          STB    $48
C099: A6 20 AC       LDA    $24,Y
C09C: 8E D0 49       LDX    #$F8C1
C09F: 40             NEGA
C0A0: A6 A4          LDA    A,X
C0A2: 97 CC          STA    $4E
C0A4: BD E3 BB       JSR    $C139
C0A7: DD 62          STD    $4A
C0A9: B6 BB FE       LDA    $3376
C0AC: 34 2A          PSHS   A
C0AE: D6 C3          LDB    $4B
C0B0: 3D             MUL
C0B1: DD D2          STD    $50
C0B3: 35 20          PULS   A
C0B5: D6 C8          LDB    $4A
C0B7: 3D             MUL
C0B8: DB 78          ADDB   $50
C0BA: D7 D8          STB    $50
C0BC: DC 78          LDD    $50
C0BE: 47             ASRA
C0BF: 56             RORB
C0C0: 47             ASRA
C0C1: 56             RORB
C0C2: 47             ASRA
C0C3: 56             RORB
C0C4: 47             ASRA
C0C5: 56             RORB
C0C6: DD C8          STD    $4A
C0C8: A6 80 AC       LDA    $24,Y
C0CB: 8E D0 4F       LDX    #$F867
C0CE: A6 0E          LDA    A,X
C0D0: 97 6C          STA    $4E
C0D2: BD 43 1B       JSR    $C139
C0D5: DD CE          STD    $4C
C0D7: B6 1B 5D       LDA    $3375
C0DA: 34 8A          PSHS   A
C0DC: D6 65          LDB    $4D
C0DE: 3D             MUL
C0DF: DD 72          STD    $50
C0E1: 35 80          PULS   A
C0E3: D6 6E          LDB    $4C
C0E5: 3D             MUL
C0E6: DB D2          ADDB   $50
C0E8: D7 78          STB    $50
C0EA: DC D8          LDD    $50
C0EC: 47             ASRA
C0ED: 56             RORB
C0EE: 47             ASRA
C0EF: 56             RORB
C0F0: 47             ASRA
C0F1: 56             RORB
C0F2: 47             ASRA
C0F3: 56             RORB
C0F4: DD 6E          STD    $4C
C0F6: FC B1 52       LDD    $337A
C0F9: 58             ASLB
C0FA: 49             ROLA
C0FB: DD 78          STD    $50
C0FD: 47             ASRA
C0FE: 56             RORB
C0FF: 47             ASRA
C100: 56             RORB
C101: D3 D2          ADDD   $50
C103: DD 72          STD    $50
C105: DC CE          LDD    $4C
C107: 93 78          SUBD   $50
C109: DD C4          STD    $4C
C10B: FC 1B 52       LDD    $337A
C10E: C3 88 23       ADDD   #$0001
C111: FD B1 F8       STD    $337A
C114: 0C 9E          INC    $BC
C116: DC CE          LDD    $4C
C118: 58             ASLB
C119: 49             ROLA
C11A: 58             ASLB
C11B: 49             ROLA
C11C: F3 1B F6       ADDD   $337E
C11F: 97 73          STA    $51
C121: 4F             CLRA
C122: FD B1 5C       STD    $337E
C125: DC C8          LDD    $4A
C127: 58             ASLB
C128: 49             ROLA
C129: 58             ASLB
C12A: 49             ROLA
C12B: F3 1B 54       ADDD   $337C
C12E: 97 D8          STA    $50
C130: 4F             CLRA
C131: FD B1 FE       STD    $337C
C134: DC 72          LDD    $50
C136: 1F A3          TFR    Y,X
C138: 39             RTS

C139: CC 88 88       LDD    #$0000
C13C: DD 78          STD    $50
C13E: 96 C1          LDA    $49
C140: D6 6C          LDB    $4E
C142: 3D             MUL
C143: 97 73          STA    $51
C145: 96 CA          LDA    $48
C147: D6 66          LDB    $4E
C149: 3D             MUL
C14A: D3 D8          ADDD   $50
C14C: 39             RTS

C14D: 8E 70 5D       LDX   #table_f8d5
C150: 96 08          LDA    event_sub_state_2a
C152: 48             ASLA
C153: 6E B4          JMP    [A,X]        ; [jump_table]

C155: 96 83          LDA    $01
C157: 27 32          BEQ    $C173
C159: 8E BB 58       LDX    #$33D0
C15C: 0F 60          CLR    $48
C15E: 86 8B          LDA    #$03
C160: 97 6B          STA    $49
C162: A6 06          LDA    ,X
C164: 85 32          BITA   #$10
C166: 26 8C          BNE    $C176
C168: 97 01          STA    $29
C16A: 30 89          LEAX   $1,X
C16C: BD 7A 2B       JSR    $52A3
C16F: 96 4E          LDA    $6C
C171: 26 8C          BNE    $C181
C173: 0C 0A          INC    event_sub_state_28
C175: 39             RTS

C176: 30 84          LEAX   $6,X
C178: 8C 1B 60       CMPX   #$33E8
C17B: 27 DE          BEQ    $C173
C17D: 0A C1          DEC    $49
C17F: 20 C3          BRA    $C162
C181: 0C CA          INC    $48
C183: D6 6B          LDB    $49
C185: 27 6E          BEQ    $C173
C187: 30 2D          LEAX   $5,X
C189: A6 0C          LDA    ,X
C18B: 27 23          BEQ    $C198
C18D: 84 98          ANDA   #$10
C18F: 26 20          BNE    $C193
C191: 0C CA          INC    $48
C193: 30 24          LEAX   $6,X
C195: 5A             DECB
C196: 26 73          BNE    $C189
C198: 96 60          LDA    $48
C19A: 81 8A          CMPA   #$02
C19C: 25 FD          BCS    $C173
C19E: 0C A2          INC    event_sub_state_2a
C1A0: 39             RTS

C1A1: 4F             CLRA
C1A2: BD CC B8       JSR    queue_event_4e9a
C1A5: BD 2D 43       JSR    $AFC1
C1A8: 96 01          LDA    $29
C1AA: 5F             CLRB
C1AB: 0D 32          TST    $1A
C1AD: 26 8D          BNE    $C1B4
C1AF: 81 21          CMPA   #$03
C1B1: 25 83          BCS    $C1B4
C1B3: 5C             INCB
C1B4: F7 36 02       STB    flip_screen_set_1480
C1B7: 86 16          LDA    #$3E
C1B9: BD C6 3B       JSR    force_queue_sound_event_4eb3
C1BC: 86 2A          LDA    #$02
C1BE: 97 A3          STA    $2B
C1C0: 0C 08          INC    event_sub_state_2a
C1C2: 39             RTS

C1C3: 0A 09          DEC    $2B
C1C5: 26 79          BNE    $C1C2
C1C7: CC 29 22       LDD    #$010A
C1CA: BD C6 B2       JSR    queue_event_4e9a
C1CD: 86 8A          LDA    #$02
C1CF: D6 4B          LDB    current_event_69
C1D1: CB AC          ADDB   #$2E
C1D3: BD 6C B8       JSR    queue_event_4e9a
C1D6: CC 83 29       LDD    #$0101
C1D9: BD C6 12       JSR    queue_event_4e9a
C1DC: CC 2A 9A       LDD    #$0212
C1DF: BD 6C B8       JSR    queue_event_4e9a
C1E2: CE A3 A5       LDU    #$2187
C1E5: CC 93 85       LDD    #$1107
C1E8: DD 60          STD    $48
C1EA: BD F4 70       JSR    $7C58
C1ED: BD 4A 4B       JSR    $C2C3
C1F0: CE 06 89       LDU    #$240B
C1F3: 0F 6A          CLR    $48
C1F5: A6 06          LDA    ,X
C1F7: 27 41          BEQ    $C262
C1F9: 34 C8          PSHS   U
C1FB: 96 60          LDA    $48
C1FD: C6 08          LDB    #$80
C1FF: 3D             MUL
C200: 33 E9          LEAU   D,U
C202: A6 06          LDA    ,X
C204: 85 32          BITA   #$10
C206: 27 89          BEQ    $C213
C208: 35 68          PULS   U
C20A: 30 8E          LEAX   $6,X
C20C: 8C 1B 60       CMPX   #$33E8
C20F: 27 73          BEQ    $C262
C211: 20 60          BRA    $C1F5
C213: 10 8E ED 67    LDY    #$CFE5
C217: A6 AC          LDA    ,X
C219: 4A             DECA
C21A: E6 2E          LDB    A,Y
C21C: D7 5D          STB    $75
C21E: 86 89          LDA    #$01
C220: BD 6C 18       JSR    queue_event_4e9a
C223: 86 20          LDA    #$02
C225: D6 CA          LDB    $48
C227: CB 1D          ADDB   #$35
C229: BD C6 12       JSR    queue_event_4e9a
C22C: D6 5D          LDB    $75
C22E: A6 0C          LDA    ,X
C230: BD 60 AF       JSR    $422D
C233: 86 02          LDA    #$20
C235: BD C0 AF       JSR    $422D
C238: 33 69          LEAU   $1,U
C23A: 8D CA          BSR    $C27E
C23C: D6 5D          LDB    $75
C23E: A6 28          LDA    ,Y+
C240: BD 60 AF       JSR    $422D
C243: A6 82          LDA    ,Y+
C245: BD C0 AF       JSR    $422D
C248: A6 88          LDA    ,Y+
C24A: BD CA 05       JSR    $422D
C24D: 33 C9          LEAU   $1,U
C24F: BD 75 60       JSR    $5742
C252: 30 83          LEAX   $1,X
C254: BD 61 7E       JSR    $43FC
C257: 35 68          PULS   U
C259: 0C C0          INC    $48
C25B: 30 2D          LEAX   $5,X
C25D: 8C BB 60       CMPX   #$33E8
C260: 26 B1          BNE    $C1F5
C262: 8E B2 82       LDX    #$30A0
C265: 6F 06          CLR    ,X
C267: CC 00 A8       LDD    #$2880
C26A: ED 89          STD    $1,X
C26C: CC F2 C2       LDD    #$DA4A
C26F: ED 29          STD    $B,X
C271: 7F B6 76       CLR    $34F4
C274: BD A1 EF       JSR    $836D
C277: 86 B8          LDA    #$90
C279: 97 A3          STA    $2B
C27B: 0C 02          INC    event_sub_state_2a
C27D: 39             RTS

C27E: 10 8E 11 42    LDY    #$3360
C282: A6 06          LDA    ,X
C284: 4A             DECA
C285: C6 81          LDB    #$03
C287: 3D             MUL
C288: 31 83          LEAY   D,Y
C28A: 39             RTS

C28B: 96 27          LDA    $0F
C28D: 84 8B          ANDA   #$03
C28F: 26 29          BNE    $C29C
C291: CE AB 05       LDU    #$2987
C294: CC 33 85       LDD    #$1107
C297: DD 60          STD    $48
C299: BD F5 95       JSR    $7D1D
C29C: 96 27          LDA    $0F
C29E: 84 8C          ANDA   #$04
C2A0: 27 27          BEQ    $C2A7
C2A2: CC 83 22       LDD    #$0100
C2A5: 20 81          BRA    $C2AA
C2A7: CC 29 29       LDD    #$0101
C2AA: BD C6 B2       JSR    queue_event_4e9a
C2AD: 8E B8 28       LDX    #$30A0
C2B0: BD A1 EF       JSR    $836D
C2B3: 8D 2C          BSR    $C2C3
C2B5: 96 8D          LDA    $0F
C2B7: 44             LSRA
C2B8: 24 20          BCC    $C2C2
C2BA: 0A A3          DEC    $2B
C2BC: 26 2C          BNE    $C2C2
C2BE: 0C A0          INC    event_sub_state_28
C2C0: 0F 08          CLR    event_sub_state_2a
C2C2: 39             RTS

C2C3: 8E 11 F2       LDX    #$33D0
C2C6: A6 06          LDA    ,X
C2C8: 85 38          BITA   #$10
C2CA: 27 8C          BEQ    $C2D0
C2CC: 30 2E          LEAX   $6,X
C2CE: 20 7E          BRA    $C2C6
C2D0: A6 A6          LDA    ,X
C2D2: 4A             DECA
C2D3: 97 3B          STA    $19
C2D5: D6 8D          LDB    $0F
C2D7: C4 2C          ANDB   #$04
C2D9: 27 8B          BEQ    $C2DE
C2DB: 5F             CLRB
C2DC: 20 2D          BRA    $C2E3
C2DE: CE 47 C7       LDU    #$CFE5
C2E1: E6 44          LDB    A,U
C2E3: D7 57          STB    $75
C2E5: CE A0 4B       LDU    #$22C9
C2E8: A6 AC          LDA    ,X
C2EA: BD CA 05       JSR    $422D
C2ED: 86 A8          LDA    #$20
C2EF: BD 60 0F       JSR    $422D
C2F2: 33 C3          LEAU   $1,U
C2F4: BD E0 FC       JSR    $C27E
C2F7: D6 5D          LDB    $75
C2F9: A6 28          LDA    ,Y+
C2FB: BD 6A 05       JSR    $422D
C2FE: A6 28          LDA    ,Y+
C300: BD 60 AF       JSR    $422D
C303: A6 82          LDA    ,Y+
C305: BD C0 AF       JSR    $422D
C308: 33 69          LEAU   $1,U
C30A: BD DF 6A       JSR    $5742
C30D: 30 89          LEAX   $1,X
C30F: BD 61 DE       JSR    $43FC
C312: 30 87          LEAX   $5,X
C314: 39             RTS

C315: 0A AB          DEC    $29
C317: 26 25          BNE    $C326
C319: 7F BC 78       CLR    $34F0
C31C: CE D0 55       LDU   #table_f8dd
C31F: 96 4B          LDA    current_event_69
C321: 48             ASLA
C322: AD 54          JSR    [A,U]        ; [jump_table]
C324: 0C 0A          INC    event_sub_state_28
C326: 39             RTS

C327: 96 E3          LDA    $CB
C329: 26 89          BNE    $C32C
C32B: 39             RTS

C32C: 96 42          LDA    $6A
C32E: 81 8A          CMPA   #$02
C330: 26 DB          BNE    $C32B
C332: BD D0 66       JSR    $5244
C335: 8E B1 02       LDX    #$3380
C338: 96 42          LDA    $6A
C33A: D6 E1          LDB    current_event_69
C33C: C1 2A          CMPB   #$02
C33E: 26 8A          BNE    $C342
C340: 96 4D          LDA    $6F
C342: C6 87          LDB    #$05
C344: 3D             MUL
C345: 30 09          LEAX   D,X
C347: 96 31          LDA    $19
C349: C6 87          LDB    #$0F
C34B: 3D             MUL
C34C: 30 A3          LEAX   D,X
C34E: A6 0C          LDA    ,X
C350: 81 34          CMPA   #$16
C352: 27 97          BEQ    $C369
C354: CE DA 69       LDU   #table_f8eb
C357: 96 41          LDA    current_event_69
C359: 48             ASLA
C35A: 6E 5E          JMP    [A,U]        ; [jump_table]
C35C: 86 8A          LDA    #$A2
C35E: BD C6 91       JSR    force_queue_sound_event_4eb3
C361: 86 06          LDA    #$84
C363: BD 6C 91       JSR    force_queue_sound_event_4eb3
C366: 7E 46 4D       JMP    $C465
C369: 96 E1          LDA    current_event_69
C36B: 81 2A          CMPA   #$02
C36D: 27 87          BEQ    $C37E
C36F: 86 A0          LDA    #$82
C371: BD CC 31       JSR    force_queue_sound_event_4eb3
C374: 86 DD          LDA    #$FF
C376: BD CC 9B       JSR    force_queue_sound_event_4eb3
C379: 86 89          LDA    #$01
C37B: B7 1C D8       STA    $34F0
C37E: 39             RTS

C37F: A6 23          LDA    $1,X
C381: 8B 12          ADDA   #$90
C383: BD 6C 91       JSR    force_queue_sound_event_4eb3
C386: 86 2C          LDA    #$AE
C388: BD 66 3B       JSR    force_queue_sound_event_4eb3
C38B: 30 29          LEAX   $1,X
C38D: BD 4C 17       JSR    $C49F
C390: 86 A1          LDA    #$83
C392: BD CC 91       JSR    force_queue_sound_event_4eb3
C395: 86 7D          LDA    #$FF
C397: 7E 66 9B       JMP    force_queue_sound_event_4eb3
C39A: 8E BB F9       LDX    #$33D1
C39D: A6 97          LDA    -$1,X
C39F: 27 34          BEQ    $C3B7
C3A1: 85 92          BITA   #$10
C3A3: 26 30          BNE    $C3B7
C3A5: 0D 98          TST    $1A
C3A7: 27 3A          BEQ    $C3BB
C3A9: D6 93          LDB    $1B
C3AB: 26 2E          BNE    $C3B3
C3AD: 81 8B          CMPA   #$03
C3AF: 25 28          BCS    $C3BB
C3B1: 20 86          BRA    $C3B7
C3B3: 81 21          CMPA   #$03
C3B5: 24 86          BCC    $C3BB
C3B7: 30 2E          LEAX   $6,X
C3B9: 20 6A          BRA    $C39D
C3BB: 86 8A          LDA    #$A2
C3BD: BD C6 3B       JSR    force_queue_sound_event_4eb3
C3C0: 86 A5          LDA    #$87
C3C2: BD CC 91       JSR    force_queue_sound_event_4eb3
C3C5: A6 06          LDA    ,X
C3C7: 27 2D          BEQ    $C3CE
C3C9: 8B 18          ADDA   #$90
C3CB: BD 66 9B       JSR    force_queue_sound_event_4eb3
C3CE: BD 4C BD       JSR    $C49F
C3D1: 86 07          LDA    #$85
C3D3: BD 6C 91       JSR    force_queue_sound_event_4eb3
C3D6: 30 80          LEAX   $2,X
C3D8: A6 29          LDA    $1,X
C3DA: C6 82          LDB    #$0A
C3DC: 3D             MUL
C3DD: EB 8A          ADDB   $2,X
C3DF: C1 28          CMPB   #$0A
C3E1: 25 A2          BCS    $C403
C3E3: C1 36          CMPB   #$14
C3E5: 25 A0          BCS    $C409
C3E7: A6 2A          LDA    $2,X
C3E9: 27 9A          BEQ    $C3FD
C3EB: CE D7 CE       LDU    #$FFE6
C3EE: A6 89          LDA    $1,X
C3F0: 80 20          SUBA   #$02
C3F2: A6 44          LDA    A,U
C3F4: BD 6C 31       JSR    force_queue_sound_event_4eb3
C3F7: A6 2A          LDA    $2,X
C3F9: 8B 3D          ADDA   #$B5
C3FB: 20 3B          BRA    $C410
C3FD: A6 89          LDA    $1,X
C3FF: 8B F2          ADDA   #$D0
C401: 20 8F          BRA    $C410
C403: A6 20          LDA    $2,X
C405: 8B 37          ADDA   #$B5
C407: 20 2F          BRA    $C410
C409: CE 70 71       LDU    #$F8F9
C40C: C0 22          SUBB   #$0A
C40E: A6 4D          LDA    B,U
C410: BD 6C 31       JSR    force_queue_sound_event_4eb3
C413: 86 DD          LDA    #$FF
C415: 7E CC 31       JMP    force_queue_sound_event_4eb3
C418: 30 37          LEAX   -$1,X
C41A: A6 89          LDA    $1,X
C41C: 27 19          BEQ    $C44F
C41E: C6 82          LDB    #$0A
C420: 3D             MUL
C421: EB 80          ADDB   $2,X
C423: 27 2A          BEQ    $C42D
C425: BD 46 24       JSR    $C4A6
C428: 86 A2          LDA    #$8A
C42A: BD C6 9B       JSR    force_queue_sound_event_4eb3
C42D: 30 8B          LEAX   $3,X
C42F: A6 A6          LDA    ,X
C431: 27 92          BEQ    $C443
C433: 8B B2          ADDA   #$90
C435: 81 14          CMPA   #$96
C437: 26 2A          BNE    $C43B
C439: 86 28          LDA    #$A0
C43B: BD 66 9B       JSR    force_queue_sound_event_4eb3
C43E: 86 26          LDA    #$AE
C440: BD 6C 31       JSR    force_queue_sound_event_4eb3
C443: 8D 78          BSR    $C49F
C445: 86 30          LDA    #$B2
C447: BD 66 9B       JSR    force_queue_sound_event_4eb3
C44A: 86 77          LDA    #$FF
C44C: 7E 66 3B       JMP    force_queue_sound_event_4eb3
C44F: 30 23          LEAX   $1,X
C451: A6 83          LDA    $1,X
C453: C6 28          LDB    #$0A
C455: 3D             MUL
C456: EB 80          ADDB   $2,X
C458: 27 2F          BEQ    $C461
C45A: 8D C2          BSR    $C4A6
C45C: 86 86          LDA    #$AE
C45E: BD C6 91       JSR    force_queue_sound_event_4eb3
C461: 30 80          LEAX   $2,X
C463: 20 FC          BRA    $C443
C465: 8D BA          BSR    $C49F
C467: 86 AD          LDA    #$85
C469: BD C6 3B       JSR    force_queue_sound_event_4eb3
C46C: A6 2B          LDA    $3,X
C46E: 8B 18          ADDA   #$90
C470: 81 B4          CMPA   #$96
C472: 26 80          BNE    $C476
C474: 86 82          LDA    #$A0
C476: BD CC 9B       JSR    force_queue_sound_event_4eb3
C479: 96 E1          LDA    current_event_69
C47B: 81 2E          CMPA   #$06
C47D: 27 9F          BEQ    $C496
C47F: A6 26          LDA    $4,X
C481: 8B 12          ADDA   #$90
C483: 81 B4          CMPA   #$96
C485: 26 80          BNE    $C489
C487: 86 88          LDA    #$A0
C489: BD C6 3B       JSR    force_queue_sound_event_4eb3
C48C: 86 AE          LDA    #$86
C48E: BD C6 91       JSR    force_queue_sound_event_4eb3
C491: 86 7D          LDA    #$FF
C493: 7E 6C 91       JMP    force_queue_sound_event_4eb3
C496: A6 86          LDA    $4,X
C498: 8B 9D          ADDA   #$B5
C49A: BD C6 9B       JSR    force_queue_sound_event_4eb3
C49D: 20 7A          BRA    $C491
C49F: A6 23          LDA    $1,X
C4A1: C6 88          LDB    #$0A
C4A3: 3D             MUL
C4A4: EB 20          ADDB   $2,X
C4A6: C1 8C          CMPB   #$0E
C4A8: 25 32          BCS    $C4C4
C4AA: C1 9C          CMPB   #$14
C4AC: 25 34          BCS    $C4CA
C4AE: CE 77 C4       LDU    #$FFE6
C4B1: A6 83          LDA    $1,X
C4B3: 80 20          SUBA   #$02
C4B5: A6 44          LDA    A,U
C4B7: BD 66 9B       JSR    force_queue_sound_event_4eb3
C4BA: A6 8A          LDA    $2,X
C4BC: 27 2D          BEQ    $C4C3
C4BE: 8B 18          ADDA   #$90
C4C0: BD 6C 31       JSR    force_queue_sound_event_4eb3
C4C3: 39             RTS

C4C4: CB B2          ADDB   #$90
C4C6: 1F 1A          TFR    B,A
C4C8: 20 DE          BRA    $C4C0
C4CA: CE 77 C8       LDU    #$FFE0
C4CD: C0 86          SUBB   #$0E
C4CF: A6 E7          LDA    B,U
C4D1: 20 6F          BRA    $C4C0
C4D3: 96 08          LDA    event_sub_state_2a
C4D5: 48             ASLA
C4D6: CE 7B 2B       LDU   #table_f903
C4D9: 6E 5E          JMP    [A,U]        ; [jump_table]
C4DB: CC 28 28       LDD    #$0000
C4DE: DD A4          STD    $2C
C4E0: DD 0C          STD    $2E
C4E2: D6 EA          LDB    current_level_68
C4E4: C1 20          CMPB   #$02
C4E6: 27 8C          BEQ    $C4F6
C4E8: 4F             CLRA
C4E9: C3 88 89       ADDD   #$0001
C4EC: 83 28 8F       SUBD   #$0007
C4EF: 27 27          BEQ    $C4F6
C4F1: 24 7B          BCC    $C4EC
C4F3: 0C 0A          INC    event_sub_state_28
C4F5: 39             RTS

C4F6: 8E B7 28       LDX    #$3500
C4F9: C6 8C          LDB    #$04
C4FB: A6 AC          LDA    ,X
C4FD: 26 86          BNE    $C50D
C4FF: 30 AA 02       LEAX   $20,X
C502: 5A             DECB
C503: 26 D4          BNE    $C4FB
C505: CC 82 82       LDD    #$0000
C508: DD 02          STD    event_sub_state_2a
C50A: 0C A0          INC    event_sub_state_28
C50C: 39             RTS

C50D: BD 43 25       JSR    $CBAD
C510: D6 68          LDB    $4A
C512: F7 B6 02       STB    $3420
C515: 0C A8          INC    event_sub_state_2a
C517: 0F 03          CLR    $2B
C519: BD 27 27       JSR    $AFAF
C51C: BD E3 15       JSR    $CB9D
C51F: 7F 16 05       CLR    $3427
C522: 7F B6 0A       CLR    $3428
C525: 86 83          LDA    #$01
C527: B7 1C 02       STA    $342A
C52A: 7E 4D 05       JMP    $C52D
C52D: 8E BD 88       LDX    #$3500
C530: C6 26          LDB    #$04
C532: 0F CA          CLR    $48
C534: A6 A6          LDA    ,X
C536: 27 80          BEQ    $C53A
C538: 0C 60          INC    $48
C53A: 30 00 08       LEAX   $20,X
C53D: 5A             DECB
C53E: 26 7C          BNE    $C534
C540: CE DB E3       LDU    #$F961
C543: 96 6A          LDA    $48
C545: 26 8A          BNE    $C54F
C547: CC 28 28       LDD    #$0000
C54A: DD A2          STD    event_sub_state_2a
C54C: 0C 00          INC    event_sub_state_28
C54E: 39             RTS

C54F: 4A             DECA
C550: 48             ASLA
C551: EE 44          LDU    A,U
C553: 4F             CLRA
C554: D6 4A          LDB    current_level_68
C556: C1 80          CMPB   #$02
C558: 27 39          BEQ    $C56B
C55A: 86 8C          LDA    #$04
C55C: D6 25          LDB    dsw2_copy_0d
C55E: C4 89          ANDB   #$01
C560: 27 2B          BEQ    $C56B
C562: 8E 7B 07       LDX    #$F925
C565: EC 03          LDD    ,X++
C567: D1 40          CMPB   current_level_68
C569: 25 72          BCS    $C565
C56B: B7 1C 18       STA    $3430
C56E: 48             ASLA
C56F: EE E4          LDU    A,U
C571: C6 80          LDB    #$02
C573: A6 E2          LDA    ,U+
C575: 34 C6          PSHS   U,B
C577: BD 66 9B       JSR    force_queue_sound_event_4eb3
C57A: 35 CC          PULS   B,U
C57C: 5A             DECB
C57D: 26 7C          BNE    $C573
C57F: EC E3          LDD    ,U++
C581: FD B6 A9       STD    $342B
C584: EC E3          LDD    ,U++
C586: FD B6 05       STD    $342D
C589: 39             RTS

C58A: CE 71 25       LDU   #table_f90d
C58D: 96 A3          LDA    $2B
C58F: 84 21          ANDA   #$03
C591: 48             ASLA
C592: 0C A9          INC    $2B
C594: 6E F4          JMP    [A,U]        ; [jump_table]
C596: 0C A8          INC    event_sub_state_2a
C598: 0F 03          CLR    $2B
C59A: 8E 73 5F       LDX    #$FB77
C59D: BD 44 B9       JSR    $CC31
C5A0: 86 21          LDA    #$03
C5A2: BD 4E 69       JSR    $CC4B
C5A5: 7E 39 29       JMP    $BBAB
C5A8: 8E 1C 88       LDX    #$3400
C5AB: F6 1C 08       LDB    $3420
C5AE: 58             ASLB
C5AF: FB 16 02       ADDB   $3420
C5B2: 58             ASLB
C5B3: 30 A7          LEAX   B,X
C5B5: A6 06          LDA    ,X
C5B7: B7 1C 0B       STA    $3423
C5BA: 0D 92          TST    $1A
C5BC: 26 2E          BNE    $C5C4
C5BE: 44             LSRA
C5BF: B7 36 A2       STA    flip_screen_set_1480
C5C2: 97 80          STA    $02
C5C4: 34 32          PSHS   X
C5C6: 86 81          LDA    #$03
C5C8: BD E4 C3       JSR    $CC4B
C5CB: BD 93 83       JSR    $BBAB
C5CE: 35 98          PULS   X
C5D0: EE 23          LDU    $1,X
C5D2: FF B6 03       STU    $3421
C5D5: 8E 7B 9D       LDX    #$F91F
C5D8: B6 1C A8       LDA    $3420
C5DB: 48             ASLA
C5DC: EC AE          LDD    A,X
C5DE: ED C9          STD    $1,U
C5E0: 4F             CLRA
C5E1: F6 B6 A2       LDB    $3420
C5E4: 26 2D          BNE    $C5F5
C5E6: B6 B6 18       LDA    $3430
C5E9: 97 A4          STA    $2C
C5EB: 0C 02          INC    event_sub_state_2a
C5ED: CE 71 9D       LDU   #table_f915
C5F0: 96 0E          LDA    $2C
C5F2: 48             ASLA
C5F3: 6E F4          JMP    [A,U]        ; [jump_table]
C5F5: 0C A8          INC    event_sub_state_2a
C5F7: 97 04          STA    $2C
C5F9: 7E 4E 60       JMP    $C6E8
C5FC: BD EE 9F       JSR    $C617
C5FF: BD 75 92       JSR    $57B0
C602: BD 4E E3       JSR    $CCC1
C605: B6 B6 A2       LDA    $3420
C608: 10 26 89 AC    LBNE   $C730
C60C: CE D1 B9       LDU   #table_f931
C60F: 96 0E          LDA    $2C
C611: 48             ASLA
C612: AD 54          JSR    [A,U]        ; [jump_table]
C614: 7E 99 29       JMP    $BBAB
C617: B6 1C 02       LDA    $342A
C61A: 26 89          BNE    $C61D
C61C: 39             RTS

C61D: 0F C0          CLR    $48
C61F: 8E 12 82       LDX    #$30A0
C622: 96 CA          LDA    $48
C624: 48             ASLA
C625: 48             ASLA
C626: 48             ASLA
C627: 48             ASLA
C628: 48             ASLA
C629: CE BD 88       LDU    #$3500
C62C: A6 EE          LDA    A,U
C62E: 26 A7          BNE    $C65F
C630: CE DB 57       LDU    #$F9D5
C633: 96 6A          LDA    $48
C635: 97 9B          STA    $19
C637: 48             ASLA
C638: 10 AE 4E       LDY    A,U
C63B: 10 AF 29       STY    $1,X
C63E: CE 71 FF       LDU    #$F9DD
C641: EE 44          LDU    A,U
C643: 10 8E D8 05    LDY    #$FA87
C647: B6 1C 00       LDA    $3428
C64A: 84 97          ANDA   #$1F
C64C: 81 27          CMPA   #$0F
C64E: 24 8C          BCC    $C654
C650: 10 8E 78 13    LDY    #$FA91
C654: 96 6A          LDA    $48
C656: 84 83          ANDA   #$01
C658: 26 2A          BNE    $C65C
C65A: 31 AD          LEAY   $5,Y
C65C: BD E4 8F       JSR    $CC07
C65F: 30 AA 42       LEAX   $60,X
C662: 96 CA          LDA    $48
C664: 91 23          CMPA   $01
C666: 27 87          BEQ    $C66D
C668: 4C             INCA
C669: 97 C0          STA    $48
C66B: 20 9D          BRA    $C622
C66D: 7C BC A0       INC    $3428
C670: BD E8 46       JSR    $CAC4
C673: 8E 12 82       LDX    #$30A0
C676: 7F B6 07       CLR    $342F
C679: A6 0C          LDA    ,X
C67B: 27 2A          BEQ    $C67F
C67D: 8D 87          BSR    $C68E
C67F: 30 AA 42       LEAX   $60,X
C682: B6 B6 0D       LDA    $342F
C685: 4C             INCA
C686: B7 B6 07       STA    $342F
C689: 81 8C          CMPA   #$04
C68B: 26 C4          BNE    $C679
C68D: 39             RTS

C68E: 6A 8D          DEC    $5,X
C690: 2A 13          BPL    $C6C3
C692: 10 AE 2F       LDY    $D,X
C695: A6 22          LDA    ,Y+
C697: 81 D7          CMPA   #$FF
C699: 26 81          BNE    $C6A4
C69B: EE 89          LDU    ,Y++
C69D: EF 83          STU    $B,X
C69F: 10 AE 86       LDY    ,Y
C6A2: A6 22          LDA    ,Y+
C6A4: A7 27          STA    $5,X
C6A6: 10 AF 25       STY    $D,X
C6A9: 10 AE 83       LDY    $B,X
C6AC: B6 1C A7       LDA    $342F
C6AF: 97 3B          STA    $19
C6B1: CE 7B 5F       LDU    #$F9DD
C6B4: 48             ASLA
C6B5: EE 44          LDU    A,U
C6B7: BD AF 9C       JSR    $87B4
C6BA: 10 AE 23       LDY    $B,X
C6BD: 31 AD          LEAY   $5,Y
C6BF: 10 AF 29       STY    $B,X
C6C2: 39             RTS

C6C3: 10 AE 29       LDY    $B,X
C6C6: 31 B9          LEAY   -$5,Y
C6C8: B6 1C A7       LDA    $342F
C6CB: 97 31          STA    $19
C6CD: CE 71 55       LDU    #$F9DD
C6D0: 48             ASLA
C6D1: EE 44          LDU    A,U
C6D3: 7E A5 96       JMP    $87B4
C6D6: B6 B6 06       LDA    $342E
C6D9: 27 8D          BEQ    $C6E0
C6DB: 4A             DECA
C6DC: B7 1C A6       STA    $342E
C6DF: 39             RTS

C6E0: CC 22 82       LDD    #$0000
C6E3: DD 08          STD    event_sub_state_2a
C6E5: 0C AA          INC    event_sub_state_28
C6E7: 39             RTS

C6E8: B6 1C A8       LDA    $3420
C6EB: BD E4 63       JSR    $CC4B
C6EE: BD 33 89       JSR    $BBAB
C6F1: B6 B6 A9       LDA    $342B
C6F4: B7 16 A6       STA    $3424
C6F7: BE 1C 09       LDX    $3421
C6FA: 10 8E D1 C5    LDY    #$F9ED
C6FE: BD 43 65       JSR    $CB47
C701: 10 8E 7B D0    LDY    #$F9F2
C705: 10 AF 89       STY    $B,X
C708: CE D1 7F       LDU    #$F9F7
C70B: A6 E8          LDA    ,U+
C70D: A7 8D          STA    $5,X
C70F: EF 2F          STU    $D,X
C711: 39             RTS

C712: B6 B6 02       LDA    $3420
C715: BD 4E C9       JSR    $CC4B
C718: B6 1C A4       LDA    $342C
C71B: B7 1C 0C       STA    $3424
C71E: 7F BC 04       CLR    $3426
C721: BE B6 A3       LDX    $3421
C724: A6 20          LDA    $2,X
C726: 80 8A          SUBA   #$08
C728: A7 2A          STA    $2,X
C72A: A6 89          LDA    $1,X
C72C: A7 27          STA    $F,X
C72E: 39             RTS

C72F: 39             RTS

C730: BD 99 29       JSR    $BBAB
C733: 96 2D          LDA    $0F
C735: 84 81          ANDA   #$03
C737: 26 2D          BNE    $C73E
C739: 7A BC AC       DEC    $3424
C73C: 27 2E          BEQ    $C744
C73E: BE BC 03       LDX    $3421
C741: 7E 49 D7       JMP    $CB55
C744: 6C BD B6 A3    INC    [$3421]
C748: CC 28 88       LDD    #$0000
C74B: 7A 1C 08       DEC    $3420
C74E: 2B 80          BMI    $C758
C750: DD 0E          STD    $2C
C752: CC 80 22       LDD    #$0200
C755: DD A8          STD    event_sub_state_2a
C757: 39             RTS

C758: DD 04          STD    $2C
C75A: 0C A2          INC    event_sub_state_2a
C75C: 86 68          LDA    #$40
C75E: 97 A3          STA    $2B
C760: 39             RTS

C761: BE B6 A3       LDX    $3421
C764: B6 16 A4       LDA    $3426
C767: CE D2 C3       LDU    #$FAEB
C76A: A6 4E          LDA    A,U
C76C: C6 68          LDB    #$40
C76E: 3D             MUL
C76F: AB 2D          ADDA   $F,X
C771: A7 83          STA    $1,X
C773: 10 8E D8 92    LDY    #$FA10
C777: B6 1C 0E       LDA    $3426
C77A: 2B AE          BMI    $C7A2
C77C: 81 16          CMPA   #$3E
C77E: 24 AA          BCC    $C7A2
C780: 81 02          CMPA   #$20
C782: 24 8E          BCC    $C790
C784: 10 8E 78 89    LDY    #$FA0B
C788: 81 38          CMPA   #$10
C78A: 24 8C          BCC    $C790
C78C: 10 8E 72 8E    LDY    #$FA06
C790: BD E9 C5       JSR    $CB47
C793: B6 16 06       LDA    $3424
C796: 84 83          ANDA   #$01
C798: 26 2C          BNE    $C79E
C79A: 7C BC 0E       INC    $3426
C79D: 39             RTS

C79E: 7A BC 04       DEC    $3426
C7A1: 39             RTS

C7A2: B6 B6 06       LDA    $3424
C7A5: 4A             DECA
C7A6: B7 B6 0C       STA    $3424
C7A9: 27 80          BEQ    $C7B3
C7AB: 84 29          ANDA   #$01
C7AD: 26 67          BNE    $C79E
C7AF: 7C 16 04       INC    $3426
C7B2: 39             RTS

C7B3: CC 22 22       LDD    #$0000
C7B6: DD AE          STD    $2C
C7B8: 0C 02          INC    event_sub_state_2a
C7BA: 86 C8          LDA    #$40
C7BC: 97 03          STA    $2B
C7BE: 39             RTS

C7BF: 96 0C          LDA    $2E
C7C1: 48             ASLA
C7C2: CE 7B 19       LDU   #table_f93b
C7C5: 6E 54          JMP    [A,U]        ; [jump_table]
C7C7: B6 1C 08       LDA    $3420
C7CA: BD 44 63       JSR    $CC4B
C7CD: BE BC A9       LDX    $3421
C7D0: B6 16 AF       LDA    $342D
C7D3: B7 16 06       STA    $3424
C7D6: A6 83          LDA    $1,X
C7D8: A7 27          STA    $F,X
C7DA: 7F BC 0E       CLR    $3426
C7DD: BE BC A9       LDX    $3421
C7E0: 10 8E 78 97    LDY    #$FA15
C7E4: BD E9 C5       JSR    $CB47
C7E7: 10 8E D2 92    LDY    #$FA1A
C7EB: 10 AF 23       STY    $B,X
C7EE: CE 72 3D       LDU    #$FA1F
C7F1: A6 42          LDA    ,U+
C7F3: A7 27          STA    $5,X
C7F5: EF 8F          STU    $D,X
C7F7: 86 29          LDA    #$01
C7F9: 97 A6          STA    $2E
C7FB: 39             RTS

C7FC: BE 1C A9       LDX    $3421
C7FF: B6 16 04       LDA    $3426
C802: CE 78 C9       LDU    #$FAEB
C805: A6 44          LDA    A,U
C807: C6 68          LDB    #$40
C809: 3D             MUL
C80A: AB 87          ADDA   $F,X
C80C: A7 29          STA    $1,X
C80E: B6 BC 04       LDA    $3426
C811: 4C             INCA
C812: B7 B6 04       STA    $3426
C815: 81 A2          CMPA   #$20
C817: 27 20          BEQ    $C821
C819: 81 C8          CMPA   #$40
C81B: 27 34          BEQ    $C839
C81D: 7E 43 DD       JMP    $CB55
C820: 39             RTS

C821: 10 8E 78 04    LDY    #$FA26
C825: BD 49 C5       JSR    $CB47
C828: 10 8E 72 A3    LDY    #$FA2B
C82C: 10 AF 83       STY    $B,X
C82F: CE D8 6C       LDU    #$FA4E
C832: A6 42          LDA    ,U+
C834: A7 27          STA    $5,X
C836: EF 8F          STU    $D,X
C838: 39             RTS

C839: 86 8A          LDA    #$02
C83B: 97 06          STA    $2E
C83D: 7A BC AC       DEC    $3424
C840: 26 2B          BNE    $C84B
C842: 96 AE          LDA    $2C
C844: 81 23          CMPA   #$01
C846: 27 81          BEQ    $C84B
C848: BD E0 C4       JSR    $C84C
C84B: 39             RTS

C84C: 7C 1C AF       INC    $3427
C84F: BD 8D 8D       JSR    $AFAF
C852: BD 4E 84       JSR    $CCA6
C855: 8E 79 69       LDX    #$FBEB
C858: BD E4 B9       JSR    $CC31
C85B: 10 8E D3 A4    LDY    #$FB2C
C85F: C6 25          LDB    #$07
C861: D7 CA          STB    $48
C863: AE 83          LDX    ,Y++
C865: EE 23          LDU    ,Y++
C867: EC 89          LDD    ,Y++
C869: ED 89          STD    $1,X
C86B: EC 89          LDD    ,Y++
C86D: ED 8B          STD    $3,X
C86F: 0A 6A          DEC    $48
C871: 26 72          BNE    $C863
C873: BD E9 34       JSR    $CB16
C876: 7F B6 02       CLR    $342A
C879: 39             RTS

C87A: 39             RTS

C87B: 0C 06          INC    $2E
C87D: 39             RTS

C87E: BE BC 03       LDX    $3421
C881: B6 B6 A4       LDA    $3426
C884: CE D8 69       LDU    #$FAEB
C887: A6 EE          LDA    A,U
C889: C6 C8          LDB    #$40
C88B: 3D             MUL
C88C: AB 27          ADDA   $F,X
C88E: A7 89          STA    $1,X
C890: B6 16 A4       LDA    $3426
C893: 4A             DECA
C894: B7 16 A4       STA    $3426
C897: 81 08          CMPA   #$20
C899: 27 A9          BEQ    $C8BC
C89B: 4D             TSTA
C89C: 27 2B          BEQ    $C8A1
C89E: 7E 43 77       JMP    $CB55
C8A1: 96 AE          LDA    $2C
C8A3: 81 23          CMPA   #$01
C8A5: 10 26 7D 19    LBNE   $C7DA
C8A9: B6 BC AC       LDA    $3424
C8AC: 10 26 77 A2    LBNE   $C7DA
C8B0: 86 26          LDA    #$04
C8B2: 97 A8          STA    event_sub_state_2a
C8B4: CC 22 82       LDD    #$0000
C8B7: DD 04          STD    $2C
C8B9: DD A6          STD    $2E
C8BB: 39             RTS

C8BC: 96 04          LDA    $2C
C8BE: 81 89          CMPA   #$01
C8C0: 27 27          BEQ    $C8C7
C8C2: B6 B6 06       LDA    $3424
C8C5: 27 9A          BEQ    $C8DF
C8C7: 10 8E D2 D3    LDY    #$FA5B
C8CB: BD E3 6F       JSR    $CB47
C8CE: 10 8E D8 42    LDY    #$FA60
C8D2: 10 AF 29       STY    $B,X
C8D5: CE 78 E7       LDU    #$FA65
C8D8: A6 E8          LDA    ,U+
C8DA: A7 8D          STA    $5,X
C8DC: EF 25          STU    $D,X
C8DE: 39             RTS

C8DF: 0C 0C          INC    $2E
C8E1: 39             RTS

C8E2: 0C AC          INC    $2E
C8E4: BE 16 A3       LDX    $3421
C8E7: 10 8E D2 E4    LDY    #$FA6C
C8EB: BD E3 6F       JSR    $CB47
C8EE: 10 8E D8 53    LDY    #$FA71
C8F2: 10 AF 29       STY    $B,X
C8F5: CE 78 F3       LDU    #$FA71
C8F8: A6 E8          LDA    ,U+
C8FA: A7 8D          STA    $5,X
C8FC: EF 25          STU    $D,X
C8FE: 39             RTS

C8FF: BE 16 03       LDX    $3421
C902: A6 83          LDA    $1,X
C904: 4A             DECA
C905: A7 83          STA    $1,X
C907: 80 78          SUBA   #$50
C909: 24 8D          BCC    $C910
C90B: 86 2E          LDA    #$06
C90D: 97 A6          STA    $2E
C90F: 39             RTS

C910: B7 16 A4       STA    $3426
C913: BD E9 77       JSR    $CB55
C916: 7E 39 57       JMP    $BB7F
C919: CC 88 88       LDD    #$0000
C91C: DD 04          STD    $2C
C91E: DD A6          STD    $2E
C920: 86 26          LDA    #$04
C922: 97 A8          STA    event_sub_state_2a
C924: 39             RTS

C925: CE B2 42       LDU    #$30C0
C928: CC 28 88       LDD    #$0000
C92B: ED E9          STD    ,U++
C92D: 11 83 B9 22    CMPU   #$3100
C931: 25 7A          BCS    $C92B
C933: 7E 8D 8D       JMP    $AFAF
C936: BE B6 09       LDX    $3421
C939: A6 89          LDA    $1,X
C93B: A7 27          STA    $F,X
C93D: 86 8B          LDA    #$03
C93F: B7 16 06       STA    $3424
C942: 7F B6 04       CLR    $3426
C945: BE B6 A3       LDX    $3421
C948: 86 2F          LDA    #$07
C94A: 97 A6          STA    $2E
C94C: 39             RTS

C94D: BD 33 F7       JSR    $BB7F
C950: BE 16 A3       LDX    $3421
C953: B6 16 04       LDA    $3426
C956: CE 78 C3       LDU    #$FAEB
C959: A6 4E          LDA    A,U
C95B: C6 48          LDB    #$60
C95D: 3D             MUL
C95E: AB 87          ADDA   $F,X
C960: A7 23          STA    $1,X
C962: B6 B6 04       LDA    $3426
C965: 4C             INCA
C966: B7 B6 0E       STA    $3426
C969: 81 C8          CMPA   #$40
C96B: 27 2B          BEQ    $C970
C96D: 7E 43 DD       JMP    $CB55
C970: 7A 16 A6       DEC    $3424
C973: 96 0E          LDA    $2C
C975: 81 81          CMPA   #$03
C977: 24 2D          BCC    $C97E
C979: B6 BC AC       LDA    $3424
C97C: 27 2D          BEQ    $C983
C97E: 86 80          LDA    #$08
C980: 97 0C          STA    $2E
C982: 39             RTS

C983: CC 26 62       LDD    #$0440
C986: DD A8          STD    event_sub_state_2a
C988: 4F             CLRA
C989: DD A4          STD    $2C
C98B: DD 06          STD    $2E
C98D: 39             RTS

C98E: 86 81          LDA    #$09
C990: 97 0C          STA    $2E
C992: 39             RTS

C993: 96 0F          LDA    $2D
C995: 10 26 82 B9    LBNE   $CA2A
C999: 96 A4          LDA    $2C
C99B: 80 2A          SUBA   #$02
C99D: CE 71 C7       LDU   #table_f94f
C9A0: 48             ASLA
C9A1: 6E 54          JMP    [A,U]        ; [jump_table]
C9A3: 20 44          BRA    $CA0B
C9A5: B6 B6 A6       LDA    $3424
C9A8: 26 49          BNE    $CA0B
C9AA: F6 BC 0E       LDB    $3426
C9AD: C1 A8          CMPB   #$20
C9AF: 26 21          BNE    $C9B4
C9B1: BD 4B A7       JSR    $C925
C9B4: B6 16 A4       LDA    $3426
C9B7: 4A             DECA
C9B8: 26 79          BNE    $CA0B
C9BA: BE BC 09       LDX    $3421
C9BD: A6 89          LDA    $1,X
C9BF: 81 62          CMPA   #$40
C9C1: 25 85          BCS    $C9CA
C9C3: 80 20          SUBA   #$02
C9C5: A7 83          STA    $1,X
C9C7: 7E E3 7D       JMP    $CB55
C9CA: A6 89          LDA    $1,X
C9CC: A7 27          STA    $F,X
C9CE: 7F BC 04       CLR    $3426
C9D1: 86 83          LDA    #$01
C9D3: 97 0F          STA    $2D
C9D5: 39             RTS

C9D6: B6 B6 0C       LDA    $3424
C9D9: 26 B8          BNE    $CA0B
C9DB: F6 1C 0E       LDB    $3426
C9DE: C1 A8          CMPB   #$20
C9E0: 26 21          BNE    $C9E5
C9E2: BD 4B 07       JSR    $C925
C9E5: B6 B6 A4       LDA    $3426
C9E8: 4A             DECA
C9E9: 26 A8          BNE    $CA0B
C9EB: BE 1C 09       LDX    $3421
C9EE: A6 89          LDA    $1,X
C9F0: 81 62          CMPA   #$40
C9F2: 25 89          BCS    $C9FF
C9F4: 80 20          SUBA   #$02
C9F6: A7 83          STA    $1,X
C9F8: 10 8E 72 FF    LDY    #$FA77
C9FC: 7E E3 CF       JMP    $CB47
C9FF: A6 23          LDA    $1,X
CA01: A7 8D          STA    $F,X
CA03: 7F 16 04       CLR    $3426
CA06: 86 80          LDA    #$02
CA08: 97 05          STA    $2D
CA0A: 39             RTS

CA0B: BD 93 57       JSR    $BB7F
CA0E: BE BC 03       LDX    $3421
CA11: B6 B6 A4       LDA    $3426
CA14: CE D8 69       LDU    #$FAEB
CA17: A6 EE          LDA    A,U
CA19: C6 E8          LDB    #$60
CA1B: 3D             MUL
CA1C: AB 27          ADDA   $F,X
CA1E: A7 89          STA    $1,X
CA20: 7A 16 A4       DEC    $3426
CA23: 10 27 DD 99    LBEQ   $C942
CA27: 7E E3 7D       JMP    $CB55
CA2A: 96 A5          LDA    $2D
CA2C: 4A             DECA
CA2D: 48             ASLA
CA2E: CE 71 7B       LDU   #table_f959
CA31: 6E 54          JMP    [A,U]        ; [jump_table]
CA33: B6 16 04       LDA    $3426
CA36: 4C             INCA
CA37: B7 1C 0E       STA    $3426
CA3A: 81 E8          CMPA   #$60
CA3C: 27 0D          BEQ    $CA63
CA3E: CE 72 C9       LDU    #$FAEB
CA41: 1F 0B          TFR    A,B
CA43: 84 2D          ANDA   #$0F
CA45: 48             ASLA
CA46: 48             ASLA
CA47: C4 38          ANDB   #$10
CA49: 27 8C          BEQ    $CA4F
CA4B: 40             NEGA
CA4C: CE D3 A3       LDU    #$FB2B
CA4F: A6 E4          LDA    A,U
CA51: C6 8A          LDB    #$08
CA53: 3D             MUL
CA54: BE 16 A3       LDX    $3421
CA57: AB 27          ADDA   $F,X
CA59: A7 89          STA    $1,X
CA5B: 10 8E D2 0A    LDY    #$FA82
CA5F: BD E9 65       JSR    $CB47
CA62: 39             RTS

CA63: 86 21          LDA    #$03
CA65: 97 AF          STA    $2D
CA67: 39             RTS

CA68: B6 1C AE       LDA    $3426
CA6B: 4C             INCA
CA6C: B7 1C AE       STA    $3426
CA6F: 81 42          CMPA   #$60
CA71: 27 83          BEQ    $CA74
CA73: 39             RTS

CA74: 86 26          LDA    #$04
CA76: 97 AF          STA    $2D
CA78: 39             RTS

CA79: BE BC A9       LDX    $3421
CA7C: B6 1C AE       LDA    $3426
CA7F: 4C             INCA
CA80: 27 17          BEQ    $CAB7
CA82: B7 B6 04       STA    $3426
CA85: 10 8E 78 A4    LDY    #$FA8C
CA89: 84 97          ANDA   #$1F
CA8B: 81 27          CMPA   #$0F
CA8D: 10 24 88 94    LBCC   $CB47
CA91: 10 8E 78 B4    LDY    #$FA96
CA95: 7E 49 C5       JMP    $CB47
CA98: BE 1C A9       LDX    $3421
CA9B: B6 1C 0E       LDA    $3426
CA9E: 4C             INCA
CA9F: 27 34          BEQ    $CAB7
CAA1: B7 B6 A4       STA    $3426
CAA4: 10 8E 7B 6F    LDY    #$F9ED
CAA8: 84 37          ANDA   #$1F
CAAA: 81 87          CMPA   #$0F
CAAC: 10 24 88 1F    LBCC   $CB47
CAB0: 10 8E 7B 70    LDY    #$F9F2
CAB4: 7E E9 C5       JMP    $CB47
CAB7: CC 2C 68       LDD    #$0440
CABA: DD A2          STD    event_sub_state_2a
CABC: CC 28 88       LDD    #$0000
CABF: DD 0E          STD    $2C
CAC1: DD AC          STD    $2E
CAC3: 39             RTS

CAC4: 8E 17 82       LDX    #$3500
CAC7: C6 2C          LDB    #$04
CAC9: A6 0C          LDA    ,X
CACB: 27 60          BEQ    $CB15
CACD: 30 00 A8       LEAX   $20,X
CAD0: 5A             DECB
CAD1: 26 74          BNE    $CAC9
CAD3: B6 16 86       LDA    $34A4
CAD6: 27 BF          BEQ    $CB15
CAD8: 4A             DECA
CAD9: CE BD 88       LDU    #$3500
CADC: 48             ASLA
CADD: 48             ASLA
CADE: 48             ASLA
CADF: 48             ASLA
CAE0: 48             ASLA
CAE1: A6 44          LDA    A,U
CAE3: 27 12          BEQ    $CB15
CAE5: B6 B6 26       LDA    $34A4
CAE8: 4A             DECA
CAE9: 97 91          STA    $19
CAEB: 8E D1 CD       LDX    #$F9E5
CAEE: 48             ASLA
CAEF: AE A4          LDX    A,X
CAF1: CE 7B 5F       LDU    #$F9DD
CAF4: EE E4          LDU    A,U
CAF6: CC C2 08       LDD    #$4020
CAF9: ED 89          STD    $1,X
CAFB: B6 1C 01       LDA    $3429
CAFE: 4C             INCA
CAFF: B7 16 0B       STA    $3429
CB02: 84 8D          ANDA   #$0F
CB04: 10 8E 78 19    LDY    #$FA9B
CB08: 81 2F          CMPA   #$07
CB0A: 10 24 94 8E    LBCC   $87B4
CB0E: 10 8E D8 82    LDY    #$FAA0
CB12: 7E 05 96       JMP    $87B4
CB15: 39             RTS

CB16: 8E B2 E8       LDX    #$30C0
CB19: CE BE 88       LDU    #$3600
CB1C: 86 2A          LDA    #$02
CB1E: 97 C0          STA    $48
CB20: 10 AE 81       LDY    $3,X
CB23: BD AA BF       JSR    $889D
CB26: 33 CA          LEAU   $8,U
CB28: 30 20          LEAX   $8,X
CB2A: 0A C0          DEC    $48
CB2C: 26 DA          BNE    $CB20
CB2E: 8E B8 F2       LDX    #$30D0
CB31: CE B4 D2       LDU    #$3650
CB34: 86 27          LDA    #$05
CB36: 97 CA          STA    $48
CB38: 10 AE 8B       LDY    $3,X
CB3B: BD A0 B5       JSR    $889D
CB3E: 33 C0          LEAU   $8,U
CB40: 30 2A          LEAX   $8,X
CB42: 0A CA          DEC    $48
CB44: 26 D0          BNE    $CB38
CB46: 39             RTS

CB47: B6 1C 0B       LDA    $3423
CB4A: 97 91          STA    $19
CB4C: CE D1 55       LDU    #$F9DD
CB4F: 48             ASLA
CB50: EE E4          LDU    A,U
CB52: 7E 4E 25       JMP    $CC07
CB55: 6A 87          DEC    $5,X
CB57: 2A 19          BPL    $CB8A
CB59: 10 AE 85       LDY    $D,X
CB5C: A6 88          LDA    ,Y+
CB5E: 81 77          CMPA   #$FF
CB60: 26 2B          BNE    $CB6B
CB62: EE 23          LDU    ,Y++
CB64: EF 29          STU    $B,X
CB66: 10 AE 8C       LDY    ,Y
CB69: A6 28          LDA    ,Y+
CB6B: A7 2D          STA    $5,X
CB6D: 10 AF 85       STY    $D,X
CB70: 10 AE 89       LDY    $B,X
CB73: B6 16 01       LDA    $3423
CB76: 97 9B          STA    $19
CB78: CE D1 55       LDU    #$F9DD
CB7B: 48             ASLA
CB7C: EE EE          LDU    A,U
CB7E: BD 44 25       JSR    $CC07
CB81: 10 AE 89       LDY    $B,X
CB84: 31 07          LEAY   $5,Y
CB86: 10 AF 23       STY    $B,X
CB89: 39             RTS

CB8A: 10 AE 23       LDY    $B,X
CB8D: 31 B3          LEAY   -$5,Y
CB8F: B6 16 01       LDA    $3423
CB92: 97 9B          STA    $19
CB94: CE DB 5F       LDU    #$F9DD
CB97: 48             ASLA
CB98: EE EE          LDU    A,U
CB9A: 7E 44 2F       JMP    $CC07
CB9D: CE B8 28       LDU    #$30A0
CBA0: 10 8E 82 82    LDY    #$0000
CBA4: 86 E2          LDA    #$C0
CBA6: 10 AF E9       STY    ,U++
CBA9: 4A             DECA
CBAA: 26 72          BNE    $CBA6
CBAC: 39             RTS

CBAD: CE BC 88       LDU    #$3400
CBB0: 0F 6A          CLR    $48
CBB2: 0F C8          CLR    $4A
CBB4: 8E 16 1A       LDX    #$3498
CBB7: D6 60          LDB    $48
CBB9: 58             ASLB
CBBA: 58             ASLB
CBBB: E6 AD          LDB    B,X
CBBD: 27 B4          BEQ    $CBFB
CBBF: 5A             DECB
CBC0: D7 6B          STB    $49
CBC2: 58             ASLB
CBC3: 58             ASLB
CBC4: 58             ASLB
CBC5: 58             ASLB
CBC6: 58             ASLB
CBC7: 8E 1D 28       LDX    #$3500
CBCA: A6 0D          LDA    B,X
CBCC: 27 09          BEQ    $CBEF
CBCE: 96 C1          LDA    $49
CBD0: A7 E2          STA    ,U+
CBD2: 86 81          LDA    #$03
CBD4: 3D             MUL
CBD5: 8E B2 22       LDX    #$30A0
CBD8: 30 A3          LEAX   D,X
CBDA: AF 49          STX    ,U++
CBDC: 8E 1B E8       LDX    #$3360
CBDF: 96 6B          LDA    $49
CBE1: 48             ASLA
CBE2: 9B CB          ADDA   $49
CBE4: E6 A4          LDB    A,X
CBE6: E7 42          STB    ,U+
CBE8: 4C             INCA
CBE9: EC 0E          LDD    A,X
CBEB: ED E9          STD    ,U++
CBED: 0C C2          INC    $4A
CBEF: 96 6A          LDA    $48
CBF1: 81 81          CMPA   #$03
CBF3: 27 24          BEQ    $CBFB
CBF5: 4C             INCA
CBF6: 97 CA          STA    $48
CBF8: 20 92          BRA    $CBB4
CBFA: 39             RTS

CBFB: 96 62          LDA    $4A
CBFD: 4A             DECA
CBFE: 81 8B          CMPA   #$03
CC00: 25 20          BCS    $CC04
CC02: 86 80          LDA    #$02
CC04: 97 68          STA    $4A
CC06: 39             RTS

CC07: 0F 61          CLR    $49
CC09: 34 C8          PSHS   U
CC0B: CE D1 D6       LDU    #$F9FE
CC0E: 86 8C          LDA    #$04
CC10: 10 AC 43       CMPY   ,U++
CC13: 27 27          BEQ    $CC1A
CC15: 4A             DECA
CC16: 27 8A          BEQ    $CC20
CC18: 20 DE          BRA    $CC10
CC1A: 0C C1          INC    $49
CC1C: 86 D0          LDA    #$F8
CC1E: 8D 84          BSR    $CC2C
CC20: 35 62          PULS   U
CC22: BD 05 96       JSR    $87B4
CC25: 96 CB          LDA    $49
CC27: 26 29          BNE    $CC2A
CC29: 39             RTS

CC2A: 86 80          LDA    #$08
CC2C: AB 2A          ADDA   $2,X
CC2E: A7 8A          STA    $2,X
CC30: 39             RTS

CC31: 10 8E 79 46    LDY    #$FB64
CC35: A6 22          LDA    ,Y+
CC37: 27 39          BEQ    $CC4A
CC39: EE 29          LDU    ,Y++
CC3B: E6 A8          LDB    ,X+
CC3D: E7 41 80 22    STB    $0800,U		;  [video_address]
CC41: E6 02          LDB    ,X+
CC43: E7 E2          STB    ,U+		;  [video_address]
CC45: 4A             DECA
CC46: 26 71          BNE    $CC3B
CC48: 20 C3          BRA    $CC35
CC4A: 39             RTS

CC4B: B7 1C 68       STA    $3440
CC4E: CE 76 05       LDU    #$FE27
CC51: C6 91          LDB    #$13
CC53: 3D             MUL
CC54: 33 E7          LEAU   B,U
CC56: AE 43          LDX    ,U++
CC58: 34 38          PSHS   X
CC5A: A6 48          LDA    ,U+
CC5C: 27 2C          BEQ    $CC62
CC5E: A7 08          STA    ,X+
CC60: 20 DA          BRA    $CC5A
CC62: 35 92          PULS   X
CC64: 10 8E 7E 31    LDY    #$FCB3
CC68: B6 1C C8       LDA    $3440
CC6B: 81 2B          CMPA   #$03
CC6D: 24 83          BCC    $CC7A
CC6F: 48             ASLA
CC70: A6 94          LDA    [A,Y]
CC72: 10 8E DC 01    LDY    #$FE23
CC76: A6 24          LDA    A,Y
CC78: A7 2B          STA    $3,X
CC7A: B6 BC 68       LDA    $3440
CC7D: 81 8B          CMPA   #$03
CC7F: 27 06          BEQ    $CCA5
CC81: 8E 7E DD       LDX    #$FC5F
CC84: CE DE 31       LDU    #$FCB3
CC87: 48             ASLA
CC88: AE AE          LDX    A,X
CC8A: EE 4E          LDU    A,U
CC8C: EC 6B          LDD    $3,U
CC8E: ED 0C          STD    ,X
CC90: A6 67          LDA    $5,U
CC92: A7 80          STA    $2,X
CC94: 31 AB 8A 82    LEAY   $0800,X
CC98: A6 EC          LDA    ,U
CC9A: CE 74 4D       LDU    #$FC65
CC9D: A6 4E          LDA    A,U
CC9F: A7 86          STA    ,Y
CCA1: A7 A3          STA    $1,Y
CCA3: A7 00          STA    $2,Y
CCA5: 39             RTS

CCA6: 8E 7E AF       LDX    #$FC87
CCA9: 10 8E 74 5B    LDY    #$FC73
CCAD: BD 44 BD       JSR    $CC35
CCB0: 8E DE 1F       LDX    #$FC9D
CCB3: 10 8E DE FF    LDY    #$FC7D
CCB7: BD E4 1D       JSR    $CC35
CCBA: 7F BC 79       CLR    $3451
CCBD: 7F BC DA       CLR    $3452
CCC0: 39             RTS

CCC1: 8E B6 E2       LDX    #$3460
CCC4: 86 62          LDA    #$40
CCC6: A7 06          STA    ,X
CCC8: AB 29          ADDA   $1,X
CCCA: A7 89          STA    $1,X
CCCC: 24 3B          BCC    $CCE1
CCCE: 6C 8A          INC    $2,X
CCD0: A6 20          LDA    $2,X
CCD2: 84 81          ANDA   #$03
CCD4: 8E DC 99       LDX    #$FE1B
CCD7: 48             ASLA
CCD8: AE AE          LDX    A,X
CCDA: 10 8E D4 E9    LDY    #$FCC1
CCDE: BD 44 17       JSR    $CC35
CCE1: 39             RTS

CCE2: 8E 7C 51       LDX   #table_fe73
CCE5: 96 A0          LDA    $22
CCE7: 48             ASLA
CCE8: 6E BE          JMP    [A,X]        ; [jump_table]
CCEA: 4F             CLRA
CCEB: BD 66 B2       JSR    queue_event_4e9a
CCEE: 0C AA          INC    $22
CCF0: 39             RTS

CCF1: 8E 7D 19       LDX    #$FF9B
CCF4: 10 8E 7D 28    LDY    #$FFAA
CCF8: BD E6 2C       JSR    $CEA4
CCFB: 0C 0A          INC    $22
CCFD: 39             RTS

CCFE: 96 98          LDA    $10
CD00: 84 26          ANDA   #$04
CD02: 27 81          BEQ    $CD07
CD04: 0C 00          INC    $22
CD06: 39             RTS

CD07: 96 09          LDA    $21
CD09: 8B 89          ADDA   #$01
CD0B: 97 09          STA    $21
CD0D: 25 C7          BCS    $CD5E
CD0F: 39             RTS

CD10: 8E 1D 92       LDX    #$3F10
CD13: CE 1D A2       LDU    #$3F80
CD16: 86 D5          LDA    #$57
CD18: E6 A8          LDB    ,X+
CD1A: E1 48          CMPB   ,U+
CD1C: 26 2D          BNE    $CD23
CD1E: 4A             DECA
CD1F: 26 D5          BNE    $CD18
CD21: 20 88          BRA    $CD2D
CD23: 8E 1D 22       LDX    #$3F00
CD26: 6F 02          CLR    ,X+
CD28: 8C 17 77       CMPX   #$3FFF
CD2B: 23 D1          BLS    $CD26
CD2D: 8E 76 09       LDX    #$FE81
CD30: 10 8E 7C 1C    LDY    #$FE9E
CD34: BD EC 26       JSR    $CEA4
CD37: 8E D6 83       LDX    #$FEAB
CD3A: 10 8E D6 FB    LDY    #$FED3
CD3E: BD 44 17       JSR    $CC35
CD41: 0C A0          INC    $22
CD43: 39             RTS

CD44: DC 31          LDD    $13
CD46: 84 FD          ANDA   #$7F
CD48: C4 57          ANDB   #$7F
CD4A: 10 83 2C 28    CMPD   #$0400
CD4E: 27 8F          BEQ    $CD57
CD50: 10 83 83 82    CMPD   #$0100
CD54: 27 2A          BEQ    $CD5E
CD56: 39             RTS

CD57: 4F             CLRA
CD58: BD 66 12       JSR    queue_event_4e9a
CD5B: 0C 0A          INC    $22
CD5D: 39             RTS

CD5E: 0F A8          CLR    $20
CD60: 0F 00          CLR    $22
CD62: 8E BD 22       LDX    #$3F00
CD65: 6F 02          CLR    ,X+
CD67: 8C 17 D7       CMPX   #$3FFF
CD6A: 23 71          BLS    $CD65
CD6C: 39             RTS

CD6D: CC 89 8A       LDD    #$0102
CD70: FD 1D 82       STD    $3F00
CD73: 8E DC F8       LDX    #$FEDA
CD76: 10 8E D7 6B    LDY    #$FF43
CD7A: BD 46 8C       JSR    $CEA4
CD7D: 8E 77 EA       LDX    #$FF62
CD80: 10 8E 7D 07    LDY    #$FF85
CD84: BD EC 26       JSR    $CEA4
CD87: BD E6 C6       JSR    $CEEE
CD8A: BD 46 45       JSR    $CE6D
CD8D: 20 20          BRA    $CD37
CD8F: 8D 2A          BSR    $CD99
CD91: 8D A3          BSR    $CDB4
CD93: 8D 6C          BSR    $CDE3
CD95: BD 4C B1       JSR    $CE33
CD98: 39             RTS

CD99: 96 98          LDA    $10
CD9B: 84 38          ANDA   #$10
CD9D: 27 9C          BEQ    $CDB3
CD9F: BD EC 74       JSR    $CE56
CDA2: BD 4C 98       JSR    $CEBA
CDA5: BD 4C 16       JSR    $CE94
CDA8: CC 28 88       LDD    #$0000
CDAB: DD 08          STD    $20
CDAD: DD AA          STD    $22
CDAF: DD 06          STD    $24
CDB1: DD A4          STD    $26
CDB3: 39             RTS

CDB4: DC 32          LDD    $10
CDB6: 84 9D          ANDA   #$1F
CDB8: C4 37          ANDB   #$1F
CDBA: 10 83 20 28    CMPD   #$0800
CDBE: 26 AA          BNE    $CDE2
CDC0: BD EC CF       JSR    $CE4D
CDC3: 86 22          LDA    #$00
CDC5: A7 0B 8A 28    STA    $0800,X
CDC9: 0F AB          CLR    $23
CDCB: BD E6 7E       JSR    $CE56
CDCE: 0C AC          INC    $24
CDD0: 96 06          LDA    $24
CDD2: 81 81          CMPA   #$03
CDD4: 25 20          BCS    $CDD8
CDD6: 0F A6          CLR    $24
CDD8: BD E6 E5       JSR    $CE6D
CDDB: 96 0C          LDA    $24
CDDD: 8B 89          ADDA   #$01
CDDF: B7 02 EE       STA    $20CC
CDE2: 39             RTS

CDE3: DC 31          LDD    $13
CDE5: 84 FD          ANDA   #$7F
CDE7: C4 57          ANDB   #$7F
CDE9: 10 83 8C 28    CMPD   #$0400
CDED: 26 8B          BNE    $CDF2
CDEF: 8D 31          BSR    $CE04
CDF1: 39             RTS

CDF2: 10 83 23 22    CMPD   #$0100
CDF6: 26 81          BNE    $CDFB
CDF8: 8D 3F          BSR    $CE11
CDFA: 39             RTS

CDFB: 10 83 2A 88    CMPD   #$0200
CDFF: 26 20          BNE    $CE03
CE01: 8D 9F          BSR    $CE20
CE03: 39             RTS

CE04: 8D 65          BSR    $CE4D
CE06: 6C 06          INC    ,X
CE08: A6 AC          LDA    ,X
CE0A: 81 82          CMPA   #$0A
CE0C: 2D 2A          BLT    $CE10
CE0E: 6F 0C          CLR    ,X
CE10: 39             RTS

CE11: 8D B8          BSR    $CE4D
CE13: 6A A6          DEC    ,X
CE15: A6 06          LDA    ,X
CE17: 81 28          CMPA   #$00
CE19: 2C 7D          BGE    $CE10
CE1B: 86 21          LDA    #$09
CE1D: A7 0C          STA    ,X
CE1F: 39             RTS

CE20: 8D 09          BSR    $CE4D
CE22: 86 82          LDA    #$00
CE24: A7 AB 8A 82    STA    $0800,X
CE28: 0C 0B          INC    $23
CE2A: 96 AB          LDA    $23
CE2C: 81 31          CMPA   #$19
CE2E: 2D 8A          BLT    $CE32
CE30: 0F 01          CLR    $23
CE32: 39             RTS

CE33: 86 62          LDA    #$40
CE35: 9B A7          ADDA   $25
CE37: 97 0D          STA    $25
CE39: 24 99          BCC    $CE4C
CE3B: 8D 38          BSR    $CE4D
CE3D: A6 01 80 22    LDA    $0800,X
CE41: 27 87          BEQ    $CE48
CE43: 6F AB 2A 82    CLR    $0800,X
CE47: 39             RTS

CE48: 6C A1 80 88    INC    $0800,X
CE4C: 39             RTS

CE4D: 8E 77 26       LDX    #$FFAE
CE50: 96 01          LDA    $23
CE52: 48             ASLA
CE53: AE A4          LDX    A,X
CE55: 39             RTS

CE56: 8D AE          BSR    $CE84
CE58: 81 24          CMPA   #$0C
CE5A: 27 83          BEQ    $CE67
CE5C: 10 AE 09       LDY    ,X++
CE5F: E6 86          LDB    ,Y
CE61: E7 42          STB    ,U+
CE63: 4A             DECA
CE64: 26 D0          BNE    $CE58
CE66: 39             RTS

CE67: 80 2C          SUBA   #$04
CE69: 33 CC          LEAU   $4,U
CE6B: 20 C7          BRA    $CE5C
CE6D: 8D 9D          BSR    $CE84
CE6F: 81 2E          CMPA   #$0C
CE71: 27 89          BEQ    $CE7E
CE73: 10 AE A3       LDY    ,X++
CE76: E6 42          LDB    ,U+
CE78: E7 8C          STB    ,Y
CE7A: 4A             DECA
CE7B: 26 DA          BNE    $CE6F
CE7D: 39             RTS

CE7E: 80 8C          SUBA   #$04
CE80: 33 66          LEAU   $4,U
CE82: 20 6D          BRA    $CE73
CE84: 96 06          LDA    $24
CE86: C6 9F          LDB    #$1D
CE88: 3D             MUL
CE89: CE B7 98       LDU    #$3F10
CE8C: 33 ED          LEAU   B,U
CE8E: 8E 77 8C       LDX    #$FFAE
CE91: 86 9F          LDA    #$1D
CE93: 39             RTS

CE94: 8E 1D 92       LDX    #$3F10
CE97: CE 17 A8       LDU    #$3F80
CE9A: 86 DF          LDA    #$57
CE9C: E6 A8          LDB    ,X+
CE9E: E7 48          STB    ,U+
CEA0: 4A             DECA
CEA1: 26 7B          BNE    $CE9C
CEA3: 39             RTS

CEA4: A6 82          LDA    ,Y+
CEA6: 27 93          BEQ    $CEB9
CEA8: EE 89          LDU    ,Y++
CEAA: C6 88          LDB    #$00
CEAC: E7 E1 80 88    STB    $0800,U		;  [video_address]
CEB0: E6 A2          LDB    ,X+
CEB2: E7 42          STB    ,U+		;  [video_address]
CEB4: 4A             DECA
CEB5: 26 71          BNE    $CEAA
CEB7: 20 C3          BRA    $CEA4
CEB9: 39             RTS

CEBA: 8E 88 28       LDX    #$0000
CEBD: CE 88 8D       LDU    #$0005
CEC0: FC 1D 9A       LDD    $3F18
CEC3: 10 83 22 87    CMPD   #$0005
CEC7: 24 2E          BCC    $CECF
CEC9: FF B7 90       STU    $3F18
CECC: BF 17 92       STX    $3F1A
CECF: FC 1D 17       LDD    $3F35
CED2: 10 83 22 27    CMPD   #$0005
CED6: 24 84          BCC    $CEDE
CED8: FF 17 BD       STU    $3F35
CEDB: BF 17 1F       STX    $3F37
CEDE: FC B7 70       LDD    $3F52
CEE1: 10 83 82 27    CMPD   #$0005
CEE5: 24 84          BCC    $CEED
CEE7: FF 17 7A       STU    $3F52
CEEA: BF B7 7C       STX    $3F54
CEED: 39             RTS

CEEE: CC 89 27       LDD    #$0105
CEF1: CE 82 82       LDU    #$0000
CEF4: FD 1D A3       STD    $3F21
CEF7: FF 17 0B       STU    $3F23
CEFA: CC 89 2E       LDD    #$0106
CEFD: CE 8D 88       LDU    #$0500
CF00: FD 1D BC       STD    $3F3E
CF03: FF 1D 62       STU    $3F40
CF06: CC 83 20       LDD    #$0108
CF09: CE 88 88       LDU    #$0000
CF0C: FD 17 D3       STD    $3F5B
CF0F: FF 1D 7F       STU    $3F5D
CF12: 39             RTS
event_table_cf30:
	dc.w	reset_display_41d0	; $cf30
	dc.w	$420e	; $cf32
	dc.w	$4211	; $cf34
	dc.w	$4234	; $cf36
	dc.w	$42a2	; $cf38
	dc.w	draw_chrono_42c0	; $cf3a
	dc.w	$4320	; $cf3c
	dc.w	$4470	; $cf3e
table_d33a:
	dc.w	$45f7	; $d33a
	dc.w	$4602	; $d33c
	dc.w	$46c9	; $d33e
	dc.w	$9276	; $d340
	dc.w	$cce2	; $d342

table_d344:
	dc.w	$9276	; $d344
	dc.w	$7b96	; $d346
	dc.w	$a091	; $d348
	dc.w	$7b96	; $d34a

table_d34c:
	dc.w	$460a	; $d34c
	dc.w	start_game_4673	; $d34e
	dc.w	$96f1	; $d350

table_d352:
	dc.w	$4623	; $d352
	dc.w	$4649	; $d354
	dc.w	$4650	; $d356

table_d358:
	dc.w	$46d1	; $d358
	dc.w	$47d0	; $d35a
	dc.w	$49f3	; $d35c
	dc.w	$4a07	; $d35e
	dc.w	$4cb0	; $d360
	dc.w	$4d08	; $d362
	dc.w	$4e36	; $d364

table_d366:
	dc.w	$46d9	; $d366
	dc.w	$470c	; $d368
	dc.w	$4772	; $d36a

table_d36c:
	dc.w	$46e1	; $d36c
	dc.w	$46fe	; $d36e
table_d377:
	dc.w	$47e1	; $d377
	dc.w	$486c	; $d379
	dc.w	$488c	; $d37b
	dc.w	$48c7	; $d37d
	dc.w	$491f	; $d37f
	dc.w	$4968	; $d381
	dc.w	$499d	; $d383
	dc.w	$49b3	; $d385

table_d387:
	dc.w	$4874	; $d387
	dc.w	$487f	; $d389
table_d39b:
	dc.w	$489d	; $d39b
	dc.w	$48a6	; $d39d
	dc.w	$489d	; $d39f
	dc.w	$48a3	; $d3a1
	dc.w	$48a6	; $d3a3
	dc.w	$48a6	; $d3a5
	dc.w	$48a6	; $d3a7

table_d3a9:
	dc.w	$48b8	; $d3a9
	dc.w	$48c1	; $d3ab
	dc.w	$48b8	; $d3ad
	dc.w	$48c0	; $d3af
	dc.w	$48c1	; $d3b1
	dc.w	$48c1	; $d3b3
	dc.w	$48c1	; $d3b5

event_table_d3b7:
	dc.w	triple_jump_609c	; $d3b7
	dc.w	skeet_shooting_8aaf	; $d3b9
	dc.w	pole_vault_a6d4	; $d3bb
	dc.w	free_style_65b8	; $d3bd
	dc.w	weight_lifting_b3dc	; $d3bf
	dc.w	archery_9a12	; $d3c1
	dc.w	long_horse_6bcc	; $d3c3

table_d3c5:
	dc.w	$4a18	; $d3c5
	dc.w	$c315	; $d3c7
	dc.w	$4a1f	; $d3c9
	dc.w	$4c01	; $d3cb
	dc.w	$4c70	; $d3cd
	dc.w	$4c97	; $d3cf
table_d3df:
	dc.w	$4d10	; $d3df
	dc.w	$4d43	; $d3e1
	dc.w	$4da4	; $d3e3
	dc.w	$4dd1	; $d3e5
	dc.w	$4de6	; $d3e7
	dc.w	$4d43	; $d3e9
	dc.w	$4e09	; $d3eb

table_d3ed:
	dc.w	$4d4b	; $d3ed
	dc.w	$4d98	; $d3ef
	dc.w	$c14d	; $d3f1
	dc.w	$c4d3	; $d3f3
	dc.w	$4e3e	; $d3f5
	dc.w	$4e53	; $d3f7
table_d3f1:
	dc.w	$c14d	; $d3f1
	dc.w	$c4d3	; $d3f3
	dc.w	$4e3e	; $d3f5
	dc.w	$4e53	; $d3f7
table_d405:
	dc.w	$55bf	; $d405
	dc.w	$913e	; $d407
	dc.w	$b3ab	; $d409
	dc.w	$55c2	; $d40b
	dc.w	$bf99	; $d40d
	dc.w	$9de1	; $d40f
	dc.w	$55d5	; $d411
table_d4df:
	dc.w	$60a4	; $d4df
	dc.w	$60ea	; $d4e1
	dc.w	$6126	; $d4e3
	dc.w	$6188	; $d4e5
	dc.w	$623d	; $d4e7
	dc.w	$62ab	; $d4e9
	dc.w	$631b	; $d4eb
	dc.w	$6376	; $d4ed
	dc.w	$6455	; $d4ef
	dc.w	$6536	; $d4f1
table_d4f3:
	dc.w	$60ac	; $d4f3
	dc.w	$60d1	; $d4f5
table_d4f7:
	dc.w	$71c6	; $d4f7
	dc.w	$6248	; $d4f9
table_d507:
	dc.w	$71c6	; $d507
	dc.w	$62b6	; $d509
table_d50b:
	dc.w	$71c6	; $d50b
	dc.w	$6326	; $d50d
table_d50f:
	dc.w	$6381	; $d50f
	dc.w	$63a8	; $d511
	dc.w	$6448	; $d513
table_d515:
	dc.w	$6381	; $d515
	dc.w	$6460	; $d517
	dc.w	$64c4	; $d519
	dc.w	$650d	; $d51b
table_d523:
	dc.w	$6541	; $d523
	dc.w	$6555	; $d525
	dc.w	$6592	; $d527
	dc.w	$650d	; $d529
table_d52b:
	dc.w	$65c0	; $d52b
	dc.w	$6620	; $d52d
	dc.w	$6854	; $d52f
	dc.w	$6ae0	; $d531
	dc.w	$6b02	; $d533

table_d535:
	dc.w	$65c8	; $d535
	dc.w	$6617	; $d537

table_d539:
	dc.w	$662d	; $d539
	dc.w	$663e	; $d53b
	dc.w	$6653	; $d53d
	dc.w	$666e	; $d53f
	dc.w	$66c8	; $d541
	dc.w	$6706	; $d543
	dc.w	$679e	; $d545
	dc.w	$67d9	; $d547
	dc.w	$680b	; $d549
	dc.w	$6815	; $d54b

table_d54d:
	dc.w	$68b3	; $d54d
	dc.w	$68e1	; $d54f
	dc.w	$691e	; $d551
	dc.w	$6953	; $d553
	dc.w	$69c5	; $d555
	dc.w	$69ed	; $d557
	dc.w	$6a13	; $d559
	dc.w	$6adc	; $d55b

table_d55d:
	dc.w	$79eb	; $d55d
	dc.w	$7a10	; $d55f
	dc.w	$7a44	; $d561
	dc.w	$7a78	; $d563

table_d565:
	dc.w	$6b0a	; $d565
	dc.w	$6b4f	; $d567

table_d571:
	dc.w	$6bd7	; $d571
	dc.w	$6c0d	; $d573
	dc.w	$6ca3	; $d575
	dc.w	$6cdd	; $d577
	dc.w	$6d38	; $d579
	dc.w	$6e38	; $d57b
	dc.w	$6f18	; $d57d
	dc.w	$7006	; $d57f
	dc.w	$7074	; $d581
	dc.w	$70ba	; $d583
	dc.w	$710b	; $d585
	dc.w	$7168	; $d587
	dc.w	$7181	; $d589
	dc.w	$7199	; $d58b

table_d58d:
	dc.w	$6bdf	; $d58d
	dc.w	$6bff	; $d58f
table_d591:
	dc.w	$6c15	; $d591
	dc.w	$6c76	; $d593

table_d599:
	dc.w	$6d40	; $d599
	dc.w	$6d65	; $d59b
	dc.w	$6d9e	; $d59d
	dc.w	$6161	; $d59f

table_d5e8:
	dc.w	$700e	; $d5e8
	dc.w	$7041	; $d5ea
table_d5ec:
	dc.w	$7082	; $d5ec
	dc.w	$709c	; $d5ee
	dc.w	$70b1	; $d5f0
table_d605:
	dc.w	$7113	; $d605
	dc.w	$711f	; $d607
table_d609:
	dc.w	$7189	; $d609
	dc.w	$6541	; $d60b
	dc.w	$6555	; $d60d
	dc.w	$6592	; $d60f
	dc.w	$7190	; $d611
table_d613:
	dc.w	$71a1	; $d613
	dc.w	$71a8	; $d615
table_d62a:
	dc.w	$7443	; $d62a
	dc.w	$7443	; $d62c
	dc.w	$7431	; $d62e
	dc.w	$84db	; $d630
	dc.w	$84e0	; $d632
	dc.w	$84e5	; $d634
table_d630:
	dc.w	$84db	; $d630
	dc.w	$84e0	; $d632
	dc.w	$84e5	; $d634
table_d6a8:
	dc.w	$7b9e	; $d6a8
	dc.w	$7bdf	; $d6aa
	dc.w	$7bfd	; $d6ac
table_d6b1:
	dc.w	$46d1	; $d6b1
	dc.w	$47d0	; $d6b3
	dc.w	$49f3	; $d6b5
	dc.w	$4a07	; $d6b7
	dc.w	$4cb0	; $d6b9
table_d82e:
	dc.w	$809d	; $d82e
	dc.w	$8087	; $d830
	dc.w	$809e	; $d832

table_d89a:
	dc.w	$8a35	; $d89a
	dc.w	$8a41	; $d89c
	dc.w	$8a72	; $d89e
	dc.w	$8a7d	; $d8a0
	dc.w	$8aae	; $d8a2
table_ecea:
	dc.w	$8ab7	; $ecea
	dc.w	$8b61	; $ecec
	dc.w	$8b79	; $ecee
	dc.w	$8f7f	; $ecf0

table_ee85:
	dc.w	$928f	; $ee85
	dc.w	$929e	; $ee87
	dc.w	$9431	; $ee89
	dc.w	$95bf	; $ee8b
	dc.w	$9648	; $ee8d
	dc.w	$96d2	; $ee8f
table_ef15:
	dc.w	$96f9	; $ef15
	dc.w	$973b	; $ef17
	dc.w	$99d9	; $ef19
	dc.w	$8a2d	; $ef1b
table_efb8:
	dc.w	$9a1a	; $efb8
	dc.w	$9a9d	; $efba
	dc.w	$9b2a	; $efbc
	dc.w	$a054	; $efbe
	dc.w	$a998	; $efc0
	dc.w	$7765	; $efc2
	dc.w	$5443	; $efc4
table_f096:
	dc.w	$a0ac	; $f096
	dc.w	$a0cd	; $f098
	dc.w	$a33a	; $f09a
	dc.w	$a36c	; $f09c
table_f263:
	dc.w	$a39a	; $f263
	dc.w	$a3ba	; $f265
	dc.w	$a584	; $f267
	dc.w	$a5cd	; $f269
	dc.w	$a5fe	; $f26b
table_f2ff:
	dc.w	$a6dc	; $f2ff
	dc.w	$a8d7	; $f301
	dc.w	$a98b	; $f303
	dc.w	$aa9e	; $f305
	dc.w	$ad67	; $f307
	dc.w	$ad98	; $f309
	dc.w	$ae4f	; $f30b
table_f30d:
	dc.w	$a6e4	; $f30d
	dc.w	$a882	; $f30f
	dc.w	$a993	; $f311
	dc.w	$a9dd	; $f313
	dc.w	$aa8f	; $f315
table_f311:
	dc.w	$a993	; $f311
	dc.w	$a9dd	; $f313
	dc.w	$aa8f	; $f315
table_f533:
	dc.w	$b3e4	; $f533
	dc.w	$b788	; $f535
	dc.w	$ba9e	; $f537
	dc.w	$bae6	; $f539
	dc.w	$baf9	; $f53b
	dc.w	$ba0e	; $f53d
table_f53f:
	dc.w	$b3ec	; $f53f
	dc.w	$b46c	; $f541
	dc.w	$b4e2	; $f543
	dc.w	$b592	; $f545
	dc.w	$b5f7	; $f547
	dc.w	$b665	; $f549
	dc.w	$b603	; $f54b
	dc.w	$b76b	; $f54d
table_f68c:
	dc.w	$b825	; $f68c
	dc.w	$b963	; $f68e
	dc.w	$ba45	; $f690
	dc.w	$ba4c	; $f692

table_f7d9:
	dc.w	$bd9c	; $f7d9
	dc.w	$bd9c	; $f7db
	dc.w	$bdb7	; $f7dd
	dc.w	$bd9c	; $f7df
	dc.w	$bd9c	; $f7e1
	dc.w	$bda5	; $f7e3
	dc.w	$bdc0	; $f7e5
	dc.w	$bdc0	; $f7e7
	dc.w	$bda5	; $f7e9
	dc.w	$bdc0	; $f7eb
	dc.w	$bd9c	; $f7ed
	dc.w	$bd9c	; $f7ef
	dc.w	$bdae	; $f7f1
table_f810:
	dc.w	$bea1	; $f810
	dc.w	$bf07	; $f812
	dc.w	$bed4	; $f814
	dc.w	$686f	; $f816
table_f8d5:
	dc.w	$c155	; $f8d5
	dc.w	$c1a1	; $f8d7
	dc.w	$c1c3	; $f8d9
	dc.w	$c28b	; $f8db
table_f8dd:
	dc.w	$c335	; $f8dd
	dc.w	$c335	; $f8df
	dc.w	$c327	; $f8e1
	dc.w	$c39a	; $f8e3
	dc.w	$c327	; $f8e5
	dc.w	$c335	; $f8e7
	dc.w	$c335	; $f8e9
table_f8eb:
	dc.w	$c35c	; $f8eb
	dc.w	$c418	; $f8ed
	dc.w	$c465	; $f8ef
	dc.w	$c39a	; $f8f1
	dc.w	$c37f	; $f8f3
	dc.w	$c418	; $f8f5
	dc.w	$c465	; $f8f7
	dc.w	$a18f	; $f8f9
	dc.w	$8bcb	; $f8fb

table_f903:
	dc.w	$c4db	; $f903
	dc.w	$c58a	; $f905
	dc.w	$c5a8	; $f907
	dc.w	$c5fc	; $f909
	dc.w	$c6d6	; $f90b
table_f90d:
	dc.w	$5d09	; $f90d
	dc.w	$489a	; $f90f
	dc.w	$48ae	; $f911
	dc.w	$c596	; $f913
table_f915:
	dc.w	$c712	; $f915
	dc.w	$c72f	; $f917
	dc.w	$c72f	; $f919
	dc.w	$c72f	; $f91b
	dc.w	$c72f	; $f91d
	dc.w	$647c	; $f91f
table_f931:
	dc.w	$c761	; $f931
	dc.w	$c7bf	; $f933
	dc.w	$c7bf	; $f935
	dc.w	$c7bf	; $f937
	dc.w	$c7bf	; $f939
table_f93b:
	dc.w	$c7c7	; $f93b
	dc.w	$c7fc	; $f93d
	dc.w	$c87b	; $f93f
	dc.w	$c87e	; $f941
	dc.w	$c8e2	; $f943
	dc.w	$c8ff	; $f945
	dc.w	$c936	; $f947
	dc.w	$c94d	; $f949
	dc.w	$c98e	; $f94b
	dc.w	$c993	; $f94d
table_f94f:
	dc.w	$c9a3	; $f94f
	dc.w	$c9a5	; $f951
	dc.w	$c9d6	; $f953
	dc.w	$ca79	; $f955
	dc.w	$ca98	; $f957
table_f959:
	dc.w	$ca33	; $f959
	dc.w	$ca68	; $f95b
	dc.w	$ca79	; $f95d
	dc.w	$ca98	; $f95f
table_fe73:
	dc.w	$ccea	; $fe73
	dc.w	$ccf1	; $fe75
	dc.w	$ccfe	; $fe77
	dc.w	$cd10	; $fe79
	dc.w	$cd44	; $fe7b
	dc.w	$cd6d	; $fe7d
	dc.w	$cd8f	; $fe7f

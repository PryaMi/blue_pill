cmake_minimum_required(VERSION 3.21)

#before project() command setup cross-toolchain

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_C_COMPILER arm-none-eabi-gcc)

set(CMAKE_C_FLAGS "-mthumb -mcpu=cortex-m3 -nostdlib -g")


project("blue_pill" LANGUAGES C ASM)

#project settings:

set(TARG_NAME app)

set(LINK_SCRIPT ${CMAKE_SOURCE_DIR}/linker.ld)

set(CMAKE_EXE_LINKER_FLAGS "-T ${LINK_SCRIPT}")

# order is important!!!
add_executable(${TARG_NAME}.elf 
	${CMAKE_SOURCE_DIR}/crt.s
	${CMAKE_SOURCE_DIR}/main.c
	)

add_custom_command(TARGET ${TARG_NAME}.elf
	POST_BUILD
	COMMAND "${CMAKE_OBJCOPY}" ARGS -O binary ${TARG_NAME}.elf ${TARG_NAME}.bin)





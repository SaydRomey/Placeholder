/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   minilibx.h                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/22 11:48:09 by cdumais           #+#    #+#             */
/*   Updated: 2024/02/22 11:49:00 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

/* hooks and events */
// 
# define KEY_PRESS			2
# define KEY_RELEASE		3
# define MOUSE_PRESS		4
# define MOUSE_RELEASE		5
# define MOUSE_MOVE			6
# define DESTROY			17
# define KEY_PRESS_MASK		(1L<<0)
# define KEY_RELEASE_MASK	(1L<<1)
# define MOUSE_MOVE_MASK	(1L<<6)

// keys linux
# define ESC 65307

# define W 119
# define A 97
# define S 115
# define D 100

# define UP 65362
# define LEFT 65361
# define DOWN 65364
# define RIGHT 65363

# define PLUS 61
# define MINUS 45

# define BACKSPACE 65288
# define SPACE 32

# define K_0  48
# define K_1  49
# define K_2  50
# define K_3  51
# define K_4  52
# define K_5  53
# define K_6  54
# define K_7  55
# define K_8  56
# define K_9  57

// # define A 97
# define B 98
# define C 99
// # define D 100
# define E 101
# define F 102
# define G 103
# define H 104
# define I 105
# define J 106
# define K 107
# define L 108
# define M 109
# define N 110
# define O 111
# define P 112
# define Q 113
# define R 114
// # define S 115
# define T 116
# define U 117
# define V 118
// # define W 119
# define X 120
# define Y 121
# define Z 122

// mouse

# define L_CLICK		1
# define R_CLICK		3
# define SCROLL_UP		4
# define SCROLL_DOWN	5

// keys mac
# define ESC 53

# define W 13
# define A 0
# define S 1
# define D 2

# define UP 126
# define DOWN 125
# define LEFT 123
# define RIGHT 124

# define PLUS 24
# define MINUS 27

# define BACKSPACE 51
# define SPACE 49

# define K_0 29
# define K_1 18
# define K_2 19
# define K_3 20
# define K_4 21
# define K_5 23
# define K_6 22
# define K_7 26
# define K_8 28
# define K_9 25

// # define A 0
# define B 11
# define C 8
// # define D 2
# define E 14
# define F 3
# define G 5
# define H 4
# define I 34
# define J 38
# define K 40
# define L 37
# define M 46
# define N 45
# define O 31
# define P 35
# define Q 12
# define R 15
// # define S 1
# define T 17
# define U 32
# define V 9
// # define W 13
# define X 7
# define Y 16
# define Z 6

// mouse

# define L_CLICK		1
# define R_CLICK		2
# define SCROLL_UP		4
# define SCROLL_DOWN	5
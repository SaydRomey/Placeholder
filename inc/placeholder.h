/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   placeholder.h                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/11/20 22:07:45 by cdumais           #+#    #+#             */
/*   Updated: 2024/02/22 11:45:23 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef PLACEHOLDER_H
# define PLACEHOLDER_H

# include "libft.h"

/* bytes per pixel */
# define PIXEL_SIZE		4

# define ALPHA_MASK		0xFF000000
# define RED_MASK		0x00FF0000
# define GREEN_MASK		0x0000FF00
# define BLUE_MASK		0x000000FF

# define ALPHA_SHIFT	24
# define RED_SHIFT		16
# define GREEN_SHIFT	8
// No shift needed for BLUE

typedef enum
{
	ALPHA_OFFSET = 0,
	RED_OFFSET,
	GREEN_OFFSET,
	BLUE_OFFSET
}	e_color_offset;

# define HEX_BLACK			0x000000
# define HEX_GRAY			0x404040
# define HEX_WHITE			0xFFFFFF
# define HEX_RED			0xFF0000
# define HEX_GREEN			0x00FF00
# define HEX_BLUE			0x0000FF
# define HEX_YELLOW			0xFFFF00
# define HEX_MAGENTA		0xFF00FF //bright on mac
# define HEX_CYAN			0x00FFFF

# define HEX_ORANGE 		0xFF7700 //best orange on mac
# define HEX_ORANGEY		0xED840C //between orange and yellow on mac
# define HEX_PURPLE			0x800080 //weak on MAC
# define HEX_OLILAS			0xA27CF1 //bluish purple on mac
# define HEX_PINK			0xFFC0CB //pale pink on mac
# define HEX_BROWN			0x663300 //weak dark orange on mac

void	_here(char *file, int line);

char	*ft_uname(char **envp);

#endif

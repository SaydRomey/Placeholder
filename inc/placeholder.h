/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   placeholder.h                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/11/20 22:07:45 by cdumais           #+#    #+#             */
/*   Updated: 2024/05/09 20:36:40 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef PLACEHOLDER_H
# define PLACEHOLDER_H

# include <math.h>
# include <stdbool.h>
# include <sys/errno.h>
# include <sys/types.h>
# include <sys/wait.h>

# include "libft.h"
# include "MLX42.h"

# define PI			3.1415926535
# define ISO_ANGLE	0.523599

/* ************************************************************************** */
typedef struct s_point
{
	int	x;
	int	y;
}		t_point;

typedef struct s_fpoint
{
	float	x;
	float	y;
}		t_fpoint;

/* ************************************************************************** */
typedef struct s_circle
{
	t_fpoint	origin;
	int			radius;
	int			color;
}				t_circle;

typedef struct s_triangle
{
	float		half_base;
	float		height;
	t_point		centroid;
	t_fpoint	front;
	t_fpoint	left;
	t_fpoint	right;
	t_fpoint	base_center;
}				t_triangle;

/* ************************************************************************** */
void	draw_pixel(mlx_image_t *img, int x, int y, int color);
/* ************************************************************************** */

void	check_size(void);
void	_here(char *file, int line);
char	*ft_uname(char **envp);
int		n_in_array(int **array, int width, int height, int value_to_find);
float	round_to_increment(float number, float increment);
float	calculate_pay(float hours_worked);
void	print_salary_estimate(float hours_worked);
void	test_toggle(void);

#endif

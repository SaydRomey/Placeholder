/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   n_in_array.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/05/09 19:59:57 by cdumais           #+#    #+#             */
/*   Updated: 2024/05/09 20:00:14 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "placeholder.h"

int	n_in_array(int **array, int width, int height, int value_to_find)
{
	int	y;
	int	x;
	int	count;
	
	count = 0;
	y = 0;
	while (y < height)
	{
		x = 0;
		while (x < width)
		{
			if (array[y][x] == value_to_find)
			{
				count++;
			}
			x++;
		}
		y++;
	}
	return (count);
}

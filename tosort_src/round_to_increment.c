/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   round_to_increment.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/03/31 18:01:02 by cdumais           #+#    #+#             */
/*   Updated: 2024/03/31 18:16:19 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "placeholder.h"

float	round_to_increment(float number, float increment)
{
	float	ratio;
	int		rounded_ratio;
	float	rounded_number;

	if (increment <= 0.0f) // || increment > number) ?
	{
		// ft_printf("Error: Increment must be positive.\n");
		return (-1);
	}
	ratio = number / increment;
	rounded_ratio = (int)(ratio + 0.5f);
	rounded_number = rounded_ratio * increment;
	return (rounded_number);
}

/*
int	main(void)
{
	float	number = 20.58f;
	float	increment = 0.25f; // the increment to which we want to round
	float	rounded_number = round_to_increment(number, increment);
	
	if (rounded_number >= 0)
	{
		printf("Original Number: %.2f, Rounded to %.2f Increment: %.2f\n",
				number, increment, rounded_number);
	}

	return (0);
}
*/

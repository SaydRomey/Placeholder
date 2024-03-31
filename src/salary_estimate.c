/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   salary_estimate.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/03/31 17:02:15 by cdumais           #+#    #+#             */
/*   Updated: 2024/03/31 18:14:25 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "placeholder.h"

#define HOURLY_WAGE 22
#define	INCREMENT	0.25f

// Helper function to round to the nearest .25 increment
static float	adjust_hours(float hours)
{
	int		whole_part;
	float	fraction_part;

	whole_part = (int)hours;
	fraction_part = hours - whole_part;
	if (fraction_part < 0.125)
	{
		fraction_part = 0.0;
	}
	else if (fraction_part < 0.375)
	{
		fraction_part = 0.25;
	}
	else if (fraction_part < 0.625)
	{
		fraction_part = 0.5;
	}
	else if (fraction_part < 0.875)
	{
		fraction_part = 0.75;
	}
	else
	{
		fraction_part = 1.0;
		whole_part++; //increase the whole part if rounding up
	}
	return (whole_part + fraction_part);
}

float	calculate_pay(float hours_worked)
{
	return (adjust_hours(hours_worked) * HOURLY_WAGE);
	// return (round_to_increment(hours_worked, INCREMENT) * HOURLY_WAGE); //testing a more generic function
}

void	print_salary_estimate(float hours_worked)
{
	float	adjusted_hours;
	
	if (hours_worked < 0)
	{
		ft_printf("Please enter a positive number for hours.\n");
		return ;
	}
	adjusted_hours = adjust_hours(hours_worked);
	printf("Adjusted Hours: %.2f\n", adjusted_hours);
	printf("Estimated pay: $%.2f\n", calculate_pay(hours_worked));
}

/*
int	main(int argc, char *argv[])
{
	float	hours_worked;
	float	adjusted_hours;

	if (argc != 2)
	{
		ft_printf("Usage: %s <hours_worked>\nPlease enter hours worked\n", argv[0]);
		return (1);
	}
	hours_worked = atof(argv[1]);
	if (hours_worked < 0)
	{
		ft_printf("Please enter a positive number for hours.\n");
		return (1);
	}
	adjusted_hours = adjust_hours(hours_worked);
	printf("Adjusted Hours: %.2f\n", adjusted_hours);
	printf("Estimated pay: $%.2f\n", calculate_pay(hours_worked));
	return (0);
}
*/

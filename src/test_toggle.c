/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_toggle.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/03/31 17:50:43 by cdumais           #+#    #+#             */
/*   Updated: 2024/03/31 17:52:13 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "placeholder.h"

void	toggle(int *choice)
{
	if (*choice == ON)
		*choice = OFF;
	else
		*choice = ON;
}

void	toggle_bool(bool *choice)
{
	if (*choice == ON)
		*choice = OFF;
	else
		*choice = ON;
}

void	test_toggle(void)
{
	char	*choicestr = NULL;
	int		i = 0;

	// int		choice = ON;
	bool	choice = ON;

	if (choice != ON && choice != OFF)
	{
		ft_printf("invalid choice\n");
		return;
		// return ((void)ft_printf("invalid choice\n")); //to test
	}
	while (i < 10)
	{
		if (choice == ON)
			choicestr = "On !";
		else
			choicestr = "Off !";
		ft_printf("%d means %s\n", choice, choicestr);
		// toggle(&choice);
		toggle_bool(&choice);
		i++;
	}
	ft_putchar('\n');
}

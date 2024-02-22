/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/11/20 22:08:14 by cdumais           #+#    #+#             */
/*   Updated: 2024/02/21 16:36:23 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "placeholder.h"
#include <stdbool.h>

void	ft_testing(void)
{
	_here(__FILE__, __LINE__);
	_here(__FILE__, __LINE__);
}

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

int		main(int argc, char **argv, char **envp)
{
	(void)argc;
	(void)argv;
	// 
	ft_testing();
	// 
	ft_uname(envp);
	// 
	test_toggle();
	// 
	printf("Size of a bool: %zu\n", sizeof(bool));
	printf("Size of an int: %zu\n", sizeof(int));
	// 
	return (0);
}

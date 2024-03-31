/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/11/20 22:08:14 by cdumais           #+#    #+#             */
/*   Updated: 2024/03/31 18:23:43 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "placeholder.h"

void	ft_testing(void);

int		main(int argc, char **argv, char **envp)
{
	(void)argc;
	(void)argv;

	ft_testing();
	// 
	ft_printf("Operating system: ");
	ft_uname(envp);
	// 
	// test_toggle();
	// 
	print_salary_estimate(20.5f);
	// 
	return (0);
}







void	ft_testing(void)
{
	_here(__FILE__, __LINE__);
}

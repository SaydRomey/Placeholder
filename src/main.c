/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/11/20 22:08:14 by cdumais           #+#    #+#             */
/*   Updated: 2024/02/12 17:15:59 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "placeholder.h"

void	ft_testing(void)
{
	_here(__FILE__, __LINE__);
	_here(__FILE__, __LINE__);
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
	return (0);
}

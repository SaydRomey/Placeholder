/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_here.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/12/08 22:54:50 by cdumais           #+#    #+#             */
/*   Updated: 2024/02/05 13:36:32 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "placeholder.h"

/*
for testing purposes
**(usage: _here(__FILE__, __LINE__);*
*/
void	_here(char *file, int line)
{
	ft_printf("HERE (%s, l.%d)\n", file, line);
}

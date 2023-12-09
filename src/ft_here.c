/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_here.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/12/08 22:54:50 by cdumais           #+#    #+#             */
/*   Updated: 2023/12/08 22:56:49 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "placeholder.h"

/*
for testing purposes
**(usage: here(__FILE__, __LINE__);*
*/
void	ft_here(char *file, int line)
{
	printf("HERE (%s, l.%d)\n", file, line);
}

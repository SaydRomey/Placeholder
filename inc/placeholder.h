/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   placeholder.h                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: cdumais <cdumais@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/11/20 22:07:45 by cdumais           #+#    #+#             */
/*   Updated: 2024/03/31 18:21:19 by cdumais          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef PLACEHOLDER_H
# define PLACEHOLDER_H

# include <stdbool.h>
# include <sys/errno.h>
# include <sys/types.h>
# include <sys/wait.h>

# include "libft.h"

/* ************************************************************************** */

void	check_size(void);
void	_here(char *file, int line);

char	*ft_uname(char **envp);

float	round_to_increment(float number, float increment);

float	calculate_pay(float hours_worked);
void	print_salary_estimate(float hours_worked);

void	test_toggle(void);

#endif

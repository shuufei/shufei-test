import React from 'react';
import styled from 'styled-components';
import TodoList from './components/TodoList';
import { Todo } from '../redux/reducers/todos';
import AddTodoForm from './components/AddTodoFormContainer';
import * as Reducer from './Reducer';

export type Props = {
  className?: string;
  unDoneTasks: Todo[];
  doneTasks: Todo[];
}

export const TodosDispatch: React.Context<React.Dispatch<Reducer.Action>> = React.createContext((v: Reducer.Action) => {});


const View: React.FC<Props> = function({ className, unDoneTasks, doneTasks }) {

  // const [state, dispatch] = useReducer(Reducer.reducer, Reducer.initialState);

  return (
      <div className={className}>
        <AddTodoForm></AddTodoForm>

        <div className="todo-list-wrapper">
          <div className="todo-list">
            <h2>Tasks</h2>
            <TodoList todos={unDoneTasks}></TodoList>
          </div>
          <div className="todo-list">
            <h2>Done</h2>
            <TodoList todos={doneTasks}></TodoList>
          </div>
        </div>

      </div>
  );
};

export default styled(View)`
  padding: 16px 24px;
  > .todo-list-wrapper {
    display: flex;
    justify-content: center;
    > .todo-list {
      flex: 1;
      margin: 0 16px;
    }
  }
`;
